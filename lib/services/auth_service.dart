// ignore_for_file: deprecated_member_use

import 'package:auth_prime/general_providers.dart';
import 'package:auth_prime/timer_hook.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseAuthenticationService {
  Stream<User?> get userChanges;
  Future<void> signInWithPhone(String phone, BuildContext context);
  User getCurrentUser();
  String getCurrentUID();
  Future<void> signOut();
}

final authenticationServiceProvider =
    Provider<AuthenticationService>((ref) => AuthenticationService(ref.read));

class AuthenticationService implements BaseAuthenticationService {
  final Reader _read;

  const AuthenticationService(this._read);

  @override
  String getCurrentUID() => _read(firebaseAuthProvider).currentUser!.uid;

  @override
  User getCurrentUser() => _read(firebaseAuthProvider).currentUser!;

  @override
  Future<void> signInWithPhone(String phone, BuildContext context) async {
    try {
      _read(firebaseAuthProvider).verifyPhoneNumber(
        phoneNumber: "+91" + phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          await _read(firebaseAuthProvider).signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException exception) {
          Fluttertoast.showToast(
            msg: exception.toString().length > 35
                ? exception.toString().substring(0, 35) + "..."
                : exception.toString() + " ...",
          );
        },
        codeSent: (String verificationId, int? forceResendingToken) async {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return OtpDialogue(
                  verificationID: verificationId,
                  phoneNumber: phone,
                );
              });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      // ignore: empty_catches
    } on FirebaseAuthException {}
  }

  @override
  Future<void> signOut() => _read(firebaseAuthProvider).signOut();

  @override
  Stream<User?> get userChanges => _read(firebaseAuthProvider).userChanges();
}

class OtpDialogue extends HookConsumerWidget {
  final String verificationID, phoneNumber;
  const OtpDialogue({
    Key? key,
    required this.verificationID,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticker = useInfiniteTimer();
    final _codeController = useTextEditingController();
    return AlertDialog(
      title: Text("Enter the OTP?"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
              "This Window will close in ${ticker.toString()} seconds:"), ////////////////
          SizedBox(height: 5),
          TextField(
            keyboardType: TextInputType.phone,
            controller: _codeController,
            decoration: InputDecoration(
              // helperText: 'OTP',
              focusColor: Colors.red,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Colors.black, //0xffF14C37
                  width: 1.7,
                ),
              ),
              hintText: "Enter Code here",
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.red),
          ),
        ),
        FlatButton(
          child: Text("Confirm"),
          textColor: Colors.white,
          color: Colors.red,
          onPressed: () async {
            final code = _codeController.text.trim();
            AuthCredential credential = PhoneAuthProvider.credential(
                verificationId: verificationID, smsCode: code);

            await ref
                .read(firebaseAuthProvider)
                .signInWithCredential(credential)
                .then((value) {
              Navigator.pop(context);
              return value;
            }).catchError((error) {
              Navigator.pop(context);
              Fluttertoast.showToast(msg: "Some Error Occurred");
            });
          },
        )
      ],
    );
  }
}

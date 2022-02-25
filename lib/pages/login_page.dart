import 'package:auth_prime/services/auth_service.dart';
import 'package:auth_prime/services/local_db_service.dart';
import 'package:auth_prime/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _phoneNumber = useTextEditingController();
    final _userName = useTextEditingController();
    final _isLoading = useState(false);
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      // onTap: () {
      //   FocusScope.of(context).unfocus();
      // },
      child: _isLoading.value
          ? Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              // resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        child: Text(
                          "Auth Prime",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Name",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            RoundedTextField(
                              controller: _userName,
                              hintText: 'Enter your Name',
                              secureIt: false,
                              icon: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              keyboardType: TextInputType.name,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Phone Number",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            RoundedTextField(
                              controller: _phoneNumber,
                              hintText: 'Enter your Phone Number',
                              secureIt: false,
                              icon: Icon(
                                Icons.phone,
                                color: Colors.black,
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 30,
                            right: 30,
                            bottom: 15,
                            top: 10,
                          ),
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            color: Colors.red,
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: const [
                                // ignore: use_full_hex_values_for_flutter_colors
                                Color(0xff1ee1d72),
                                Color(0xffF14C37),
                              ],
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.lock_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Log in Securely',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        onTap: () async {
                          final phone = _phoneNumber.text.trim();
                          final name = _userName.text.trim();
                          if (name.isNotEmpty && phone.isNotEmpty) {
                            await ref.read(localDBProvider).setUserName(name);
                            await ref
                                .read(authenticationServiceProvider)
                                .signInWithPhone(phone, context);
                          } else {
                            Fluttertoast.showToast(
                                msg: "Fields can not be empty");
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

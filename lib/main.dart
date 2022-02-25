import 'package:auth_prime/custom_exception.dart';
import 'package:auth_prime/pages/homepage.dart';
import 'package:auth_prime/pages/login_page.dart';
import 'package:auth_prime/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

final authStreamProvider = StreamProvider.autoDispose<User?>((ref) {
  ref.maintainState = true;

  final userStream = ref.read(authenticationServiceProvider).userChanges;

  return userStream;
});

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthWrapper(),
    );
  }
}

class AuthWrapper extends HookConsumerWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _userAuthState = ref.watch(authStreamProvider);

    return _userAuthState.when(
      data: (data) {
        if (data != null) {
          return HomePage();
        } else {
          return LoginPage();
        }
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (error, _) => Text(error is CustomException
          ? error.message!
          : "Something Went wrong, try again"),
    );
  }
}

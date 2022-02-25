// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAn9YwaljGpQtqe-ivXfWEDwncC9Dw4PLE',
    appId: '1:476054852982:web:1fe8504674190245b71657',
    messagingSenderId: '476054852982',
    projectId: 'authprime-2989d',
    authDomain: 'authprime-2989d.firebaseapp.com',
    storageBucket: 'authprime-2989d.appspot.com',
    measurementId: 'G-M2WVNX6YW9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAokuzXyD6COJTEl1oUZU2QyIswBJnOko4',
    appId: '1:476054852982:android:c71eb3ee8e621bd9b71657',
    messagingSenderId: '476054852982',
    projectId: 'authprime-2989d',
    storageBucket: 'authprime-2989d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCAnK6xEwMPd_AkGTuke5mQvTbbeVfPbMM',
    appId: '1:476054852982:ios:b56869586e085fdbb71657',
    messagingSenderId: '476054852982',
    projectId: 'authprime-2989d',
    storageBucket: 'authprime-2989d.appspot.com',
    iosClientId: '476054852982-o80urte9hb9k5cmb2f6ro0j6g8d31o6e.apps.googleusercontent.com',
    iosBundleId: 'com.rogers.authprime',
  );
}

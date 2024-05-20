// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBqbtFLlkc3GTR_4U8zygddQ0aAHHR68ZA',
    appId: '1:944293605813:web:3e8d35175fec2f8b0de9fc',
    messagingSenderId: '944293605813',
    projectId: 'coursework-30a69',
    authDomain: 'coursework-30a69.firebaseapp.com',
    storageBucket: 'coursework-30a69.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDAumcRLdg-N32K80geUYx9L4GT1MP2v1g',
    appId: '1:944293605813:android:5811f129fcdb4b680de9fc',
    messagingSenderId: '944293605813',
    projectId: 'coursework-30a69',
    storageBucket: 'coursework-30a69.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAPc-qvbT8yzv_0zpsaXjmnRndrt1uh8ek',
    appId: '1:944293605813:ios:5b2348f0fb72f4c60de9fc',
    messagingSenderId: '944293605813',
    projectId: 'coursework-30a69',
    storageBucket: 'coursework-30a69.appspot.com',
    iosBundleId: 'com.example.courseWork',
  );
}
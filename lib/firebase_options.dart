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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyCkTGxSoo6uR69UDJiJaE2YLI2BDgDGvJM',
    appId: '1:1066996917852:web:36773d9fc202e8f2b9a899',
    messagingSenderId: '1066996917852',
    projectId: 'galal-f8ca9',
    authDomain: 'galal-f8ca9.firebaseapp.com',
    storageBucket: 'galal-f8ca9.appspot.com',
    measurementId: 'G-GK9FW3SPG4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBhhVTfHj6BvYVmHZ5kys5-jJKV2XfdOOE',
    appId: '1:1066996917852:android:93bcede983eb9d93b9a899',
    messagingSenderId: '1066996917852',
    projectId: 'galal-f8ca9',
    storageBucket: 'galal-f8ca9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBbR31ryqdSIU9-LoT0Kk4mQMkvSnDKBe8',
    appId: '1:1066996917852:ios:a63ef9f9aaeb7ef1b9a899',
    messagingSenderId: '1066996917852',
    projectId: 'galal-f8ca9',
    storageBucket: 'galal-f8ca9.appspot.com',
    iosBundleId: 'com.softforge.galal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBbR31ryqdSIU9-LoT0Kk4mQMkvSnDKBe8',
    appId: '1:1066996917852:ios:a63ef9f9aaeb7ef1b9a899',
    messagingSenderId: '1066996917852',
    projectId: 'galal-f8ca9',
    storageBucket: 'galal-f8ca9.appspot.com',
    iosBundleId: 'com.softforge.galal',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCkTGxSoo6uR69UDJiJaE2YLI2BDgDGvJM',
    appId: '1:1066996917852:web:b9855ded25afc7eab9a899',
    messagingSenderId: '1066996917852',
    projectId: 'galal-f8ca9',
    authDomain: 'galal-f8ca9.firebaseapp.com',
    storageBucket: 'galal-f8ca9.appspot.com',
    measurementId: 'G-KYP1REDXD6',
  );
}

// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyBm3nO8pZaY676NlXmmaaTsO9rF6K-WLIg',
    appId: '1:809696400825:web:fc906c8e2800c8c448d268',
    messagingSenderId: '809696400825',
    projectId: 'loan-management-d2dd0',
    authDomain: 'loan-management-d2dd0.firebaseapp.com',
    storageBucket: 'loan-management-d2dd0.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAWbXb4GavUugybUgAjLHZ_tgqV360hIQM',
    appId: '1:809696400825:android:0bbda5105c8e429348d268',
    messagingSenderId: '809696400825',
    projectId: 'loan-management-d2dd0',
    storageBucket: 'loan-management-d2dd0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAYrm49xL3x1BdCA-4bU9lbAEV0BMaOXWU',
    appId: '1:809696400825:ios:cb962dac6491464548d268',
    messagingSenderId: '809696400825',
    projectId: 'loan-management-d2dd0',
    storageBucket: 'loan-management-d2dd0.appspot.com',
    iosBundleId: 'com.example.lendingManagement',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAYrm49xL3x1BdCA-4bU9lbAEV0BMaOXWU',
    appId: '1:809696400825:ios:3dff665e218f955f48d268',
    messagingSenderId: '809696400825',
    projectId: 'loan-management-d2dd0',
    storageBucket: 'loan-management-d2dd0.appspot.com',
    iosBundleId: 'com.example.lendingManagement.RunnerTests',
  );
}

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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBfjgH6jQ-I4xhO1--I3whoCduJcLqK2_o',
    appId: '1:1089832021850:android:0dbb9d67d95d565c7c4d63',
    messagingSenderId: '1089832021850',
    projectId: 'paycutter-1e395',
    storageBucket: 'paycutter-1e395.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBghckUAyw8uwaXJd6En2j9buSXPC9vf0A',
    appId: '1:1089832021850:ios:6c0da74e85c4ee3a7c4d63',
    messagingSenderId: '1089832021850',
    projectId: 'paycutter-1e395',
    storageBucket: 'paycutter-1e395.appspot.com',
    androidClientId: '1089832021850-ealsnc1ivu18d8ehc8tvljnrvn06qdua.apps.googleusercontent.com',
    iosClientId: '1089832021850-ue4om9a9rm38k02brbk6g4qlriqjvo5f.apps.googleusercontent.com',
    iosBundleId: 'com.example.moneyDivider',
  );
}
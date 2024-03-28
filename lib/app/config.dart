// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class FirebaseConfig {
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
    apiKey: 'AIzaSyA7HKPFFiIkT6e9t2c5xaUiIcyCwU-v6X4',
    appId: '1:922702762472:web:d6d3d93b3f5e1cc4f1d45d',
    messagingSenderId: '922702762472',
    projectId: 'project-social-3c0f3',
    authDomain: 'project-social-3c0f3.firebaseapp.com',
    databaseURL: 'https://project-social-3c0f3-default-rtdb.firebaseio.com',
    storageBucket: 'project-social-3c0f3.appspot.com',
    measurementId: 'G-S9B2QLSLZV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA-BSzM7IUBwQPysa99X2qi6yy6U12NTKU',
    appId: '1:922702762472:android:a6fc58cee3b07bf5f1d45d',
    messagingSenderId: '922702762472',
    projectId: 'project-social-3c0f3',
    databaseURL: 'https://project-social-3c0f3-default-rtdb.firebaseio.com',
    storageBucket: 'project-social-3c0f3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC58SN-K-kyDBGDJC1Hq4metzpd9WQwWqc',
    appId: '1:922702762472:ios:81d6651584bca871f1d45d',
    messagingSenderId: '922702762472',
    projectId: 'project-social-3c0f3',
    databaseURL: 'https://project-social-3c0f3-default-rtdb.firebaseio.com',
    storageBucket: 'project-social-3c0f3.appspot.com',
    iosBundleId: 'com.example.projectSocial',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC58SN-K-kyDBGDJC1Hq4metzpd9WQwWqc',
    appId: '1:922702762472:ios:9457c5ffc35592ebf1d45d',
    messagingSenderId: '922702762472',
    projectId: 'project-social-3c0f3',
    databaseURL: 'https://project-social-3c0f3-default-rtdb.firebaseio.com',
    storageBucket: 'project-social-3c0f3.appspot.com',
    iosBundleId: 'com.example.projectSocial.RunnerTests',
  );
}

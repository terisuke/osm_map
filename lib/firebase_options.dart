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
    apiKey: 'AIzaSyA1SLxUPvj6AHNdh7A7qur03gRGPuTDpSQ',
    appId: '1:822032193103:web:15f74fd4932e7588a07c3a',
    messagingSenderId: '822032193103',
    projectId: 'osm-map-f8dae',
    authDomain: 'osm-map-f8dae.firebaseapp.com',
    storageBucket: 'osm-map-f8dae.appspot.com',
    measurementId: 'G-ME2069070G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZ9cu5rg_2bbtzVHkQ51iASNI35h8l2ms',
    appId: '1:822032193103:android:be1cb81fb51e9ca5a07c3a',
    messagingSenderId: '822032193103',
    projectId: 'osm-map-f8dae',
    storageBucket: 'osm-map-f8dae.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCGSat9ujNJLokCi93pd02_pYv3LVmP7Xo',
    appId: '1:822032193103:ios:6005274c8cd50026a07c3a',
    messagingSenderId: '822032193103',
    projectId: 'osm-map-f8dae',
    storageBucket: 'osm-map-f8dae.appspot.com',
    iosBundleId: 'com.example.osmMap',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCGSat9ujNJLokCi93pd02_pYv3LVmP7Xo',
    appId: '1:822032193103:ios:a400c3c87bdaab55a07c3a',
    messagingSenderId: '822032193103',
    projectId: 'osm-map-f8dae',
    storageBucket: 'osm-map-f8dae.appspot.com',
    iosBundleId: 'com.example.osmMap.RunnerTests',
  );
}

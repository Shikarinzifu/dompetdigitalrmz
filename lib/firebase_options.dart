<<<<<<< HEAD
// File generated from google-services.json.
// ignore_for_file: type=lint
=======
>>>>>>> 4961ad2 (fix: resolve 55 analyzer issues + redesign UI ke tema hijau lumut)
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

<<<<<<< HEAD
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
=======
/// Default [FirebaseOptions] for use with your Firebase apps.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
>>>>>>> 4961ad2 (fix: resolve 55 analyzer issues + redesign UI ke tema hijau lumut)
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
<<<<<<< HEAD
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios.',
        );
=======
        return ios;
>>>>>>> 4961ad2 (fix: resolve 55 analyzer issues + redesign UI ke tema hijau lumut)
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

<<<<<<< HEAD
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD-GzDjWNEr2IhWhZNcZ9CO9jFOf2raMBc',
    appId: '1:967432735906:web:YOUR_WEB_APP_ID',
    messagingSenderId: '967432735906',
    projectId: 'dompetrmz',
    storageBucket: 'dompetrmz.firebasestorage.app',
  );

=======
>>>>>>> 4961ad2 (fix: resolve 55 analyzer issues + redesign UI ke tema hijau lumut)
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD-GzDjWNEr2IhWhZNcZ9CO9jFOf2raMBc',
    appId: '1:967432735906:android:6b4bb060a01fb3692e5bfb',
    messagingSenderId: '967432735906',
    projectId: 'dompetrmz',
    storageBucket: 'dompetrmz.firebasestorage.app',
  );
<<<<<<< HEAD
=======

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY',
    appId: 'YOUR_IOS_APP_ID',
    messagingSenderId: '967432735906',
    projectId: 'dompetrmz',
    storageBucket: 'dompetrmz.firebasestorage.app',
    iosBundleId: 'com.example.dompetdigitalrmz',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD-GzDjWNEr2IhWhZNcZ9CO9jFOf2raMBc',
    appId: '1:967432735906:web:placeholder',
    messagingSenderId: '967432735906',
    projectId: 'dompetrmz',
    authDomain: 'dompetrmz.firebaseapp.com',
    storageBucket: 'dompetrmz.firebasestorage.app',
  );
>>>>>>> 4961ad2 (fix: resolve 55 analyzer issues + redesign UI ke tema hijau lumut)
}

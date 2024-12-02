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
    apiKey: 'AIzaSyC2G-3j9ihOI_DnlMAYsNp0omD6IRY2xN8',
    appId: '1:222644086025:web:a0610bd8cafb3b64511fd8',
    messagingSenderId: '222644086025',
    projectId: 'student-registration-930f1',
    authDomain: 'student-registration-930f1.firebaseapp.com',
    databaseURL: 'https://student-registration-930f1-default-rtdb.firebaseio.com',
    storageBucket: 'student-registration-930f1.appspot.com',
    measurementId: 'G-NBDGSFFWX1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAg3LVCWwM-il5fBFArwZK94vx6m976QJw',
    appId: '1:222644086025:android:b51fa9c5815fc8ff511fd8',
    messagingSenderId: '222644086025',
    projectId: 'student-registration-930f1',
    databaseURL: 'https://student-registration-930f1-default-rtdb.firebaseio.com',
    storageBucket: 'student-registration-930f1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCGQG_R0x5Aw0EWsQUHr-Vv6jIT9IMuaLs',
    appId: '1:222644086025:ios:29ee27416a28a7f1511fd8',
    messagingSenderId: '222644086025',
    projectId: 'student-registration-930f1',
    databaseURL: 'https://student-registration-930f1-default-rtdb.firebaseio.com',
    storageBucket: 'student-registration-930f1.appspot.com',
    iosBundleId: 'com.example.studentsregistration',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCGQG_R0x5Aw0EWsQUHr-Vv6jIT9IMuaLs',
    appId: '1:222644086025:ios:29ee27416a28a7f1511fd8',
    messagingSenderId: '222644086025',
    projectId: 'student-registration-930f1',
    databaseURL: 'https://student-registration-930f1-default-rtdb.firebaseio.com',
    storageBucket: 'student-registration-930f1.appspot.com',
    iosBundleId: 'com.example.studentsregistration',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC2G-3j9ihOI_DnlMAYsNp0omD6IRY2xN8',
    appId: '1:222644086025:web:4c7f0635545d2db7511fd8',
    messagingSenderId: '222644086025',
    projectId: 'student-registration-930f1',
    authDomain: 'student-registration-930f1.firebaseapp.com',
    databaseURL: 'https://student-registration-930f1-default-rtdb.firebaseio.com',
    storageBucket: 'student-registration-930f1.appspot.com',
    measurementId: 'G-KH1VKE19J4',
  );
}

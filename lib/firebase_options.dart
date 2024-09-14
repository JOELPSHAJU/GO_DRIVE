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
    apiKey: 'AIzaSyCOOJXlgrFma6KCKNTkDMVagHrkyvOOnmk',
    appId: '1:335810982085:web:51c95cae111d24f52540ac',
    messagingSenderId: '335810982085',
    projectId: 'go-drive-a38e5',
    authDomain: 'go-drive-a38e5.firebaseapp.com',
    storageBucket: 'go-drive-a38e5.appspot.com',
    measurementId: 'G-XDKRD6RN5S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCtbvgd9xefITVur5aFDEVZl6gS5bImRhI',
    appId: '1:335810982085:android:f7132b11cac704572540ac',
    messagingSenderId: '335810982085',
    projectId: 'go-drive-a38e5',
    storageBucket: 'go-drive-a38e5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB5XwH5_OoYza6KayyRp9VuJAHXGRffr9E',
    appId: '1:335810982085:ios:f6c804da36dceb902540ac',
    messagingSenderId: '335810982085',
    projectId: 'go-drive-a38e5',
    storageBucket: 'go-drive-a38e5.appspot.com',
    iosBundleId: 'com.example.godrive',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB5XwH5_OoYza6KayyRp9VuJAHXGRffr9E',
    appId: '1:335810982085:ios:f6c804da36dceb902540ac',
    messagingSenderId: '335810982085',
    projectId: 'go-drive-a38e5',
    storageBucket: 'go-drive-a38e5.appspot.com',
    iosBundleId: 'com.example.godrive',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCOOJXlgrFma6KCKNTkDMVagHrkyvOOnmk',
    appId: '1:335810982085:web:8e1070457bda2bd32540ac',
    messagingSenderId: '335810982085',
    projectId: 'go-drive-a38e5',
    authDomain: 'go-drive-a38e5.firebaseapp.com',
    storageBucket: 'go-drive-a38e5.appspot.com',
    measurementId: 'G-STRD73D3RM',
  );
}

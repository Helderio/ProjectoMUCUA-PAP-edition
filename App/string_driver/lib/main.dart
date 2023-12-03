import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:riders_food_app/splash_screen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global/global.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 sharedPreferences = await SharedPreferences.getInstance();
  // Initialize Firebase
await Firebase.initializeApp(options: const FirebaseOptions(
    apiKey: 'AIzaSyAVVY-ZCsxF58ecgqz54SssKLeKPJr5nCQ',
    appId: '1:161246127971:ios:3623a6a961cc0dffe69556',
    messagingSenderId: '161246127971',
    projectId: 'stringappdb',
    storageBucket: 'stringappdb.appspot.com',
    androidClientId: '161246127971-1st84r860cb6mot8nv9hi63uotc9b05g.apps.googleusercontent.com',
    iosClientId: '161246127971-virtkjtes2i0v5or00g75tne54ubj411.apps.googleusercontent.com',
    iosBundleId: 'com.example.stringDriver',
  ));

  // Initialize SharedPreferences
 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riders App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
         primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

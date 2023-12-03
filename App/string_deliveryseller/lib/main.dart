import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sellers_food_app/global/global.dart';
import 'package:sellers_food_app/splash_screen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp( options: const FirebaseOptions(
    apiKey: 'AIzaSyAVVY-ZCsxF58ecgqz54SssKLeKPJr5nCQ',
    appId: '1:161246127971:ios:b001e33957cd5510e69556',
    messagingSenderId: '161246127971',
    projectId: 'stringappdb',
    storageBucket: 'stringappdb.appspot.com',
    androidClientId: '161246127971-1st84r860cb6mot8nv9hi63uotc9b05g.apps.googleusercontent.com',
    iosClientId: '161246127971-32ml49a8h533rrq5s6eup9njhc4c4k3e.apps.googleusercontent.com',
    iosBundleId: 'com.example.stringDeliveryseller',
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sellers App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

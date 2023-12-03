import 'package:bringapp_admin_web_portal/authentication/login_screen.dart';
import 'package:bringapp_admin_web_portal/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
await Firebase.initializeApp(options: const FirebaseOptions(
    apiKey: 'AIzaSyAVVY-ZCsxF58ecgqz54SssKLeKPJr5nCQ',
    appId: '1:161246127971:ios:13f004519f90873ae69556',
    messagingSenderId: '161246127971',
    projectId: 'stringappdb',
    storageBucket: 'stringappdb.appspot.com',
    androidClientId: '161246127971-1st84r860cb6mot8nv9hi63uotc9b05g.apps.googleusercontent.com',
    iosClientId: '161246127971-h89l9riuli7r27t4polevoqs586oib0j.apps.googleusercontent.com',
    iosBundleId: 'com.example.bringappAdminWebPortal',
  ));


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? const LoginScreen()
          : const HomeScreen(),
    );
  }
}

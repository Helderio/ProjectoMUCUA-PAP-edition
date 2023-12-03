import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'helper/binding.dart';
import 'view/auth/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions (
    apiKey: 'AIzaSyAVVY-ZCsxF58ecgqz54SssKLeKPJr5nCQ',
    appId: '1:161246127971:ios:99a63fd5441d285fe69556',
    messagingSenderId: '161246127971',
    projectId: 'stringappdb',
    storageBucket: 'stringappdb.appspot.com',
    androidClientId: '161246127971-1st84r860cb6mot8nv9hi63uotc9b05g.apps.googleusercontent.com',
    iosClientId: '161246127971-g8fanaj3ikd2g1jc1712bffl3drktj6v.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  )
  );

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => ScreenUtilInit(
        designSize: orientation == Orientation.portrait
            ? Size(375, 812)
            : Size(812, 375),
        builder: (context, child) => GetMaterialApp(
  initialBinding: Binding(),
  theme: ThemeData(
    fontFamily: 'SourceSansPro',
  ),
  home: LoginView(),
  debugShowCheckedModeBanner: false,
  title: 'users_food_app',
),

        ),
      );
  }
}

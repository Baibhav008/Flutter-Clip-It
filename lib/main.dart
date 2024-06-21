import 'package:clip_it/view/screens/auth/login_screen.dart';
import 'package:clip_it/view/screens/auth/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants.dart';
import 'controller/auth_controller.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBbXNyHuQgX6f3iCn6lyruBSGPejYnB5aA",
        appId: "1:162956745896:android:51691b7fe0dbd36a23769d",
        messagingSenderId:"162956745896",
        projectId: "clip-it-b9307",
    storageBucket: "gs://clip-it-b9307.appspot.com")
  ).then((value){
    Get.put(AuthController());
  });


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clip It',

      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,


      ),
      home: Scaffold(
        body: LoginScreen()
      ),
    );
  }
}


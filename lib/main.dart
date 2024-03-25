import 'package:flutter/material.dart';
import 'package:shuttle_car/pages/home.dart';
import 'package:shuttle_car/pages/login.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {'/home': (context) => homePage()},
        title: 'Clean Code',
        home: AnimatedSplashScreen(
            duration: 3000,
            splash: Image(image: AssetImage('images/Logo Apk.png')),
            nextScreen: login(),
            splashTransition: SplashTransition.fadeTransition,
            // pageTransitionType: PageTransitionType.scale,
            backgroundColor: Colors.white));
  }
}

import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ergo/MainPages/Accueil.dart';
import 'package:ergo/AuthPages/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_sceens/onboarding_screen.dart';

bool je_check_les_bails_sombres = true;
var initScreen;
//le main
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ergo',
      home: AnimatedSplashScreen(
        animationDuration: Duration(seconds: 1),
        splash: Container(child: Image.asset('assets/logoSplash.png')),
        nextScreen: initScreen == 0 || initScreen == null
            ? OnboardingScreen()
            : LoginScreen(),
        splashTransition: SplashTransition.sizeTransition,
      ),
    );
  }
}



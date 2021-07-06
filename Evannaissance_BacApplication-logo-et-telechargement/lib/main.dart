import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AuthScreens/login_screen.dart';
import 'StudentsPageSection/BottomNaBar.dart';
import 'StudentsPageSection/ChoiceTypeBac.dart';
import 'StudentsPageSection/Accueil.dart';
import 'StudentsPageSection/MatieresTypeBac/PageMatieresS.dart';
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

ThemeData _lightTheme = ThemeData(
    accentColor: Colors.lightBlue,
    brightness: Brightness.light,
    primaryColor: Colors.lightBlue);

ThemeData _darkTheme = ThemeData(
    accentColor: Colors.lightBlue,
    brightness: Brightness.dark,
    primaryColor: Colors.lightBlue);

bool islight = true;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: islight ? _lightTheme : _darkTheme,
      debugShowCheckedModeBanner: false,
      title: 'Bac++',
      home: AnimatedSplashScreen(
        animationDuration: Duration(seconds: 1),
        splash: Container(child: Image.asset('assets/logoSplash.png')),
        nextScreen: initScreen == 0 || initScreen == null
            ? OnboardingScreen()
            : BottomNavBar(),
        splashTransition: SplashTransition.sizeTransition,
      ),
    );
  }
}

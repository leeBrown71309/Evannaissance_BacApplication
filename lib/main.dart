import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AuthScreens/login_screen.dart';
import 'StudentsPageSection/BottomNaBar.dart';
import 'StudentsPageSection/ChoiceTypeBac.dart';
import 'StudentsPageSection/Accueil.dart';
import 'StudentsPageSection/MatieresTypeBac/PageMatieresS.dart';
import 'onboarding_sceens/onboarding_screen.dart';
import 'package:path_provider/path_provider.dart';

bool je_check_les_bails_sombres = true;

_read() async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/my_file.txt');
    String text = await file.readAsString();
    print('${directory.path}/my_file.txt');
  } catch (e) {
    je_check_les_bails_sombres = false;
    print("Couldn't read file");
  }
}

//le main
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _read();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bac++',
      home: AnimatedSplashScreen(
        animationDuration: Duration(seconds: 1),
        splash: Container(child: Image.asset('assets/logoSplash.png')),
        nextScreen:
            je_check_les_bails_sombres ? BottomNavBar() : OnboardingScreen(),
        splashTransition: SplashTransition.sizeTransition,
      ),
    );
  }
}

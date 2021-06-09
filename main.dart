// @dart=2.9

import 'dart:ui';

import 'package:flutter/material.dart';
//ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_pro/carousel_pro.dart';
// import 'package:bac_plus_plus/home.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Column fiche(String imgPath, String text) {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  imgPath,
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Montserrat",
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.indigo,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 300.0,
                child: Carousel(
                  autoplay: false,
                  images: [
                    fiche('images/image1.jpg', 'bla bla'),
                    fiche('images/image2.jpg', 'bla bla'),
                    fiche('images/image3.jpeg', 'bla bla'),
                    fiche('images/image4.png', 'bla bla'),
                  ],
                  dotSize: 6.0,
                  dotSpacing: 20.0,
                  dotBgColor: Colors.transparent,
                  dotColor: Colors.white,
                  dotIncreasedColor: Colors.indigo,
                  indicatorBgPadding: 45.0,
                  dotVerticalPadding: 1,
                  overlayShadow: true,
                  overlayShadowColors: Colors.indigo,
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () {
                  print("je skipp!!");
                },
                child: Text(
                  "Skip",
                  style: TextStyle(
                    color: Colors.indigo,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*😵 flemme de commenter c'est pas difficile lis bien!!*/

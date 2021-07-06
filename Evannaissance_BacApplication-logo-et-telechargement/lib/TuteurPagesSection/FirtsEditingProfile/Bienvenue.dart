
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'EditeProfileImage.dart';


class BienvenuePage extends StatefulWidget {
  const BienvenuePage({Key? key}) : super(key: key);

  @override
  _BienvenuePageState createState() => _BienvenuePageState();
}

class _BienvenuePageState extends State<BienvenuePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF3594DD),
                      Color(0xFF4563DB),
                      Color(0xFF5036D5),
                      Color(0xFF5B16D0),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                //color: Colors.white,
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "L'équipe Evannaissance \n                vous...",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontSize:28.6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 70.0),
                      Bienvenue(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Bienvenue extends StatefulWidget {
  const Bienvenue({Key? key}) : super(key: key);

  @override
  _BienvenueState createState() => _BienvenueState();
}

class _BienvenueState extends State<Bienvenue> {

  void goToNextPage() {
    Navigator.push(context, MaterialPageRoute(builder:
        (context) {
      return ProfileEditor();
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 220,
            width: 220,
            child: Stack(
              overflow: Overflow.visible,
              fit: StackFit.expand,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/welcome.jpg'),
                )
              ],
            ),
          ),
          SizedBox(height: 50,),
          Text("remercie d'avoir choisis \n          notre service",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Montserrat',
            fontSize:28.6,
            fontWeight: FontWeight.bold,
          ),
          ),
          SizedBox(height: 50,),
          //animation de text


         Column(
           mainAxisAlignment: MainAxisAlignment.center,
          children: [
             DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Canterbury',
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [

                    ScaleAnimatedText('Tap pour continue',),

                  ],
                  onTap: () {
                    goToNextPage();
                  },
                ),
              ),
          ],
        ),

        ],
      ),
    );
  }
}

import 'package:e_bac/AuthScreens/TypeUsers.dart';
import 'package:e_bac/TuteurPagesSection/FirtsEditingProfile/Bienvenue.dart';
import 'package:e_bac/TuteurPagesSection/FirtsEditingProfile/EditeProfileImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'ChoiceTypeBac.dart';
import 'PagesNavBottomBar/SettingsPage.dart';
import 'ProfilPage.dart';

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  void goToChoiceUserType() {
    //permet de naviguer d'une page à une autre avec une animation
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return paramettre();
                  })),
              icon: Icon(
                EvaIcons.settings,
                size: 35,
                color: Colors.lightBlue,
              ))
        ],
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
              ),
              Container(
                alignment: Alignment.topCenter,
                //color: Colors.white,
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                      top: 130, bottom: 10, left: 15, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Bibliothèque D'épreuves",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 50.0),
                      ChoiceTypeBac(),
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

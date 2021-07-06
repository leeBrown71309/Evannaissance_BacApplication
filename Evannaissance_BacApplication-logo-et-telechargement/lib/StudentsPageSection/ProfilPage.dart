import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ChoiceTypeBac.dart';

class ProfilPage extends StatefulWidget {
@override
_ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(EvaIcons.arrowBack,
          color: Colors.lightBlue,
          size: 33,),
        actions: [
          IconButton(onPressed: () =>print('hello'),
              icon: Icon(EvaIcons.settings,
                color: Colors.lightBlue,
                size: 33,
              )
          ),],
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
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Mon profil",
                        style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Montserrat',
                          fontSize: 27.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 50,),
                      //de la page accueil
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
import 'package:e_bac/AuthScreens/login_screen.dart';
import 'package:e_bac/StudentsPageSection/BottomNaBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class ChoiceUserType extends StatefulWidget {
  const ChoiceUserType({Key? key}) : super(key: key);

  @override
  _ChoiceUserTypeState createState() => _ChoiceUserTypeState();
}

class _ChoiceUserTypeState extends State<ChoiceUserType> {
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
                        'Qui êtes-vous ?',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Image(image: AssetImage('assets/who_are_you.png',),
                      height: 300,
                      width: 500,),
                      SizedBox(height: 30.0),
                      WhichUser(),
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

class WhichUser extends StatefulWidget {
  const WhichUser({Key? key}) : super(key: key);

  @override
  _WhichUserState createState() => _WhichUserState();
}

class _WhichUserState extends State<WhichUser> {

  void goToLoginScreen() {
    //permet de naviguer d'une page à une autre avec une animation
    Navigator.push(context, PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, animationTime, child) {
          animation= CurvedAnimation(parent: animation,
              curve: Curves.elasticOut);
          return ScaleTransition(scale: animation,
            alignment: Alignment.center,
            child: child,
          );
        },
        pageBuilder:
            (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return LoginScreen();
        }
    ));
  }

  void goToEleveAccueil() {
    //permet de naviguer d'une page à une autre avec une animation
    Navigator.push(context, PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, animationTime, child) {
          animation= CurvedAnimation(parent: animation,
              curve: Curves.elasticOut);
          return ScaleTransition(scale: animation,
            alignment: Alignment.center,
            child: child,
          );
        },
        pageBuilder:
            (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return BottomNavBar();
        }
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Choisisser en fonction de qui vous etes !',
          style: TextStyle(fontSize: 17,color: Colors.white,
          fontFamily: 'Montserrat'),
          ),
         SizedBox(height: 30,),
         RaisedButton(onPressed: () => goToEleveAccueil(),
           padding: EdgeInsets.only(left: 80,right: 80,top: 30,bottom: 30),
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(30),
           ),
           color: Colors.white,
           child: Text('Elève ?',
           style: TextStyle(fontFamily: 'Montserrat',
           fontSize: 20,
           color: Colors.indigo),
           ),
         ),
          SizedBox(height: 20,),
          RaisedButton(onPressed: () => goToLoginScreen(),

            padding: EdgeInsets.only(left: 75,right: 75,top: 30,bottom: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            color: Colors.white,
            child: Text('Tuteur ?',
              style: TextStyle(fontFamily: 'Montserrat',
                  fontSize: 20,
                  color: Colors.indigo),
            ),
          )

        ],
      ),

    );
  }
}

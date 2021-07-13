
import 'package:ergo/AuthPages/LoginScreen.dart';
import 'package:ergo/AuthPages/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import '../MainPages/Accueil.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 4;

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.orange,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  void goToNextPage() {
    //permet de naviguer d'une page à une autre avec une animation
    Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            transitionsBuilder: (context, animation, animationTime, child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.elasticOut);
              return ScaleTransition(
                scale: animation,
                alignment: Alignment.center,
                child: child,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return Accueil();
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.7,],
              colors: [
                Color(0xFF28282A),
                Color(0xFF1C1B1B),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                Container(
                  height: 600.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 70, left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                color: Colors.green,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Ink.image(
                                          image: AssetImage(
                                              "assets/g4.jpg"),
                                          fit: BoxFit.cover,
                                          height: 250,
                                          child: InkWell(
                                            onTap: () {},
                                            splashColor:
                                            Colors.blue.withAlpha(30),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'Bienvenue à vous',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              "",
                              style: TextStyle(
                                color: Colors.white54,
                                fontFamily: 'Montserrat',
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 70, left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                color: Colors.green,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Ink.image(
                                          image: AssetImage(
                                              "assets/g1.jpg"),
                                          fit: BoxFit.cover,
                                          height: 250,
                                          child: InkWell(
                                            onTap: () {},
                                            splashColor:
                                            Colors.blue.withAlpha(30),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'ErgoGen...',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              "",
                              style: TextStyle(
                                color: Colors.white54,
                                fontFamily: 'Montserrat',
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:70, left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                color: Colors.green,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Ink.image(
                                          image: AssetImage(
                                              "assets/g2.jpg"),
                                          fit: BoxFit.cover,
                                          height: 250,
                                          child: InkWell(
                                            onTap: () {},
                                            splashColor:
                                            Colors.blue.withAlpha(30),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'Gestion de projets',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              "",
                              style: TextStyle(
                                color: Colors.white54,
                                fontFamily: 'Montserrat',
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 70, left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                color: Colors.green,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Ink.image(
                                          image: AssetImage(
                                            "assets/g3.jpg"),
                                          fit: BoxFit.cover,
                                          height: 250,
                                          child: InkWell(
                                            onTap: () {},
                                            splashColor:
                                            Colors.blue.withAlpha(30),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              '',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              "",
                              style: TextStyle(
                                color: Colors.white54,
                                fontFamily: 'Montserrat',
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: FlatButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 22.0,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.orange,
                            size: 30.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
            padding: EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
            primary: Colors.white,
                onPrimary: Colors.black87,
                elevation: 7,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.only(left: 33,right: 33,top: 10,bottom: 10)
              ),

                onPressed:()=> Navigator.push(context, MaterialPageRoute(
                    builder: (builder){
                      return LoginScreen();
                    })),
                child: Text("Login",
                style: TextStyle(fontSize: 20,color: Colors.orange),)
      ),
          ],
        ),
      )
          : Text(''),
    );
  }
}
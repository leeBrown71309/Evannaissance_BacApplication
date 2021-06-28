import 'package:e_bac/AuthScreens/login_screen.dart';
import 'package:e_bac/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../AuthScreens/SignUp_Screen.dart';
import '../AuthScreens/TypeUsers.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

_save() async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/my_file.txt');
  final text = 'Hello World!';
  await file.writeAsString(text);
  print('saved');
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 6;
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
    _save();
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
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
              return ChoiceUserType();
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
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFF3594DD),
                Color(0xFF4563DB),
                Color(0xFF5036D5),
                Color(0xFF5B16D0),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 23.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => goToNextPage(),
                    child: Text(
                      'Passer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
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
                                              "assets/StudentsImages/etudiants11.jpg"),
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
                              'Bienvenue à vous\nfuture diplômés...',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              "Aviez-vous déjà eu le besoin de consulter des anciennes épreuves "
                              "d'un examen afin de vous exercer ??? Si oui vous êtes au bon endroit",
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
                                              "assets/StudentsImages/etudiants4.jpg"),
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
                              'BAC++..',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              "Vous permet de preparer votre Baccalauréat dans de bonne conditions... ",
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
                                              "assets/StudentsImages/etudiants3.jpg"),
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
                              'Regroupant...',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              "Une énorme bilbiothèque numérique, portable et structuré d'épreuves mis à votre disposition... ",
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
                                              "assets/StudentsImages/etudiants12.jpg"),
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
                              'Vous permettant...',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              "D'avoir accès à ces données plus rapidement, mais qui propose aussi la possibilité"
                              " à un élève dans le besoin de... ",
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
                                              "assets/StudentsImages/etudiants13.jpg"),
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
                              'Contacter...',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              "Des tuteurs qualifiers et certifiers afin de mettre toutes les chances de votre pour devenir des... ",
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
                                              "assets/StudentsImages/etudiants1.jpg"),
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
                              'Etudiants accomplis...',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              "L'équipe Evannaissance vous souhaite \"BONNE CHANCE!!!\" ",
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
                                    color: Colors.white,
                                    fontSize: 22.0,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
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
              padding: EdgeInsets.symmetric(vertical: 25.0),
              width: double.infinity,
              child: RaisedButton(
                elevation: 5.0,
                onPressed: () => goToNextPage(),
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Colors.white,
                child: Text(
                  'Commencer',
                  style: TextStyle(
                    color: Color(0xFF5036D5),
                    letterSpacing: 1.5,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'MatieresTypeBac/PageMatiereL.dart';
import 'MatieresTypeBac/PageMatieresS.dart';

class ChoiceTypeBac extends StatefulWidget {
  const ChoiceTypeBac({Key? key}) : super(key: key);

  @override
  _ChoiceTypeBacState createState() => _ChoiceTypeBacState();
}

class _ChoiceTypeBacState extends State<ChoiceTypeBac> {
  void goToPageMatiereS(String bac) {
    //permet de naviguer d'une page à une autre avec une animation
    Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
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
              return PageMatiereS(bac);
            }));
  }

  void goToPageMatiereL() {
    //permet de naviguer d'une page à une autre avec une animation
    Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
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
              return PageMatiereL();
            }));
  }

  Container choice(String imgPath, String question, String description,
      Color la_couleur, String bac) {
    return Container(
      child: Center(
        child: Card(
          clipBehavior: Clip.antiAlias,
          color: la_couleur,
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
                    image: AssetImage(imgPath),
                    fit: BoxFit.cover,
                    height: 250,
                    child: InkWell(
                      onTap: () => goToPageMatiereS(bac),
                      splashColor: Colors.blue.withAlpha(30),
                    ),
                  ),
                  Positioned(
                      bottom: 16,
                      right: 16,
                      left: 16,
                      child: Text(
                        question,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )),
                  const SizedBox(
                    width: 500,
                    height: 200,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 5, right: 5, top: 10).copyWith(
                  bottom: 10,
                ),
                child: Text(
                  description,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        choice(
            "assets/StudentsImages/science.jpg",
            "Etes-vous scientifique?",
            "ce catalogue contient toutes les matieres et épreuves scientifiques"
                " de chaque sous-séries scientifiques (s1, s2, s3, s4, s5)",
            Colors.blueGrey,
            "Scientifiques"),
        SizedBox(
          height: 10,
        ),
        choice(
            "assets/StudentsImages/etudiants6.jpg",
            "Etes-vous Litteraire?",
            "Ce catalogue contient toutes les matières et épreuves littéraires"
                " de chaque sous-séries littéraires (l1a, l1b, l1', l2, lA)",
            Colors.green,
            "Litteraire"),
        SizedBox(
          height: 10,
        ),
        choice(
            "assets/StudentsImages/etudiants9.jpg",
            'Etes-vous du technique ?',
            "Ce catalogue contient toutes les matières et épreuves Techniques"
                " de chaque sous-séries techniques(T1, T2,)",
            Colors.lightBlue,
            "Techniques"),
        SizedBox(
          height: 10,
        ),
        choice(
            "assets/StudentsImages/etudiants3.jpg",
            'Ou plutôt du général ?',
            "Ce catalogue contient toutes les matières et épreuves Générales",
            Colors.redAccent,
            "Génerale"),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Padding bac(String a, String b, String c, String d, Color e) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
    child: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            a,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    b,
                    style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    c,
                    style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Text(
                d,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
        color: e,
        borderRadius: BorderRadius.circular(25.0),
      ),
      height: 100,
    ),
  );
}

Padding matiere(String nom, Color couleur) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Text(
          nom,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 18,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: couleur,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    ),
  );
}

Padding populaire(String imgPath, String label) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imgPath),
              fit: BoxFit.fill,
            ),
            border: Border.all(width: 2, color: Colors.indigo),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          width: 200,
          height: 180,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 12),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.indigo,
              fontFamily: "Montserrat",
            ),
          ),
        ),
      ],
    ),
  );
}

Container epreuveMatiere(String imgPath, String nomMatiere, Color couleur) {
  return Container(
    height: 100,
    child: Row(
      children: [
        Expanded(
          child: Container(
            height: 100,
            width: 250,
            child: Image.asset(imgPath),
          ),
        ),
        Expanded(
          child: Container(
            height: 100,
            color: couleur,
            child: Center(
              child: Text(
                nomMatiere,
                style: TextStyle(
                  height: 1.3,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Pacifico",
                ),
              ),
            ),
          ),
        ),
      ],
    ),
    decoration: BoxDecoration(
        color: couleur,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(width: 2)),
  );
}

class epreuveParAnnee extends StatelessWidget {
  epreuveParAnnee(this.annee);
  String annee;

  Expanded exp(String groupe) {
    return Expanded(
      child: Center(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.all(10),
          height: 60,
          child: Text(
            groupe,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          decoration: BoxDecoration(
            color: Color(0xff7AADADAD),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 1),
      // margin: EdgeInsets.only(bottom: 1),
      height: 320,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(right: 120),
            height: 50,
            child: Center(
              child: Text(
                annee,
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: "Montserrat",
                  color: Color(0xff14222B),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 110,
            width: double.infinity,
            color: Colors.black12,
            child: Expanded(
              child: Column(
                children: [
                  Text(
                    "Series S1-S3",
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: "Pacifico",
                      fontWeight: FontWeight.bold,
                      color: Color(0xff14222B),
                    ),
                  ),
                  Row(
                    children: [
                      exp("Premier Groupe"),
                      exp("Deuxieme groupe"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 1),
          Container(
            width: double.infinity,
            height: 110,
            color: Colors.black12,
            child: Expanded(
              child: Column(
                children: [
                  Text(
                    "Series S2-S4-S5",
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: "Pacifico",
                      fontWeight: FontWeight.bold,
                      color: Color(0xff14222B),
                    ),
                  ),
                  Row(
                    children: [
                      exp("Premier groupe"),
                      exp("Deuxieme groupe"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.black12,
        // border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}

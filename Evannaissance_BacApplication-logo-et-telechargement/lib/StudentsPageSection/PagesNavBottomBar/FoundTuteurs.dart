import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class FoundTuteur extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Vous chercher un tuteur ???",
          style: TextStyle(color: Colors.white),),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.lightBlueAccent, Colors.blue],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topRight)),
        ),
      ),
      body: FoundTuteurPage(),

    );
  }
}


class FoundTuteurPage extends StatefulWidget {


  @override
  _FoundTuteurPageState createState() => _FoundTuteurPageState();
}

class _FoundTuteurPageState extends State<FoundTuteurPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Cette section n'est pas encore disponible !!!"),
      ),
    );
  }
}

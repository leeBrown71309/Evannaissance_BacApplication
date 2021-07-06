import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class PageCours extends StatelessWidget {
  const PageCours({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Cours",
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
      body: PageCoursBuild(),

    );
  }
}


class PageCoursBuild extends StatefulWidget {
  const PageCoursBuild({Key? key}) : super(key: key);

  @override
  _PageCoursBuildState createState() => _PageCoursBuildState();
}

class _PageCoursBuildState extends State<PageCoursBuild> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Cette section n'est pas encore disponible !!!"),
      ),
    );
  }
}

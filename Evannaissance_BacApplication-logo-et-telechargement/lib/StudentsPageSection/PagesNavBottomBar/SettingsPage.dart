import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class paramettre extends StatefulWidget {
  const paramettre({Key? key}) : super(key: key);

  @override
  _paramettreState createState() => _paramettreState();
}

ThemeData _lightTheme = ThemeData(
    accentColor: Colors.lightBlue,
    brightness: Brightness.light,
    primaryColor: Colors.lightBlue
);

ThemeData _darkTheme = ThemeData(
    accentColor: Colors.lightBlue,
    brightness: Brightness.dark,
    primaryColor: Colors.lightBlue
);

bool islight = true;


class _paramettreState extends State<paramettre> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: islight ? _lightTheme : _darkTheme,
      title: "paramettre",
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(''),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.lightBlueAccent, Colors.blue],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topRight)),
          ),

        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Mode Dark"),
              Switch(value: islight,
                  onChanged: (state){
                setState(() {
                  islight = state;
                });
                  }),
              Text("En développement..."),
            ],
          ),
        ),
      ),

    );
  }
}

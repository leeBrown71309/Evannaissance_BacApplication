import 'dart:convert';

import 'package:e_bac/StudentsPageSection/MatieresTypeBac/results_page.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../BottomNaBar.dart';
import '../ChoiceTypeBac.dart';
import 'package:http/http.dart' as http;

var je_suis_la_variable_globale_ultime = "Ha! Ha! Ha😎";

class PageMatiereS extends StatefulWidget {
  PageMatiereS(@required this.bac);
  String bac;
  @override
  _PageMatiereSState createState() => _PageMatiereSState();
}

class _PageMatiereSState extends State<PageMatiereS> {
  void goToBottomNavBar() {
    //permet de naviguer d'une page à une autre avec une animation
    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    je_suis_la_variable_globale_ultime = widget.bac;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Matières Bac " + widget.bac,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.lightBlueAccent, Colors.blue],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topRight)),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                onPressed: () => goToBottomNavBar(),
                icon: Icon(
                  EvaIcons.arrowBack,
                  size: 35,
                  color: Colors.white,
                ));
          },
        ),
      ),
      body: Ldl(), //ListViewWidget(),
    );
  }
}

class Ldl extends StatefulWidget {
  @override
  _LdlState createState() => _LdlState();
}

class _LdlState extends State<Ldl> {
  List list = [];
  bool vf = true;
  var emptyMap = new Map();

  Future getData() async {
    final http.Response response =
        await http.get(Uri.https('bacplusplus.000webhostapp.com', 'scx.php'));
    if (response.statusCode == 200) {
      setState(() {
        emptyMap = jsonDecode(response.body);
        vf = false;
      });
    }
    print(emptyMap[je_suis_la_variable_globale_ultime][1]);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void porte_un_(String ou_silip) {
    print(ou_silip);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ParAnnee(ou_silip),
      ),
    );
  }

  ListTile matiere(String nom, String type, Function vas_la_bas) {
    return ListTile(
      leading: Icon(Icons.book_outlined,color: Colors.blue,size: 40,),
      title: Text(
        nom,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        type,
        style: TextStyle(color: Colors.blue),
      ),
      trailing: Icon(Icons.keyboard_arrow_right,color: Colors.blue,size: 30,),
      onTap: () {
        vas_la_bas(nom);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return vf
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: emptyMap[je_suis_la_variable_globale_ultime].length,
            itemBuilder: (context, index) {
              var al = emptyMap[je_suis_la_variable_globale_ultime][index]
                          ['description']
                      .isEmpty
                  ? "Non dominate"
                  : emptyMap[je_suis_la_variable_globale_ultime][index]
                      ['description'];
              return matiere(
                  emptyMap[je_suis_la_variable_globale_ultime][index]['nom'],
                  al,
                  porte_un_);
            });
  }
}

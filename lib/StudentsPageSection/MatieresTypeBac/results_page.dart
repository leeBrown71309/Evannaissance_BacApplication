import 'dart:ui';
import 'package:e_bac/StudentsPageSection/MatieresTypeBac/bac_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_bac/StudentsPageSection/MatieresTypeBac/pdf.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Responsive {
  static width(double p, BuildContext context) {
    return MediaQuery.of(context).size.width * (p / 100);
  }

  static height(double p, BuildContext context) {
    return MediaQuery.of(context).size.height * (p / 100);
  }
}

class ParAnnee extends StatefulWidget {
  String nom = "Mathématiques";
  ParAnnee(this.nom);

  @override
  _ParAnneeState createState() => _ParAnneeState();
}

class _ParAnneeState extends State<ParAnnee> {
  List list = [];
  bool vf = true;
  var emptyMap = new Map();

  Future getData() async {
    final http.Response response = await http
        .get(Uri.https('bacplusplus.000webhostapp.com', 'Big_data.php'));
    if (response.statusCode == 200) {
      setState(() {
        emptyMap = jsonDecode(response.body);
        vf = false;
      });
    }
    print(emptyMap['Scientifiques'][0][widget.nom]);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  ListTile matiere(Map infos, String type, Function vas_la_bas) {
    return ListTile(
      leading: Icon(
        Icons.bookmarks_outlined,
      ),
      title: Text(
        "Bac " + infos['date'] + " " + infos['nom'],
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        type,
        style: TextStyle(color: Colors.black26),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        vas_la_bas(infos);
      },
    );
  }

  void affichePdf(Map a) {
    print(a['url_enonce']);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => PdfViewer(
          url: a['url_enonce'],
          url2: a['url_corrige'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;
    return Scaffold(
      //AppBar
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          "Bac++",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Pacifico",
          ),
        ),
      ),
      //Body
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //Affiche Epreuves avec un trait en dessous
          Container(
            color: Color(0xffD7DBDD),
            height: 70,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10, top: 5),
                    child: Text(
                      "Epreuves de " + widget.nom,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat",
                        color: Color(0xff14222B),
                      ),
                    ),
                  ),
                  Divider(
                    color: Color(0xff14222B),
                    height: 2,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: Responsive.width(150, context),
            child: vf
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: emptyMap['Scientifiques'][0][widget.nom].length,
                    itemBuilder: (context, index) {
                      var tab = emptyMap['Scientifiques'][0][widget.nom][index];
                      var tt = "Toutes Series";
                      if (tab['liste_matiere'].isEmpty) {
                        tt = "Toutes Series";
                      } else {
                        tt = "";
                      }
                      for (var i = 0; i < tab['liste_matiere'].length; i++) {
                        tt += tab['liste_matiere'][i] + ",";
                      }
                      var ff = "Groupe numéro " +
                          tab['groupe'] +
                          " Series (" +
                          tt +
                          ")";
                      return emptyMap['Scientifiques'][0][widget.nom][index]
                              .isEmpty
                          ? Center(
                              child: Text(
                                "Aucune Epreuve",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            )
                          : matiere(
                              emptyMap['Scientifiques'][0][widget.nom][index],
                              ff,
                              affichePdf);
                    }),
          ),
          //Affiche la liste des epreuves par annee la plus recent
        ],
      ),
    );
  }
}

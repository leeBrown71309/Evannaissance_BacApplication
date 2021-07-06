import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:e_bac/StudentsPageSection/MatieresTypeBac/bac_function.dart';
import 'package:e_bac/StudentsPageSection/PagesNavBottomBar/variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:e_bac/StudentsPageSection/MatieresTypeBac/pdf.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:grouped_list/grouped_list.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
  bool loading = false;
  var emptyMap = new Map();
  var ffpath;
  var progress = "";
  var dio;
  var lacouleur = Colors.white;
  Future getData() async {
    final http.Response response = await http
        .get(Uri.https('bacplusplus.000webhostapp.com', 'Big_data.php'));
    if (response.statusCode == 200) {
      setState(() {
        emptyMap = jsonDecode(response.body);
        vf = false;
      });
    }
    // print(emptyMap['Scientifiques'][widget.nom]);
  }

  @override
  void initState() {
    dio = Dio();
    super.initState();
    getData();
  }

  //-------------Les deux fonctions qui s'occupent du telechargement--------------------
  Future<List<Directory>?> _getExternalStoragePath() async {
    return p.getExternalStorageDirectories(type: p.StorageDirectory.documents);
  }

  Future dsf(BuildContext context, Map map) async {
    try {
      final dirList = await _getExternalStoragePath();
      final path = dirList![0].path;
      String filename = map['nom'] + ".pdf";
      String date = map['date'];
      List series = map['liste_matiere'];
      String groupe = map['groupe'];
      String le = "";
      series.forEach((element) {
        le += element + ",";
      });
      final file = File('$path/$filename');
      lacouleur = Colors.white;
      await dio.download(map['url_enonce'], file.path,
          onReceiveProgress: (rec, total) {
        setState(() {
          loading = true;
          progress = ((rec / total) * 100).toStringAsFixed(0) + "%";
        });
      });
      ffpath = file.path;
      progress == "100%"
          ? save(
              '{"name": "$filename", "path": "$ffpath","date":"$date","serie":"$le","groupe":"$groupe"}')
          : ffpath = file.path;
      progress = "✅";
      setState(() {
        lacouleur = Colors.greenAccent;
      });
      // print(ffpath);
    } catch (e) {
      print(e);
    }
    Timer(Duration(seconds: 3), () {
      setState(() {
        loading = false;
      });
    });
  }
  //-------------Fin--------------------------------------------------------------------

  Container matiere(List infos, Function vas_la_bas, Function vas_la_beu) {
    List _elements = infos;
    return Container(
      child: GroupedListView<dynamic, String>(
        elements: _elements,
        groupBy: (element) => "Bac " + element['date'],
        groupComparator: (value1, value2) => value2.compareTo(value1),
        itemComparator: (item1, item2) => item1['nom'].compareTo(item2['nom']),
        order: GroupedListOrder.ASC,
        useStickyGroupSeparators: true,
        groupSeparatorBuilder: (String value) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        itemBuilder: (c, element) {
          var tt = "Toutes Series";
          if (element['liste_matiere'].isEmpty) {
            tt = "Toutes Series";
          } else {
            tt = "";
          }
          for (var i = 0; i < element['liste_matiere'].length; i++) {
            tt += element['liste_matiere'][i] + ",";
          }
          return Card(
            elevation: 8.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Icon(
                  Icons.picture_as_pdf_outlined,
                  color: Colors.red,
                  size: 35,
                ),
                onTap: () {
                  vas_la_bas(element);
                },
                title: Text("Groupe " + element['groupe'] + " Series:" + tt),
                trailing: IconButton(
                    splashColor: Colors.lightBlue,
                    onPressed: () {
                      vas_la_beu(context, element);
                    },
                    icon: Icon(
                      Icons.download_outlined,
                      color: Colors.lightBlue,
                      size: 30,
                    )),
                subtitle: Text(
                  element['nom'] + " " + element['date'],
                  style: TextStyle(color: Colors.black26),
                ),
              ),
            ),
          );
        },
      ),
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
        centerTitle: true,
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
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                iconSize: 35,
                onPressed: () {
                  Navigator.pop(context);
                });
          },
        ),
        title: Row(
          children: [
            Text(
              widget.nom,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Pacifico",
              ),
            ),
            loading
                ? Container(
                    margin: EdgeInsets.only(left: 10),
                    child: CircularPercentIndicator(
                      radius: 40.0,
                      animation: true,
                      animationDuration: 2000,
                      lineWidth: 2.0,
                      percent: 1.0,
                      center: Text(
                        progress,
                        style: TextStyle(color: Colors.white),
                      ),
                      progressColor: lacouleur,
                    ),
                  )
                : Text(""),
          ],
        ),
      ),
      //Body
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Affiche Epreuves avec un trait en dessous
          //SizedBox(height: 5,),
          Container(
              height: Responsive.width(170, context),
              child: vf
                  ? Center(child: CircularProgressIndicator())
                  : matiere(
                      emptyMap['Scientifiques'][widget.nom], affichePdf, dsf)),
          //Affiche la liste des epreuves par annee la plus recent
        ],
      ),
    );
  }
}

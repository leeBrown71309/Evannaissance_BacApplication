import 'dart:convert';
import 'package:e_bac/StudentsPageSection/MatieresTypeBac/pdf.dart';
import 'package:e_bac/StudentsPageSection/PagesNavBottomBar/SettingsPage.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'variables.dart';

final List _elements = [];
var preferences;
bool vf = true;
bool rien = true;

class Downloads extends StatefulWidget {
  @override
  _DownloadsState createState() => _DownloadsState();
}

Container matiere(List infos, Function vas_la_bas) {
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
                  onPressed: () {},
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

class _DownloadsState extends State<Downloads> {
  List infos = ["alban", "bdrt", 2020];
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

  void read() async {
    preferences = await SharedPreferences.getInstance();
    final downloadList = preferences.getStringList('key') ?? [];
    for (var i = 0; i < downloadList.length; i++) {
      var aa = json.decode(downloadList[i]);
      _elements.add(aa);
    }
    setState(() {
      vf = false;
    });
  }

  void df(Map a) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => DownloadPdf(
          url: a['path'],
          url2: a['path'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    vf ? read() : rien = true;
    return Scaffold(
      appBar: AppBar(
        title: Text("Epreuves téléchargées"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return paramettre();
                  })),
              icon: Icon(
                EvaIcons.settings,
                size: 35,
                color: Colors.lightBlue,
              ))
        ],
      ),
      body: vf
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: GroupedListView<dynamic, String>(
                elements: _elements,
                groupBy: (element) => element['date'],
                groupComparator: (value1, value2) => value2.compareTo(value1),
                itemComparator: (item1, item2) =>
                    item1['name'].compareTo(item2['name']),
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
                  return Card(
                    elevation: 8.0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        leading: Icon(
                          Icons.picture_as_pdf_outlined,
                          color: Colors.red,
                        ),
                        title: Text(element['name']),
                        subtitle: Text("Groupe " +
                            element['groupe'] +
                            " Series:" +
                            element['serie']),
                        trailing: Icon(Icons.delete),
                        onTap: () {
                          df(element);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatefulWidget {
  PdfViewer({required this.url, required this.url2});
  String url, url2;

  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  var gauche_droite;

  @override
  Widget build(BuildContext context) {
    gauche_droite = widget.url;
    var pdf = Container(
      height: 600,
      child: ListView(
        children: [
          SfPdfViewer.network(gauche_droite),
        ],
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            title: Row(
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.arrow_back_outlined,
                    size: 35,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 200),
                  child: Text(
                    "Bac++",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Pacifico",
                    ),
                  ),
                ),
              ],
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.lightBlueAccent, Colors.blue],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topRight)),
            ),
            bottom: TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 7,
              tabs: [
                Tab(
                  child: Text(
                    "Enoncé",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    "Corrigé",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              pdf,
              SfPdfViewer.network(widget.url2),
            ],
          ),
        ),
      ),
    );
  }
}

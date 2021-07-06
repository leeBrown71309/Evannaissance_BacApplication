import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

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
              physics: AlwaysScrollableScrollPhysics(),
              indicatorColor: Colors.white,
              indicatorWeight: 7,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Epreuves",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          splashColor: Colors.lightBlue,
                          onPressed: () {},
                          icon: Icon(
                            Icons.download_outlined,
                            color: Colors.white,
                            size: 30,
                          ))
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Corrigés",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                          splashColor: Colors.lightBlue,
                          onPressed: () {},
                          icon: Icon(
                            Icons.download_outlined,
                            color: Colors.white,
                            size: 30,
                          ))
                    ],
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

class DownloadPdf extends StatefulWidget {
  DownloadPdf({required this.url, required this.url2});
  String url, url2;
  @override
  _DownloadPdfState createState() => _DownloadPdfState();
}

class _DownloadPdfState extends State<DownloadPdf> {
  var gauche_droite;
  var droite_gauche;

  @override
  Widget build(BuildContext context) {
    gauche_droite = widget.url;
    droite_gauche = widget.url2;
    final pdfController = PdfController(
      document: PdfDocument.openAsset(gauche_droite),
    );
    final pdfController2 = PdfController(
      document: PdfDocument.openAsset(gauche_droite),
    );
    var pdf = Container(
      height: 600,
      child: ListView(
        children: [
          PdfView(controller: pdfController),
        ],
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
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
              physics: AlwaysScrollableScrollPhysics(),
              indicatorColor: Colors.white,
              indicatorWeight: 7,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Epreuves",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          splashColor: Colors.lightBlue,
                          onPressed: () {},
                          icon: Icon(
                            Icons.download_outlined,
                            color: Colors.white,
                            size: 30,
                          ))
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Corrigés",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                          splashColor: Colors.lightBlue,
                          onPressed: () {},
                          icon: Icon(
                            Icons.download_outlined,
                            color: Colors.white,
                            size: 30,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              pdf,
              PdfView(controller: pdfController2),
            ],
          ),
        ),
      ),
    );
  }
}

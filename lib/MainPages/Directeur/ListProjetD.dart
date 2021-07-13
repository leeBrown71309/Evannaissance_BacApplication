import 'dart:convert';

import 'package:ergo/AuthPages/LoginScreen.dart';
import 'package:ergo/AuthPages/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Accueil.dart';
import 'PrintProjetD.dart';




class ListProjetD extends StatefulWidget {
var nom;
var titre;
ListProjetD(this.nom,this.titre);

  @override
  _ListProjetDState createState() => _ListProjetDState();
}

class _ListProjetDState extends State<ListProjetD> {

  // FormConnexion p = new FormConnexion();


  List ProjetList = [];
  bool isLoading = true;



  getProjet() async {
    var url = Uri.parse("http://192.168.1.16/workstation/flutter%20app%20auth/getprojetsd.php");
    var response = await http.get(url);
    if(response.statusCode == 200){
      setState(() {
        ProjetList = jsonDecode(response.body);
        isLoading = false;
      });

      return ProjetList;
    }
  }



  @override
  void initState() {
    super.initState();
    getProjet();

  }
  void gotToPrintProjectD (var a){
    Navigator.push(context, MaterialPageRoute(builder: (builder){
      return PrintProjetinfoD(a);
    }));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Liste des projets",
          style: TextStyle(
              fontSize: 20, color: Colors.orange
          ),),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (builder){
                return Accueil(valuen: widget.nom,titre: widget.titre);
              })),
          icon: Icon(Icons.arrow_back,color: Colors.black,),
        ),
      ),
      body: isLoading ? Center(child: CircularProgressIndicator())
          : ListView.builder(
          itemCount: ProjetList.length,
          itemBuilder: (context,index){
            return Card(
              color: Colors.black38,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      dense: true,
                      isThreeLine: true,
                      tileColor: Colors.lightBlue,
                      leading: Icon(Icons.table_chart,color: Colors.white,),
                      title: Text("Nom : "+ProjetList[index]["nomp"],
                        style: TextStyle(color: Colors.white,fontSize: 18),),
                      subtitle: Text("Code : "+ProjetList[index]["code"]
                          + "\n ID : "+ProjetList[index]["id"],
                        style: TextStyle(color: Colors.white,fontSize: 18),),
                      onTap: () => gotToPrintProjectD(ProjetList[index]),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                ],
              ),
            );
          }
      ),

    );
  }
}

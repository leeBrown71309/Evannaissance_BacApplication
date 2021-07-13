import 'package:ergo/MainPages/Accueil.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'PrintListEmp.dart';





class ListEmp extends StatefulWidget {


  @override
  _ListEmpState createState() => _ListEmpState();
}

class _ListEmpState extends State<ListEmp> {

  List ProjetList = [];
  bool isLoading = true;



  getEMP() async {
    var url = Uri.parse("http://192.168.1.16/workstation/flutter%20app%20auth/getemp.php");
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
    getEMP();

  }
  void gotToPrintListEmp (var a){
    Navigator.push(context, MaterialPageRoute(builder: (builder){
      return PrintListEmp(a);
    }));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Liste des employés",
          style: TextStyle(
              fontSize: 20, color: Colors.orange
          ),),
        backgroundColor: Colors.white,

      ),
      body: isLoading ? Center(child: CircularProgressIndicator())
          : ListView.builder(
          itemCount: ProjetList.length,
          itemBuilder: (context,index){
            return Column(
              children: [
                Card(
                  color: Colors.black38,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Card(
                        color: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          dense: true,
                          isThreeLine: true,
                          tileColor: Colors.lightBlue,
                          trailing: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,size: 20,),
                          leading: Icon(Icons.person_outline,color: Colors.white,),
                          title: Text("Nom : "+ProjetList[index]["nome"],
                                style: TextStyle(color: Colors.white,fontSize: 20),),

                          subtitle: Text("Matricule : "+ProjetList[index]["matricule"]+
                              "\nProfil : "+ProjetList[index]["titre"],
                                style: TextStyle(color: Colors.white,fontSize: 18),),

                          onTap: () => gotToPrintListEmp(ProjetList[index]),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            );
          }
      ),


    );
  }
}


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Modify.dart';


class PrintProjetinfo extends StatefulWidget {
  var projet;
  PrintProjetinfo(this.projet);

  @override
  _PrintProjetinfoState createState() => _PrintProjetinfoState();
}

class _PrintProjetinfoState extends State<PrintProjetinfo> {

  List ProjetList = [];
  bool isLoading = true;

  PrintProjet() async {
    var url = Uri.parse("http://192.168.1.16/workstation/flutter%20app%20auth/getprojets.php");
    var response = await http.get(url);
    if(response.statusCode == 200){
      setState(() {
        ProjetList = jsonDecode(response.body);
        isLoading = false;
      });
      print(ProjetList);
      return ProjetList;
    }
  }

  @override
  void initState() {
    super.initState();
    PrintProjet();
  }

  void gotToModihyProjectS (var a){
    Navigator.push(context, MaterialPageRoute(builder: (builder){
      return FormModify(a);
    }));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue,

        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back,color: Colors.black,),
        ),
      ),
      body:  Container(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Intilulé du projet :",
                    style: TextStyle(fontSize: 18,color: Colors.black),),
                    Text(widget.projet["nomp"],
                      style: TextStyle(fontSize: 20,color: Colors.black),),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      color: Colors.lightBlue,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Ink.image(
                                image: AssetImage("assets/fond1.jpg"),
                                fit: BoxFit.cover,
                                height: 250,
                                child: InkWell(
                                  onTap: () {},
                                  splashColor: Colors.blue.withAlpha(30),
                                ),
                              ),
                              Positioned(
                                  bottom: 25,
                                  right: 16,
                                  left: 16,
                                  child: Text(
                                    "Card de présentation",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                              Positioned(
                                  bottom: 60,
                                  right: 16,
                                  left: 16,
                                  child: Text(
                                    "Profiter d'une bonne gestion de vos projets",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                              const SizedBox(
                                width: 500,
                                height: 200,
                              )

                            ],
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton(
                            color: Colors.lightBlue,
                            padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
                            child: Column(
                              children: [
                                Icon(Icons.add,size: 35,color: Colors.white,),
                                Text("Modifier",style: TextStyle(color: Colors.white,
                                fontSize: 20),),
                              ],
                            ),
                          onPressed: () =>gotToModihyProjectS(widget.projet["id"]),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                        FlatButton(
                          color: Colors.lightBlue,
                          padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
                          child: Column(
                            children: [
                              Icon(Icons.add,size: 35,color: Colors.white,),
                              Text("Organisme",style: TextStyle(color: Colors.white,
                                  fontSize: 20),),
                            ],
                          ),
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                        FlatButton(
                          color: Colors.lightBlue,
                          padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
                          child: Column(
                            children: [
                              Icon(Icons.add,size: 35,color: Colors.white,),
                              Text("Organisme",style: TextStyle(color: Colors.white,
                                  fontSize: 20),),
                            ],
                          ),
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 10,),
                    Text("Infos du projet "+widget.projet["nomp"],
                      style: TextStyle(fontSize: 20,color: Colors.black),),
                    SizedBox(height: 10,),
                    Card(
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.confirmation_number_outlined,),
                            title: Text("ID : "+widget.projet["id"]),
                            subtitle: Text('ID unique du projet'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Card(
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                       ListTile(
                      leading: Icon(Icons.confirmation_number_outlined,),
                      title: Text("CODE : "+widget.projet["code"]),
                      subtitle: Text('Code unique du projet'),
                      ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Card(
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.bubble_chart_outlined,),
                            title: Text("ORGANISME : "+widget.projet["organisation"]),
                            subtitle: Text('Organisme client du projet'),
                            trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20,),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Card(
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.title,),
                            title: Text("Description du projet"),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("DESCRIPTION : "+widget.projet["description"])
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Card(
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.hourglass_bottom,),
                            title: Text("DEBUT : "+widget.projet["debut"]),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Card(
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.hourglass_disabled,),
                            title: Text("FIN : "+widget.projet["fin"]),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*
* Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.projet["nomp"],
            style: TextStyle(
                fontSize: 20, color: Colors.orange
            ),),
          backgroundColor: Colors.black54,
          actions: [
            IconButton(
              icon: Icon(Icons.mode_edit,color: Colors.orange,),
              onPressed: () =>gotToModihyProjectS(widget.projet["nomp"]),

            )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 0,),
                  Text("Code du projet : ",
                    style: TextStyle(color: Colors.orange, fontSize: 20),),
                  Text(widget.projet["code"],
                    style: TextStyle(color: Colors.orange, fontSize: 20),),
                  SizedBox(height: 10,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 0,),
                  Text("Organisation cliente : ",
                    style: TextStyle(color: Colors.orange, fontSize: 20),),
                  Text(widget.projet["organisation"],
                    style: TextStyle(color: Colors.orange, fontSize: 20),),
                  SizedBox(height: 10,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 0,),
                  Text("Date de début : ",
                    style: TextStyle(color: Colors.orange, fontSize: 20),),
                  Text(widget.projet["debut"],
                    style: TextStyle(color: Colors.orange, fontSize: 20),),
                  SizedBox(height: 10,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 0,),
                  Text("Date de fin : ",
                    style: TextStyle(color: Colors.orange, fontSize: 20),),
                  Text(widget.projet["fin"],
                    style: TextStyle(color: Colors.orange, fontSize: 20),),
                  SizedBox(height: 10,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 0,),
                  Text("Description : ",
                    style: TextStyle(color: Colors.orange, fontSize: 20),),
                  Text(widget.projet["description"],
                    style: TextStyle(color: Colors.orange, fontSize: 20),),
                  SizedBox(height: 10,),
                ],
              ),
            ],
          ),

        )
    );
* */
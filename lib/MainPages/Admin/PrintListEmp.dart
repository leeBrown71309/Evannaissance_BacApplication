import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'AddEmpProjet.dart';
import 'ListEmployes.dart';
import 'ModifyEmpProjet.dart';




class PrintListEmp extends StatefulWidget {
  var projet;
  PrintListEmp(this.projet);

  @override
  _PrintListEmpState createState() => _PrintListEmpState();
}

class _PrintListEmpState extends State<PrintListEmp> {

  List ProjetList = [];
  bool isLoading = true;

  PrintProjet() async {
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
    PrintProjet();
  }

  Future<void> SuppEmp(var titre) async {
    var url = Uri.parse("http://192.168.1.16/workstation/flutter%20app%20auth/suppemp.php");
    var response = await http.post(url,
        body: {
          "id" : widget.projet["id"],

        }
    );
    var data = jsonDecode(response.body);
    if(data == "Error"){

      //permet d'afficher une pop up
      showDialog(context: context,
        builder: (_) => ShowErrorDialog(),
        barrierDismissible: false,);
    }else{

      Navigator.push(context, MaterialPageRoute(
          builder: (builder){
            return ListEmp();
          }));


    }
  }

  Widget ShowAlertDialog(){
    return  AlertDialog(
      title: Text('Etes-vous sure ?',
        style: TextStyle(
            color: Colors.green),),

      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            FlatButton(onPressed: () => Navigator.pop(context, "cancel"),
                child: Text("Non",
                  style: TextStyle(
                      fontSize: 20),)),
            FlatButton(onPressed: () => SuppEmp(widget.projet["id"]),
                child: Text("Oui",
                  style: TextStyle(
                      fontSize: 20),)),
          ],
        )
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
      ),
    );
  }

  Widget ShowSuccesDialog(){
    return  AlertDialog(
      title: Text('Supprimé',
        style: TextStyle(
            color: Colors.green),),

      actions: [
        FlatButton(onPressed: () => gotToListEmp(),
            child: Text("Continuer",
              style: TextStyle(
                  fontSize: 20),))
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
      ),
    );
  }

  Widget ShowErrorDialog(){
    return  AlertDialog(
      title: Text('Erreur',
        style: TextStyle(
            color: Colors.red),),
      actions: [
        FlatButton(onPressed: () =>  Navigator.pop(context, 'Cancel'),

            child: Text("Essaie encore",
              style: TextStyle(
                  fontSize: 20),))
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
      ),
    );
  }

  void gotToListEmp (){
    Navigator.pop(context,);

  }

  void gotToAddEmpProjet (var a){
    Navigator.push(context, MaterialPageRoute(builder: (builder){
     return AddEmpProjet(a);
    }));
  }
  void gotToModifyEmpProjet (var a){
    Navigator.push(context, MaterialPageRoute(builder: (builder){
      return ModifyEmpProjet(a);
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
                    Text("Employé :",
                      style: TextStyle(fontSize: 18,color: Colors.black),),
                    Text(widget.projet["nome"],
                      style: TextStyle(fontSize: 25,color: Colors.black),),
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
                                image: AssetImage("assets/fond2.jpg"),
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
                                    "Profil employé",
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
                                    "Analyser les profils de vos employés",
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
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Ajouter, Modofier, Supprimer un employé \n"
                          "                         dans un projet",
                        style: TextStyle(fontSize: 20),),
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
                              Text("Ajouter",style: TextStyle(color: Colors.white,
                                  fontSize: 20),),
                            ],
                          ),
                          onPressed: () => gotToAddEmpProjet(widget.projet["id"]),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                        FlatButton(
                          color: Colors.lightBlue,
                          padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
                          child: Column(
                            children: [
                              Icon(Icons.mode_edit,size: 35,color: Colors.white,),
                              Text("Modifier",style: TextStyle(color: Colors.white,
                                  fontSize: 20),),
                            ],
                          ),
                          onPressed: () => gotToModifyEmpProjet(widget.projet["id"]),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                        FlatButton(
                          color: Colors.lightBlue,
                          padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
                          child: Column(
                            children: [
                              Icon(Icons.delete_forever_outlined,size: 35,color: Colors.white,),
                              Text("Supprimer",style: TextStyle(color: Colors.white,
                                  fontSize: 20),),
                            ],
                          ),
                          onPressed: () =>
                          //permet d'afficher une pop up
                          showDialog(context: context,
                            builder: (_) => ShowAlertDialog(),
                            barrierDismissible: false,),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: 10,),
                    Card(
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.confirmation_number_outlined,),
                            title: Text("MATRICULE : "+widget.projet["matricule"]),
                            subtitle: Text("Matricule de l 'employé"),
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
                            leading: Icon(Icons.person_outline,),
                            title: Text("PROFIL : "+widget.projet["titre"]),
                            subtitle: Text("Profil de l 'employé"),
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
                            leading: Icon(Icons.phone_android,),
                            title: Text("CONTACT ; "+widget.projet["phone"]),
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
                            leading: Icon(Icons.login,),
                            title: Text("LOGIN : "+widget.projet["login"]),
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
                            leading: Icon(Icons.email_outlined,),
                            title: Text("EMAIL : "+widget.projet["email"]),
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
                            leading: Icon(Icons.lock_outline,),
                            title: Text("MOT DE PASSE : "+widget.projet["password"]),
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
                            leading: Icon(Icons.lock_outline,),
                            title: Text("PROJETS : "+widget.projet["idp"]),
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
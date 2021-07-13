import 'dart:convert';

import 'package:ergo/AuthPages/LoginScreen.dart';
import 'package:ergo/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../Accueil.dart';
import 'Projet.dart';


class CreateProjectS extends StatefulWidget {

  var titre ;
  CreateProjectS({this.titre});

  @override
  _CreateProjectSState createState() => _CreateProjectSState();
}

class _CreateProjectSState extends State<CreateProjectS> {

  //la clé de validation du formulaire
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String nomp='';
  String code= '';
  String desc='';
  String organisation= '';
  String debut= '';
  String fin= '';


// les controller qui permettent de controller les information entrer
  // dans un champ d'un formulaire TextFormField
  TextEditingController codeController =  TextEditingController();
  TextEditingController descController =  TextEditingController();
  TextEditingController nompController =  TextEditingController();
  TextEditingController organisationController =  TextEditingController();
  TextEditingController debutController =  TextEditingController();
  TextEditingController finController =  TextEditingController();


  void goToNextPage() {
    //permet de naviguer d'une page à une autre avec une animation
    Navigator.pop(context);

  }


  Widget ShowErrorDialog(){
    return  AlertDialog(
      title: Text('Erreur',
        style: TextStyle(
            color: Colors.red),),
      content: Image.asset("assets/error.png"),
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
  Future<void> CreateProjet()async {
    var url = Uri.parse("http://192.168.1.16/workstation/flutter%20app%20auth/createprojets.php");
    var response = await http.post(url,
        body: {
          "nomp" : nompController.text,
          "code" : codeController.text,
          "description" : descController.text,
          "organisation" : organisationController.text,
          "debut" : debutController.text,
          "fin" : finController.text,
        }
    );
    var data = jsonDecode(response.body);
    if(data == "Success"){
      goToNextPage();
    }else{
      //permet d'afficher une pop up
      showDialog(context: context,
        builder: (_) => ShowErrorDialog(),
        barrierDismissible: false,);


    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2B2929),

      appBar: AppBar(
        centerTitle: true,
        title: Text("Créer le Projet ?",
          style: TextStyle(
              fontSize: 20, color: Colors.orange
          ),),
        backgroundColor: Colors.black54,
        actions: [
          IconButton(
            icon: Icon(Icons.check,color: Colors.orange,),
            onPressed: () => CreateProjet(),

          )
        ],
      ),
      body:  Container(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 20.0,
          ),

          child: Container(
            child: Column(
              children: [
                Form(
                    key:_formkey,
                    child:
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          Text(
                            'Nom du projet : ',
                            style: kLabelStyleProjet,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.topLeft,
                            decoration: DecoCreateProjet,
                            height: 60.0,
                            child: TextFormField(
                              controller: nompController,
                              //change l'etat du champ email
                              onChanged: (value) => setState(() => nomp = value),
                              validator: (value) =>value!.isEmpty ?
                              'Enter votre nom' : null,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          SizedBox(height: 10.0),

                          Text(
                            'Code du projet : ',
                            style: kLabelStyleProjet,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.topLeft,
                            decoration: DecoCreateProjet,
                            height: 60.0,
                            child: TextFormField(
                              controller: codeController,
                              //change l'etat du champ email
                              onChanged: (value) => setState(() => code= value),
                              validator: (value) =>value!.isEmpty ?
                              'Enter le code du projet' : null,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                  fontSize: 20
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),

                          SizedBox(height: 10.0),
                          Text(
                            'Description du projet : ',
                            style: kLabelStyleProjet,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.topLeft,
                            decoration: DecoCreateProjet,
                            height: 200.0,
                            child: TextFormField(
                              maxLines: 10,
                              textAlign: TextAlign.start,

                              controller: descController,
                              //change l'etat du champ email
                              onChanged: (value) => setState(() => desc = value),
                              validator: (value) =>value!.isEmpty ?
                              'Enter une description' : null,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),

                          SizedBox(height: 10.0),
                          Text(
                            'Organisme client: ',
                            style: kLabelStyleProjet,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.topLeft,
                            decoration: DecoCreateProjet,
                            height: 60.0,
                            child: TextFormField(
                              controller: organisationController,
                              //change l'etat du champ email
                              onChanged: (value) => setState(() => organisation = value),
                              validator: (value) =>value!.isEmpty ?
                              " Entrer l'organisation cliente" : null,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),

                          SizedBox(height: 10.0),
                          Text(
                            'Date de début  : ',
                            style: kLabelStyleProjet,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.topLeft,
                            decoration: DecoCreateProjet,
                            height: 60.0,
                            child: TextFormField(
                              controller: debutController,
                              //change l'etat du champ email
                              onChanged: (value) => setState(() => debut = value),
                              validator: (value) =>value!.isEmpty ?
                              'Enter une date' : null,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                              ),
                              decoration: InputDecoration(
                                hintText: "yyyy/mmmm/dddd",
                                hintStyle: TextStyle(color: Colors.white54),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0,left: 10),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),

                          SizedBox(height: 10.0),
                          Text(
                            'Date de fin  : ',
                            style: kLabelStyleProjet,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.topLeft,
                            decoration: DecoCreateProjet,
                            height: 60.0,
                            child: TextFormField(
                              controller: finController,
                              //change l'etat du champ email
                              onChanged: (value) => setState(() => fin = value),
                              validator: (value) =>value!.isEmpty ?
                              'Enter une date' : null,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                              ),
                              decoration: InputDecoration(
                                hintText: "yyyy/mmmm/dddd",
                                hintStyle: TextStyle(color: Colors.white54),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0,left: 10),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                        ]
                    )
                )
              ],
            ),
          )
        ),
      )
    );
  }
}





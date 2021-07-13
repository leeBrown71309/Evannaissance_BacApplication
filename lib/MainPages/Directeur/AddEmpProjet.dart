import 'package:ergo/MainPages/Directeur/ListProjetD.dart';
import 'package:ergo/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Admin/ListEmployes.dart';


class AddEmpProjet extends StatefulWidget {
  var idp;
  var nom;
  var titre;
  AddEmpProjet(this.nom,this.titre);

  @override
  _AddEmpProjetState createState() => _AddEmpProjetState();
}

class _AddEmpProjetState extends State<AddEmpProjet> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String nomp='';
  String nome='';





// les controller qui permettent de controller les information entrer
  // dans un champ d'un formulaire TextFormField
  TextEditingController nomeController =  TextEditingController();
  TextEditingController nompController =  TextEditingController();



  void goToNextPage() {
    Navigator.push(context, MaterialPageRoute(
        builder: (builder){
          return ListProjetD(widget.nom,widget.titre);
        }));
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
//future
  Future<void> AddempProjet(var titre)async {
    var url = Uri.parse("http://192.168.1.16/workstation/flutter%20app%20auth/addempprojet.php");
    var response = await http.post(url,
        body: {
          "nomp" : nompController.text,
          "nome" : nomeController.text,
          "titre" : titre,
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
  var t;

  Widget profil(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton<String>(
        dropdownColor: Colors.black38,
        isExpanded: true,
        value: t,
        icon: const Icon(Icons.arrow_drop_down_circle_outlined,
          color: Colors.white,),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.black,fontSize: 16),

        onChanged: (String? newValue) {
          setState(() {
            t = newValue!;
          });
        },
        items: <String>['Chef projet']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                children: [
                  Icon(Icons.title,color: Colors.white,),
                  SizedBox(width: 5,),
                  Text(value,
                    style: TextStyle(color: Colors.white),),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF2B2929),

        appBar: AppBar(
          centerTitle: true,
          title: Text("Ajouter cet employé au projet ?",
            style: TextStyle(
                fontSize: 20, color: Colors.orange
            ),),
          backgroundColor: Colors.black54,
          actions: [
            IconButton(
              icon: Icon(Icons.check,color: Colors.orange,),
              onPressed: () {

                AddempProjet(t);
              }

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
                                  keyboardType: TextInputType.number,
                                  controller: nompController,
                                  //change l'etat du champ email
                                  onChanged: (value) => setState(() => nomp = value),
                                  validator: (value) =>value!.isEmpty ?
                                  "Entrer l'ID de ce projet" : null,
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
                              SizedBox(height: 10,),

                              SizedBox(height: 10.0),
                              Text(
                                 "Nom de l'employé",
                                style: kLabelStyleProjet,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                alignment: Alignment.topLeft,
                                decoration: DecoCreateProjet,
                                height: 60.0,
                                child: TextFormField(
                                  controller: nomeController,
                                  //change l'etat du champ email
                                  onChanged: (value) => setState(() => nome = value),
                                  validator: (value) =>value!.isEmpty ?
                                  "Entrer le nom de l'employé" : null,
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
                              SizedBox(height: 10,),
                              Text(
                                'Titre',
                                style: kLabelStyleProjet,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: DecoCreateProjet,
                                height: 60.0,
                                child:  profil(),
                              ),
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

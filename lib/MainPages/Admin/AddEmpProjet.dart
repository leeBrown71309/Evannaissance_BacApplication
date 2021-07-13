import 'package:ergo/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'ListEmployes.dart';


class AddEmpProjet extends StatefulWidget {
  var idpe;
  AddEmpProjet(this.idpe);

  @override
  _AddEmpProjetState createState() => _AddEmpProjetState();
}

class _AddEmpProjetState extends State<AddEmpProjet> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String idp='';
  String ide='';


// les controller qui permettent de controller les information entrer
  // dans un champ d'un formulaire TextFormField
  TextEditingController idpController =  TextEditingController();


  void goToNextPage() {
    Navigator.push(context, MaterialPageRoute(
        builder: (builder){
          return ListEmp();
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
  Future<void> AddempProjet()async {
    var url = Uri.parse("http://192.168.1.16/workstation/flutter%20app%20auth/addempprojet.php");
    var response = await http.post(url,
        body: {
          "idp" : idpController.text,
          "id" : widget.idpe,
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
          title: Text("Ajouter cet employé au projet ?",
            style: TextStyle(
                fontSize: 20, color: Colors.orange
            ),),
          backgroundColor: Colors.black54,
          actions: [
            IconButton(
              icon: Icon(Icons.check,color: Colors.orange,),
              onPressed: () => AddempProjet(),

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
                                'ID du projet : ',
                                style: kLabelStyleProjet,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                alignment: Alignment.topLeft,
                                decoration: DecoCreateProjet,
                                height: 60.0,
                                child: TextFormField(
                                  controller: idpController,
                                  //change l'etat du champ email
                                  onChanged: (value) => setState(() => idp = value),
                                  validator: (value) =>value!.isEmpty ?
                                  "Entrer l'ID de ce projet" : null,
                                  keyboardType: TextInputType.number,
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

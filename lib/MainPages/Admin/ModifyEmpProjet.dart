import 'package:ergo/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'ListEmployes.dart';


class ModifyEmpProjet extends StatefulWidget {
  var idpe;
  ModifyEmpProjet(this.idpe);

  @override
  _ModifyEmpProjetState createState() => _ModifyEmpProjetState();
}

class _ModifyEmpProjetState extends State<ModifyEmpProjet> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String ide='';
  String name='';
  String matricule= '';
  //String titre='';
  String phone= '';
  String login= '';
  String email='';
  String pwd= '';
  String idp='';

  bool  _isSecret = true;

  final RegExp emailValidator = RegExp(r"[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]+");


  //Controller pour le formulaire

  TextEditingController nomController = new TextEditingController();
  TextEditingController matriculeController = new TextEditingController();
  //TextEditingController titreController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController loginController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();
  TextEditingController idpController = new TextEditingController();


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

  Future<void> ModifyempProjet(var titre)async {
    var url = Uri.parse("http://192.168.1.16/workstation/flutter%20app%20auth/modifyempprojet.php");
    var response = await http.post(url,
        body: {
          "idp" : idpController.text,
          "id" : widget.idpe,
          "nome" : nomController.text,
          "matricule" : matriculeController.text,
          "titre" : titre,
          "phone" : phoneController.text,
          "login" : loginController.text,
          "email" : emailController.text,
          "password" : pwdController.text,
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
        items: <String>['Directeur', 'Secrétaire','Admin', 'Chef projet','Comptable',]
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
          title: Text("Modifier cet employé au projet ?",
            style: TextStyle(
                fontSize: 20, color: Colors.orange
            ),),
          backgroundColor: Colors.black54,
          actions: [
            IconButton(
              icon: Icon(Icons.check,color: Colors.orange,),
              onPressed:  !emailValidator.hasMatch(email)? null :() {
                if(_formkey.currentState!.validate()){
                  ModifyempProjet(t);

                }
              },

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
                                'Nom complet',
                                style: kLabelStyle,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: kBoxDecorationStyle,
                                height: 60.0,
                                child: TextFormField(
                                  controller: nomController,
                                  //change l'etat du champ nom
                                  onChanged: (value) => setState(() => name = value),
                                  validator: (value) =>value!.isEmpty ?
                                  'Entrer votre nom' : null,
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14.0),
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    hintText: 'Ex: Macky SALL',
                                    hintStyle: kHintTextStyle,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Matricule',
                                style: kLabelStyle,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: kBoxDecorationStyle,
                                height: 60.0,
                                child: TextFormField(
                                  controller: matriculeController,
                                  //change l'etat du champ nom
                                  onChanged: (value) => setState(() => matricule = value),
                                  validator: (value) =>value!.isEmpty || value.length < 7 ?
                                  'Matricule trop cours' : null,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14.0),
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    hintText: 'Ex: Xxxxxx',
                                    hintStyle: kHintTextStyle,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Titre',
                                style: kLabelStyle,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: kBoxDecorationStyle,
                                height: 60.0,
                                child:  profil(),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                'Téléphone',
                                style: kLabelStyle,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: kBoxDecorationStyle,
                                height: 60.0,
                                child: TextFormField(
                                  controller: phoneController,
                                  //change l'etat du champ nom
                                  onChanged: (value) => setState(() => phone = value),
                                  validator: (value) =>value!.isEmpty || value.length<9 ?
                                  'Numéro trop cours' : null,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14.0),
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    hintText: 'Ex: 77 xxx xx xx',
                                    hintStyle: kHintTextStyle,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Login',
                                style: kLabelStyle,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: kBoxDecorationStyle,
                                height: 60.0,
                                child: TextFormField(
                                  controller: loginController,
                                  //change l'etat du champ nom
                                  onChanged: (value) => setState(() => login = value),
                                  validator: (value) =>value!.isEmpty?
                                  'Entrer votre login' : null,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14.0),
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    hintText: 'Ex: Macky71',
                                    hintStyle: kHintTextStyle,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Email',
                                style: kLabelStyle,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: kBoxDecorationStyle,
                                height: 60.0,
                                child: TextFormField(
                                  controller: emailController,
                                  //change l'etat du champ email
                                  onChanged: (value) => setState(() => email = value),
                                  validator: (value) =>value!.isEmpty || !emailValidator.hasMatch(value) ?
                                  'Entrer un Email valide' : null,
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14.0),
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                    hintText: 'Enter votre Email',
                                    hintStyle: kHintTextStyle,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),

                              Text(
                                'Mot de passe',
                                style: kLabelStyle,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: kBoxDecorationStyle,
                                height: 60.0,
                                child: TextFormField(
                                  controller: pwdController,
                                  onChanged: (value) => setState(() => pwd = value),
                                  validator: (value) => value!.length<6 ? 'Mot de passe trop court' : null,
                                  obscureText:  _isSecret,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                  ),
                                  decoration: InputDecoration(

                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14.0),
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: Colors.white,
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: (){
                                        setState(() {
                                          _isSecret = !_isSecret;
                                        });
                                      },
                                      child: Icon(
                                        !_isSecret ?
                                        Icons.visibility : Icons.visibility_off,
                                        color: Colors.white,),
                                    ),
                                    hintText: 'Enter votre mot de passe',
                                    hintStyle: kHintTextStyle,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'ID du projet : ',
                                style: kLabelStyle,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                alignment: Alignment.topLeft,
                                decoration: kBoxDecorationStyle,
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
                                    prefixIcon: Icon(
                                      Icons.confirmation_number_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),

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

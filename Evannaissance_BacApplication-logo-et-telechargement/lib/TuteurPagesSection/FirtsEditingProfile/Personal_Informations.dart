import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:e_bac/AuthScreens/login_screen.dart';
import 'package:e_bac/Loading/Loading.dart';
import 'package:e_bac/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Bienvenue.dart';


class PersonalInformations extends StatefulWidget {
  const PersonalInformations({Key? key}) : super(key: key);

  @override
  _PersonalInformationsState createState() => _PersonalInformationsState();
}

class _PersonalInformationsState extends State<PersonalInformations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF3594DD),
                      Color(0xFF4563DB),
                      Color(0xFF5036D5),
                      Color(0xFF5B16D0),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                //color: Colors.white,
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Entrer vos informations\n          perspnnelles',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 50.0),
                      TuteurPersonalInformations(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  }




class TuteurPersonalInformations extends StatefulWidget {
  const TuteurPersonalInformations({Key? key}) : super(key: key);

  @override
  _TuteurPersonalInformationsState createState() => _TuteurPersonalInformationsState();
}

class _TuteurPersonalInformationsState extends State<TuteurPersonalInformations> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


  String email='';
  String fname= '';
  String age= '';
  String number = '';
  final RegExp emailValidator = RegExp(r"[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]+");

  //Controller pour le formulaire
  TextEditingController userFullName = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();



  Future<void> personnalinfos()async {
    var url = Uri.parse("https://bacplusplus.000webhostapp.com/personnalinfos.php");
    var response = await http.post(url,
        body: {
          "fullname" : userFullName.text,
          "age" : ageController.text,
          "phone" : numberController.text,
          "email" : emailController.text,

        }
    );
    var data = jsonDecode(response.body);
    if(data == "Error"){

      //permet d'afficher une pop up
      showDialog(context: context,
        builder: (_) => ShowErrorDialog(),
        barrierDismissible: false,);
    }else{

      //permet d'afficher une pop up
      showDialog(context: context,
        builder: (_) => ShowSuccesDialog(),
        barrierDismissible: false,);


    }
  }

  Widget ShowSuccesDialog(){
    return  AlertDialog(
      title: Text('Réussi',
        style: TextStyle(
            color: Colors.green),),
      content: Image.asset("assets/success.png"),
      actions: [
        FlatButton(onPressed: () => showDialog(context: context,
          builder :(_) => confirmPersonnalInformations(),
        ),
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
      content: Text("L'email ne correspond pas",
        style: TextStyle(
            color: Colors.red),),
      actions: [
        FlatButton(onPressed: () =>  Navigator.pop(context, 'Cancel'),

            child: Text("Essae encore",
              style: TextStyle(
                  fontSize: 20),))
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
      ),
    );
  }





  void goToNextPage() {
    Navigator.push(context, MaterialPageRoute(builder:
        (context) {
      return TuteurProfil();
    }));
  }

  Widget confirmPersonnalInformations (){
    //Demande à l'utilisateur de confirmer ses info avec une pop up
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      title: Text('Confirmer ?',
      style: TextStyle(fontSize: 20,
      fontFamily: "Montserrat")
        ,),
      content: Text('Ces informations seront \nvisible par tout le monde.\n \n Voulez vous continuer?',
      style: TextStyle(fontSize: 20,fontFamily: 'Montserrat'),
      ),

      actions: [
        TextButton(onPressed: ()=> Navigator.pop(context),
            child: Text('Modifier',style: TextStyle(fontSize: 18),)),
        SizedBox(width: 30,),
        TextButton(onPressed: ()=> goToNextPage(),
            child: Text('Continuer',style: TextStyle(fontSize: 18))),
        SizedBox(width: 10,),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Form(
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
                controller: userFullName,
                //change l'etat du champ nom
                onChanged: (value) => setState(() => fname = value),
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
                  hintText: 'Entrer votre nom',
                  hintStyle: kHintTextStyle,
                ),
              ),
            ),

            SizedBox(height: 10,),
            //il faut changer de controller le onchange et le validator
            Text(
              'Âge',
              style: kLabelStyle,
            ),
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 60.0,
              child: TextFormField(
                controller: ageController,
                //change l'etat du champ nom
                onChanged: (value) => setState(() => age = value),
                validator: (value) =>value!.isEmpty ?
                'Entrer votre âge' : null,
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
                  hintText: 'Entrer votre âge',
                  hintStyle: kHintTextStyle,
                ),
              ),
            ),

            SizedBox(height: 10,),
            //il faut changer de controller le onchange et le validator
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
                controller: numberController,
                //change l'etat du champ nom
                onChanged: (value) => setState(() => number = value),
                validator: (value) =>value!.length<9 ?
                'Entrer un numéro valide' : null,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.phone_android,
                    color: Colors.white,
                  ),
                  hintText: 'Entrer votre numéro de téléphone ',
                  hintStyle: kHintTextStyle,
                ),
              ),
            ),
            SizedBox(height: 10,),
            //il faut changer de controller le onchange et le validator
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
                //change l'etat du champ nom
                onChanged: (value) => setState(() => email = value),
                validator: (value) =>value!.isEmpty || !emailValidator.hasMatch(value) ?
                'Entrer le même Email ' : null,
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
                  hintText: 'Entrer votre Email',
                  hintStyle: kHintTextStyle,
                ),
              ),
            ),


            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 25.0),
              width: double.infinity,
              child: RaisedButton(
                elevation: 5.0,
                onPressed: !emailValidator.hasMatch(email)? null :() {
                  if(_formkey.currentState!.validate()){
                  personnalinfos();
                  }

                },
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Colors.white,
                child: Text(
                  'Valider',
                  style: TextStyle(
                    color: Color(0xFF527DAA),
                    letterSpacing: 1.5,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
           Center(
             child:  Text('Remplir le formulaire',
               style: TextStyle(fontSize: 20,color: Colors.white,
               fontFamily: 'Montserrat'),),
           )
          ],
        ),
      ),
    );
  }
}







class TuteurProfil extends StatefulWidget {
  const TuteurProfil({Key? key}) : super(key: key);

  @override
  _TuteurProfilState createState() => _TuteurProfilState();
}

class _TuteurProfilState extends State<TuteurProfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test profil'),
        backgroundColor: Colors.teal,
      ),
      body: Container(),
    );
  }
}

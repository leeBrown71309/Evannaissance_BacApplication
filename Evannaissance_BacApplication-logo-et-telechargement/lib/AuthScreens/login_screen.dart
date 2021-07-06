
import 'dart:convert';

import 'package:e_bac/TuteurPagesSection/FirtsEditingProfile/Bienvenue.dart';
import 'package:e_bac/TuteurPagesSection/FirtsEditingProfile/EditeProfileImage.dart';
import 'package:e_bac/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'SignUp_Screen.dart';
import 'TypeUsers.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
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
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      FormConnexion(),
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

class FormConnexion extends StatefulWidget {

  const FormConnexion({Key? key}) : super(key: key);

  @override
  _FormConnexionState createState() => _FormConnexionState();
}




class _FormConnexionState extends State<FormConnexion> {
  //pour la checkbox
  bool _rememberMe = false;
  //pour cacher les champs password
  bool _isSecret = true;
  //la clé de validation du formulaire
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String email='';
  String pwd= '';
  final RegExp emailValidator = RegExp(r"[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]+");


  void goToNextPage() {
    //permet de naviguer d'une page à une autre avec une animation
    Navigator.push(context, PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 500),
    transitionsBuilder: (context, animation, animationTime, child) {
      animation= CurvedAnimation(parent: animation,
      curve: Curves.elasticOut);
      return ScaleTransition(scale: animation,
      alignment: Alignment.center,
      child: child,
    );
    },
    pageBuilder:
    (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return BienvenuePage();
    }
    ));
  }

  Widget ShowSuccesDialog(){
    return  AlertDialog(
      title: Text('Réussi',
      style: TextStyle(
          color: Colors.green),),
      content: Image.asset("assets/success.png"),
      actions: [
        FlatButton(onPressed: () => goToNextPage(),
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

  //boutton retour vers la page du chooix d'utilisateur
  Widget _buildReturnChoiseUserButton() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget>[
          Text('Choix  du type d\'utilisateur !',
            style: TextStyle(fontSize: 15,color: Colors.white,
                fontFamily: 'Montserrat'),
          ),
          SizedBox(height: 30,),
          RaisedButton(onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context)
              {
                return ChoiceUserType();
              }
              )
          ),


            padding: EdgeInsets.only(left: 70,right: 70,top: 20,bottom: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            color: Colors.white,
            child: Text('Qui êtes-vous ?',
              style: TextStyle(fontFamily: 'Montserrat',
                  fontSize: 20,
                  color: Colors.indigo),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Mot de passe oublier ?',
          style: kLabelStyle,
        ),
      ),
    );
  }


  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          Text(
            'Rester connecter',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

// les controller qui permettent de controller les information entrer
  // dans un champ d'un formulaire TextFormField
  TextEditingController emailController =  TextEditingController();
  TextEditingController pwdController =  TextEditingController();

//methode permettant de recuperer les valeurs des champs a l'aide des controller
  // de les envoyer vers le serveur à traver l'url et de decoder le json
  Future<void> login()async {
    var url = Uri.parse("https://bacplusplus.000webhostapp.com/login.php");
    var response = await http.post(url,
      body: {
        "email" : emailController.text,
        "password" : pwdController.text,
      }
    );
    var data = jsonDecode(response.body);
    if(data == "Success"){
      //permet d'afficher une pop up
     showDialog(context: context,
         builder: (_) => ShowSuccesDialog(),
     barrierDismissible: false,);
    }else{
      //permet d'afficher une pop up
      showDialog(context: context,
        builder: (_) => ShowErrorDialog(),
        barrierDismissible: false,);


    }
  }


  void NextPageLoanding(){
    //la page suivante apre le loader
    Navigator.push(context,
        MaterialPageRoute(builder: (context){
          return LoginScreen();
        }
        )
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
              'Enter un Email valide' : null,
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
                suffixIcon: InkWell(
                  onTap: (){
                    setState(() {
                      //supprime le champs

                    });
                  },
                  child: Icon(
                    Icons.close,
                  color: Colors.white,),
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
              obscureText: _isSecret,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Montserrat',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.lock,
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
                hintText: 'Enter votre Mot de passe',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),

          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildRememberMeCheckbox(),
              _buildForgotPasswordBtn(),
            ],
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            width: double.infinity,
            child: RaisedButton(
              elevation: 5.0,
              //si le champ email n'est pas correcte le boutton est invalide sinn...
              onPressed: !emailValidator.hasMatch(email)? null :() {
                if(_formkey.currentState!.validate()){
                  login();
                }
              },
              padding: EdgeInsets.only(top: 25,left: 25,right: 25,bottom: 25),
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
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               GestureDetector(
                 onTap: () => Navigator.push(
                     context, MaterialPageRoute(
                     builder: (context){
                       return SignUpScreen();})),
                 child: RichText(
                   text: TextSpan(
                     children: [
                       TextSpan(
                         text:  "Vous n'avez pas de compte ?",
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 18.0,
                           fontWeight: FontWeight.w400,
                         ),
                       ),
                       TextSpan(
                         text: 'Créer ici',
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 18.0,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
               SizedBox(height: 30,),
               _buildReturnChoiseUserButton()
             ],
           )
         )
        ],
      ),
      ),
    );
}
}

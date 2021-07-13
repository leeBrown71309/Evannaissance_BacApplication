import 'package:ergo/AuthPages/LoginScreen.dart';
import 'package:ergo/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Accueil.dart';



class AuthAdmin extends StatefulWidget {
  @override
  _AuthAdminState createState() => _AuthAdminState();
}

class _AuthAdminState extends State<AuthAdmin> {


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
                    stops: [0.1, 0.7,],
                    colors: [
                      Color(0xFF28282A),
                      Color(0xFF1C1B1B),
                    ],
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
                          color: Colors.orange,
                          fontFamily: 'Montserrat',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      FormAdmin(),
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


class FormAdmin extends StatefulWidget {
  const FormAdmin({Key? key}) : super(key: key);

  @override
  _FormAdminState createState() => _FormAdminState();
}

class _FormAdminState extends State<FormAdmin> {
  //pour la checkbox
  bool _rememberMe = false;
  //pour cacher les champs password
  bool _isSecret = true;
  //la clé de validation du formulaire
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String logina='';
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
          return Accueil(valuen : logina,titre : t);
        }
    ));
  }




  Widget ShowSuccesDialog(){
    return  AlertDialog(
      title: Text('Réussi',
        style: TextStyle(
            color: Colors.green),),
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
  TextEditingController loginController =  TextEditingController();
  TextEditingController pwdController =  TextEditingController();


  var t;
  var gettitre;
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
            gettitre = newValue;
          });
        },
        items: <String>['Admin']
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

//methode permettant de recuperer les valeurs des champs a l'aide des controller
  // de les envoyer vers le serveur à traver l'url et de decoder le json
  Future<void> loginAdmin(var titre)async {
    var url = Uri.parse("http://192.168.1.16/workstation/flutter%20app%20auth/authadmin.php");
    var response = await http.post(url,
        body: {
          "login" : loginController.text,
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
                //change l'etat du champ email
                onChanged: (value) => setState(() => logina = value),
                validator: (value) =>value!.isEmpty ?
                'Enter le login Admin' : null,
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
            SizedBox(height: 10.0),
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
                validator: (value) => value!.length<5 ? 'Mot de passe trop court' : null,
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
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    loginAdmin(t);
                  }

                },
                padding: EdgeInsets.only(top: 15,left: 15,right: 15,bottom: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white,
                child: Text(
                  'Valider',
                  style: TextStyle(
                    color: Colors.orange,
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
                       return LoginScreen();})),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:  "Se loger  ? ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Créer ici',
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}


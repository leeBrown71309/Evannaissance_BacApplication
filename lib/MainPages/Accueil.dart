import 'dart:ffi';
import 'package:ergo/AuthPages/LoginScreen.dart';
import 'package:ergo/AuthPages/RegisterScreen.dart';
import 'package:ergo/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../test.dart';
import 'Admin/ListEmployes.dart';
import 'Chef projet/ListProjetChef.dart';
import 'Directeur/AddEmpProjet.dart';
import 'Directeur/ListProjetD.dart';
import 'Directeur/ModifyProjetD.dart';
import 'Secrétaire/CreateProject.dart';
import 'Secrétaire/PrintProjet.dart';
import 'Secrétaire/Projet.dart';

class Accueil extends StatelessWidget {
  //pour ouvrir le drawer
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  void _openDrawer () {
    _drawerKey.currentState!.openDrawer();
  }
  var valuen;
  var titre;
  Accueil({this.valuen,this.titre});



  @override
  Widget build(BuildContext context) {

    Widget ShowErrorDialog(){
      return  AlertDialog(
        title: Text('Erreur',
          style: TextStyle(
              color: Colors.red),),
        content: Text("Votre fonction ne vous permet pas l'accès à cette zone"),
        actions: [
          FlatButton(onPressed: () =>  Navigator.pop(context, 'Cancel'),

              child: Text("Quitter",
                style: TextStyle(
                    fontSize: 20),))
        ],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
        ),
      );
    }

    void gotToCreateProjectS (){
      Navigator.push(context, MaterialPageRoute(builder: (builder){
        return CreateProjectS();
      }));
    }

    void gotToAddEMP (){
      Navigator.push(context, MaterialPageRoute(builder: (builder){
        return SignUpScreen();
      }));
    }

    void gotToListEMP (var nom, var titre){
      Navigator.push(context, MaterialPageRoute(builder: (builder){
        return ListEmp(nom,titre);//ListEmp();
      }));
    }
    void gotToModifyProjetD (var nom, var titre){
      Navigator.push(context, MaterialPageRoute(builder: (builder){
        return ListProjetD(nom,titre);//ListEmp();
      }));
    }

    void gotToAddChef (var nom, var titre){
      Navigator.push(context, MaterialPageRoute(builder: (builder){
        return AddEmpProjet(nom,titre);//ListEmp();
      }));
    }

    void gotToListProjetC (var nom, var titre){
      Navigator.push(context, MaterialPageRoute(builder: (builder){
        return ListProjetC(nom,titre);//ListEmp();
      }));
    }

    /*
    * if (titre == "Secrétaire"){
                  gotToCreateProjectS();
                }else if(titre == "Admin" || titre == "admin"){
                  gotToAddEMP();
                }else if(titre == "Directeur"){
                  gotToModifyProjetD();
                }
    * */


    return DefaultTabController(
        length: 2,
        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
              elevation: 7,
              label: Text("New", style:
              TextStyle(color: Colors.white, fontSize: 15),),
              backgroundColor: Colors.orange,
              icon: Icon(Icons.add, color: Colors.white, size: 20,),
              onPressed: () {
               switch(titre){
                 case "Secrétaire":
                   gotToCreateProjectS();
                   break;
                 case "Admin":
                   gotToAddEMP();
                   break;
                 case "Directeur":
                   gotToAddChef(valuen,titre);
                   break;
                 default:
                   showDialog(context: context,
                     builder: (_) => ShowErrorDialog(),
                     barrierDismissible: false,);

               }
              }
          ),
          key: _drawerKey,
          appBar: AppBar(
            centerTitle: true,
            title: Text("Ergo",
              style: TextStyle(
                  fontSize: 20, color: Colors.orange
              ),),
            backgroundColor: Colors.black54,
            leading: IconButton(icon: Icon(Icons.menu_outlined,
              size: 30,),
              splashColor: Colors.orange,
              onPressed: _openDrawer,
            ),
            actions: [
              IconButton(
                  splashColor: Colors.orange,
                  onPressed: () {},
                  icon: Icon(Icons.search_rounded,
                    size: 30,)),
              SizedBox(width: 10,),
              IconButton(
                  splashColor: Colors.orange,
                  onPressed: () {},
                  icon: Icon(Icons.notifications_active_outlined,
                    size: 30,))
            ],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: Colors.black54,
              ),
            ),
            bottom: TabBar(
              physics: AlwaysScrollableScrollPhysics(),
              indicatorColor: Colors.white,
              indicatorWeight: 7,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.home, color: Colors.white,),
                      Text(
                        "Accueil",
                        style: TextStyle(
                            fontSize: 18, color: Colors.orange),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.table_chart_outlined, color: Colors.white,),
                      Text(
                        "Projets",
                        style: TextStyle(
                            fontSize: 18, color: Colors.orange),
                      ),
                    ],
                  ),
                ),
              ],

            ),
          ),

          drawer: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Color(0x741D1D1C),
              //other styles
            ),
            child: Drawer(
              elevation: 10,
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color(0xFF343436),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                  backgroundColor: Colors.orange,
                                  radius: 50,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.camera_alt_outlined,
                                      color: Colors.white, size: 35,),
                                  )
                              ),
                              Column(
                                children: [
                                  Text(valuen,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18
                                    ),),
                                  SizedBox(height: 10,),
                                  Text(titre,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18
                                    ),)
                                ],
                              ),
                            ],
                          )
                        ],
                      )
                  ),

                  Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 18),
                      width: 300,
                      height: 45,
                      color: Colors.black54,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.tab, color: Colors.white,),
                          TextButton(
                            onPressed: () {},
                            child: Text("Accueil",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 19
                              ),),

                          ),
                        ],
                      )
                  ),
                  SizedBox(height: 5,),
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 18),
                    width: 300,
                    height: 45,
                    color: Colors.black54,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.workspaces_outline, color: Colors.white,),
                        SizedBox(width: 5,),
                        Text("Espaces de travail",
                          style: TextStyle(
                              color: Colors.white, fontSize: 20
                          ),),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                        tileColor: Colors.black87,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        leading: Icon(
                          Icons.group_outlined, color: Colors.blue,),
                        title: Text("Projet",
                          style: TextStyle(
                              fontSize: 18, color: Colors.blue
                          ),),
                        onTap: () {
                          switch(titre){
                            case "Secrétaire":
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (builder) {
                                    return Projet();
                                  })
                              );
                              break;
                            case "Directeur":
                              gotToModifyProjetD(valuen,titre);
                              break;
                            case "Chef projet":
                              gotToListProjetC(valuen,titre);
                              break;
                            default:
                              showDialog(context: context,
                                builder: (_) => ShowErrorDialog(),
                                barrierDismissible: false,);

                          }
                        }

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                      tileColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      leading: Icon(Icons.settings_applications_outlined,
                        color: Colors.blue,),
                      title: Text("Paramètres",
                        style: TextStyle(
                            fontSize: 18, color: Colors.blue
                        ),),
                      onTap: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                      tileColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      leading: Icon(
                        Icons.help_outline_outlined, color: Colors.blue,),
                      title: Text("Besoin d'aide ?",
                        style: TextStyle(
                            fontSize: 18, color: Colors.blue
                        ),),
                      onTap: () {},

                    ),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  SizedBox(height: 5,),
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 18),
                    width: 300,
                    height: 45,
                    color: Colors.black54,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.workspaces_outline, color: Colors.white,),
                        SizedBox(width: 5,),
                        Text("Espaces Administrateur",
                          style: TextStyle(
                              color: Colors.white, fontSize: 20
                          ),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                      tileColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      leading: Icon(
                        Icons.library_add_outlined, color: Colors.blue,),
                      title: Text("Liste des employés",
                        style: TextStyle(
                            fontSize: 18, color: Colors.blue
                        ),),
                      onTap: () {
                        if(titre == "Admin" || titre == "admin"){
                          gotToListEMP(valuen,titre);
                        }else{
                          showDialog(context: context,
                            builder: (_) => ShowErrorDialog(),
                            barrierDismissible: false,);
                        }
                      },

                    ),
                  ),


                  Divider(
                    color: Colors.white,
                  ),
                  SizedBox(height: 5,),
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 18),
                    width: 300,
                    height: 45,
                    color: Colors.black54,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.workspaces_outline, color: Colors.white,),
                        SizedBox(width: 5,),
                        Text("Espaces Comptable",
                          style: TextStyle(
                              color: Colors.white, fontSize: 20
                          ),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                      tileColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      leading: Icon(
                        Icons.edit_attributes_outlined, color: Colors.blue,),
                      title: Text("Modifier et facturer",
                        style: TextStyle(
                            fontSize: 18, color: Colors.blue
                        ),),
                      onTap: () {
                        switch(titre){
                          case "Comptable":
                            print("comptable");
                            break;
                          default:
                            showDialog(context: context,
                              builder: (_) => ShowErrorDialog(),
                              barrierDismissible: false,);
                        }

                      },

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                      tileColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      leading: Icon(
                        Icons.search_rounded, color: Colors.blue,),
                      title: Text("Recherche",
                        style: TextStyle(
                            fontSize: 18, color: Colors.blue
                        ),),
                      onTap: () {
                        switch(titre){
                          case "Comptable":
                            print("comptable");
                            break;
                          default:
                            showDialog(context: context,
                              builder: (_) => ShowErrorDialog(),
                              barrierDismissible: false,);

                        }

                      },

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                      tileColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      leading: Icon(
                        Icons.library_add_outlined, color: Colors.blue,),
                      title: Text("Deconnexion",
                        style: TextStyle(
                            fontSize: 18, color: Colors.blue
                        ),),
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (builder){
                            return LoginScreen();
                          })),

                    ),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              test(),
              test(),

            ],
          ),
        )
    );
  }
}




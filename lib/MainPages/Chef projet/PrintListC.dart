import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';




class PrintProjetinfoC extends StatefulWidget {
  var projet;
  PrintProjetinfoC(this.projet);

  @override
  _PrintProjetinfoCState createState() => _PrintProjetinfoCState();
}

class _PrintProjetinfoCState extends State<PrintProjetinfoC> {

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


  List ProjetList = [];
  bool isLoading = true;

  PrintProjet() async {
    var url = Uri.parse("http://192.168.1.16/workstation/flutter%20app%20auth/getprojetc.php");
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

  // void gotToModifyProjetD (var a){
  //   Navigator.push(context, MaterialPageRoute(builder: (builder){
  //     return ModifyProjetD(a);
  //   }));
  // }
  bool ifchef = false;
  Future<void> Get(var chef)async {
      var url = Uri.parse("http://192.168.1.16/workstation/flutter%20app%20auth/ifchef.php");
      var response = await http.post(url,
          body: {
            //"idp" : idpController.text,
            "chef" : chef,
          }
      );
      var data = jsonDecode(response.body);
      if(data){
        ifchef = true;
        print("decomposer ce projet");

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
                              Text("Ajouter une phase",style: TextStyle(color: Colors.white,
                                  fontSize: 20),),
                            ],
                          ),
                          onPressed: ()=> Get(widget.projet['chef']), //gotToModifyProjetD(widget.projet["id"]),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                        // FlatButton(
                        //   color: Colors.lightBlue,
                        //   padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
                        //   child: Column(
                        //     children: [
                        //       Icon(Icons.add,size: 35,color: Colors.white,),
                        //       Text("Chef de projet",style: TextStyle(color: Colors.white,
                        //           fontSize: 20),),
                        //     ],
                        //   ),
                        //   onPressed: () => gotToAddChefProjet(widget.projet['idp']),
                        //   shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(20)
                        //   ),
                        // ),

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
                            title: Text("CHEF PROJET : "+widget.projet["chef"]),
                            subtitle: Text('Chef du projet'),
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
                    SizedBox(height: 10,),
                    Card(
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.monetization_on_outlined,),
                            title: Text("MONTANT : "+widget.projet["montant"]),
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
                            leading: Icon(Icons.file_copy,),
                            title: Text("DOCUMENTS : "+widget.projet["document"]),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
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
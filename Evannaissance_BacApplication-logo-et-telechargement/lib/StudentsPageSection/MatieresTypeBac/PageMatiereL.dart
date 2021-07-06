import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../BottomNaBar.dart';
import '../ChoiceTypeBac.dart';


class PageMatiereL extends StatefulWidget {


  @override
  _PageMatiereLState createState() => _PageMatiereLState();
}

class _PageMatiereLState extends State<PageMatiereL> {

  void goToBottomNavBar() {
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
          return BottomNavBar();
        }
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text("Matières Bac L",
          style: TextStyle(fontSize: 20,
              color: Colors.black),),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Builder(
          builder:(BuildContext context){
            return IconButton(onPressed: ()=> goToBottomNavBar(),
                icon:  Icon(EvaIcons.arrowBack,
                  size: 35,
                  color: Colors.lightBlue,)
            );},
        ),
      ),
      body: ListViewWidget(),

    );
  }
}




class ListViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListeTileWidget(),
      ],

    );
  }
}

class ListeTileWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30,),
        ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(""),
          ),
          title: Text("FRANCAIS",style:
          TextStyle(fontSize: 20,),),
          subtitle: Text("Matière dominante en l1a,l1b,l1',l2,lA",style: TextStyle(color: Colors.blue),),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () => print("yooo"),
        ),
        SizedBox(height: 10,),
        ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(""),
          ),
          title: Text("PHILOSOPHIE",style:
          TextStyle(fontSize: 20,),),
          subtitle: Text("Matière dominante en l1a,l1b,l1',l2,lA",style: TextStyle(color: Colors.blue),),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () => print("yooo"),
        ),
        SizedBox(height: 10,),
        ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(""),
          ),
          title: Text("HISTOIRE GEOGRAPHIE",style:
          TextStyle(fontSize: 20,),),
          subtitle: Text("Matière dominante en l2,lA",style: TextStyle(color: Colors.blue),),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () => print("yooo"),
        ),
        SizedBox(height: 10,),
        ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(""),
          ),
          title: Text("LANGUE VIVANTE 1",style:
          TextStyle(fontSize: 20,),),
          subtitle: Text("Matière dominante en l1',l2",style: TextStyle(color: Colors.blue),),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () => print("yooo"),
        ),
        SizedBox(height: 10,),
        ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(""),
          ),
          title: Text("MATHEMATIQUES",style:
          TextStyle(fontSize: 20,),),
          subtitle: Text("Matière non dominante ",style: TextStyle(color: Colors.blue),),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () => print("yooo"),
        ),
        SizedBox(height: 10,),
        ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(""),
          ),
          title: Text("GREC",style:
          TextStyle(fontSize: 20,),),
          subtitle: Text("Matière dominante en s1",style: TextStyle(color: Colors.blue),),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () => print("yooo"),
        ),
        SizedBox(height: 10,),
        ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(""),
          ),
          title: Text("LATIN OU ARABE",style:
          TextStyle(fontSize: 20,),),
          subtitle: Text("Matière dominante en l1a,l1b",style: TextStyle(color: Colors.blue),),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () => print("yooo"),
        ),
        SizedBox(height: 10,),
        ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(""),
          ),
          title: Text("LANGUE VIVANTE 2",style:
          TextStyle(fontSize: 20,),),
          subtitle: Text("Matière dominante en l1'",style: TextStyle(color: Colors.blue),),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () => print("yooo"),
        ),
        SizedBox(height: 10,),
        ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(""),
          ),
          title: Text("ECONOMIE",style:
          TextStyle(fontSize: 20,),),
          subtitle: Text("Matière dominante en s3",style: TextStyle(color: Colors.blue),),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () => print("yooo"),
        ),
        SizedBox(height: 10,),
        ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(""),
          ),
          title: Text("SVT OU PHYSIQUE",style:
          TextStyle(fontSize: 20,),),
          subtitle: Text("Non dominante",style: TextStyle(color: Colors.blue),),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () => print("yooo"),
        ),
        SizedBox(height: 10,),
        ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(""),
          ),
          title: Text("LANGUE ET LITTERATURE ARABE",style:
          TextStyle(fontSize: 20,),),
          subtitle: Text("Matière dominante en lA",style: TextStyle(color: Colors.blue),),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () => print("yooo"),
        ),
        SizedBox(height: 10,),
        ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(""),
          ),
          title: Text("ANGLAIS(lv2)",style:
          TextStyle(fontSize: 20,),),
          subtitle: Text("Non dominante",style: TextStyle(color: Colors.blue),),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () => print("yooo"),
        ),
        SizedBox(height: 10,),
        ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(""),
          ),
          title: Text("CIVILISATION ARABO ISLAMIQUE",style:
          TextStyle(fontSize: 20,),),
          subtitle: Text("Non dominante",style: TextStyle(color: Colors.blue),),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () => print("yooo"),
        ),

      ],
    );
  }
}

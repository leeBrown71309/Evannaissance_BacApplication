



import 'package:e_bac/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'Personal_Informations.dart';


class ProfileEditor extends StatefulWidget {
  const ProfileEditor({Key? key}) : super(key: key);

  @override
  _ProfileEditorState createState() => _ProfileEditorState();
}

class _ProfileEditorState extends State<ProfileEditor> {



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
                        'Ajoute une photo',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 50.0),
                      AddProfilImage(),
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

class AddProfilImage extends StatefulWidget {
  const AddProfilImage({Key? key}) : super(key: key);

  @override
  _AddProfilImageState createState() => _AddProfilImageState();
}

class _AddProfilImageState extends State<AddProfilImage> {
/*
   late File _image;
  final _picker = ImagePicker();

  Future getImage(ImageSource source) async {
    PickedFile? pickedFile = await _picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image =  File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }


*/

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
          return PersonalInformations();
        }
    ));
  }

  Widget buttomSheet(){
    //quand on clic sur l'icone de la camera ca ouvre une buttonsheet
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text('Take a picture from...',
          style: TextStyle(fontSize: 20,
          color: Colors.indigoAccent),
          ),
          SizedBox(height: 20,),
          Row(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(onPressed:
              () =>print('yy'),
                  icon: Icon(Icons.add_a_photo,
                    color: Colors.indigoAccent,),
                  label: Text('Camera',
                  style: TextStyle(fontSize: 15,
                    color: Colors.indigoAccent,),)
              ),
              FlatButton.icon(onPressed:
                  () => print('yy'),
                  icon: Icon(Icons.image_outlined, color: Colors.indigoAccent,),
                  label: Text('Photos',
                    style: TextStyle(fontSize: 15,
                    color: Colors.indigoAccent,),)
              )
            ],
          )
        ],
      ),
    );
  }

  Widget getProfilImage() {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: <Widget>[
        CircleAvatar(
          radius: 10,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 105,
            backgroundImage: AssetImage('assets/avatar.jpg'),
          ),
        ),

        Positioned(
          right: 10,
          bottom: 10
          ,
          child:SizedBox(height:60,width: 60,
            child: FlatButton(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: BorderSide(color: Colors.white),
              ),
              color: Color(0xFFF5F6F9),
              onPressed: () {
                showModalBottomSheet(context: context,
                  builder: ((builder) => buttomSheet()),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  isScrollControlled: false,

                )

                ;},
              child: Icon(Icons.camera_alt_outlined,size: 40,
                color: Colors.indigo,),
            ),
          ),

        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 220,width: 220,
        child: getProfilImage()
       ),
        SizedBox(height: 50,),
        Text("Cette image sera visible\n      par tous le monde",
        style: GeneralTextStyle,),
        SizedBox(height: 20,),
        RaisedButton(onPressed: () => goToNextPage(),

          padding: EdgeInsets.only(left: 80,right: 80,top: 30,bottom: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          color: Colors.white,
          child: Text('Continuer',
            style: WhiteButtonText,
          ),
        ),

      ],
    );
  }
}

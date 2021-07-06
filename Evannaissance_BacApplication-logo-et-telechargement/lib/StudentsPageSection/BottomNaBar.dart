import 'package:e_bac/StudentsPageSection/PagesNavBottomBar/downloadpage.dart';
import 'package:e_bac/TuteurPagesSection/FirtsEditingProfile/Bienvenue.dart';
import 'package:e_bac/TuteurPagesSection/FirtsEditingProfile/EditeProfileImage.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Accueil.dart';
import 'PagesNavBottomBar/FoundTuteurs.dart';
import 'PagesNavBottomBar/pageCours.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 1;

  final List<Widget> _Pages = <Widget>[
    PageCours(),
    Accueil(),
    FoundTuteur(),
    Downloads(),
  ];

  //Pour la bottom nav Bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Pages[_selectedIndex],
      //BottomNavBar
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(0),
        child: Material(
          child: Container(
            height: 70,
            width: double.infinity,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 20,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.black,
              backgroundColor: Colors.lightBlue,
              onTap: _onItemTapped,
              currentIndex: _selectedIndex,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    EvaIcons.bookOpenOutline,
                  ),
                  label: 'Cours',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    EvaIcons.homeOutline,
                  ),
                  label: 'Accueil',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_search_outlined,
                  ),
                  label: 'Tuteurs',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.download_sharp,
                  ),
                  label: 'Téléchargées',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

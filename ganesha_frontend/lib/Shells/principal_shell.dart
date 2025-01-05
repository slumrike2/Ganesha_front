import 'package:flutter/material.dart';
import 'package:ganesha_frontend/Pages/PrincipalPages/friends_page.dart';
import 'package:ganesha_frontend/Pages/PrincipalPages/home_page.dart';
import 'package:ganesha_frontend/Pages/PrincipalPages/music_page.dart';
import 'package:ganesha_frontend/Pages/PrincipalPages/stadistics_page.dart';
import 'package:ganesha_frontend/Pages/PrincipalPages/symptoms_page.dart';

class Principalshell extends StatefulWidget {
  static final String routeName = '/principal';
  const Principalshell({super.key});

  @override
  State<Principalshell> createState() => _PrincipalshellState();
}

class _PrincipalshellState extends State<Principalshell> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    HomePage(),
    FriendsPage(),
    MusicPage(),
    StadisticsPage(),
    SymptomsPage()
  ];

  @override
  Widget build(BuildContext context) {
    final sizeh = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/fondo.jpg', // Replace with your image path
            fit: BoxFit.cover,
            color: Colors.black.withAlpha(100), // Corrected method
            colorBlendMode: BlendMode.darken,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withAlpha(110),
            showUnselectedLabels: false,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            currentIndex: _selectedIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Inicio',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Amigos',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.music_note),
                label: 'Musica',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: 'Estadisticas',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.health_and_safety),
                label: 'Sintomas',
              ),
            ],
          ),
          appBar: AppBar(
            title: Container(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hola, Juan',
                      style: TextStyle(fontSize: 32, color: Colors.white)),
                  Row(
                    spacing: 8,
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.yellow,
                        size: 10,
                      ),
                      Text(
                        '500',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: sizeh * 0.1,
            actions: [
              IconButton(
                iconSize: 46,
                padding: EdgeInsets.only(right: 16),
                onPressed: () {},
                icon: Icon(Icons.person_outline),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

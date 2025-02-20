import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ganesha_frontend/Pages/PrincipalPages/friends_page.dart';
import 'package:ganesha_frontend/Pages/PrincipalPages/home_page.dart';
import 'package:ganesha_frontend/Pages/PrincipalPages/music_page.dart';
import 'package:ganesha_frontend/Pages/PrincipalPages/settings_page.dart';
import 'package:ganesha_frontend/Pages/PrincipalPages/stadistics_page.dart';
import 'package:ganesha_frontend/Pages/PrincipalPages/test_page.dart';
import 'package:ganesha_frontend/dartTypes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Principalshell extends StatefulWidget {
  static final String routeName = '/principal';
  final GaneshaUser userData;

  const Principalshell({super.key, required this.userData});

  @override
  State<Principalshell> createState() => _PrincipalshellState();
}

class _PrincipalshellState extends State<Principalshell> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;
  late GaneshaUser _userData;
  String backgroundImage = 'assets/fondo.jpg'; // Default background image

  Future<void> _refetchUserData() async {
    final userData = await fetchUserData();
    setState(() {
      _userData = userData;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadBackgroundImage();
    _userData = widget.userData;
    _pages = [
      HomePage(
        userData: _userData,
        refetchUserData: _refetchUserData,
      ),
      FriendsPage(),
      MusicPage(refetchUserData: _refetchUserData),
      StadisticsPage(),
    ];
  }

  Future<void> _loadBackgroundImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("fondo: " + (prefs.getString('fondo') ?? 'null'));
    setState(() {
      backgroundImage = prefs.getString('fondo') ?? 'assets/fondo.jpg';
    });
  }

  Future<GaneshaUser> fetchUserData() async {
    SupabaseClient supabase = Supabase.instance.client;

    final response = await http.get(
      Uri.parse(
          '${dotenv.env['API_URL']}/user/${supabase.auth.currentUser!.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['API_KEY']}',
      },
    );

    if (response.statusCode == 200) {
      return GaneshaUser.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeh = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            backgroundImage, // Use the preferred background image
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
            onTap: (index) async {
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
                label: 'Música',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: 'Estadísticas',
              ),
            ],
          ),
          appBar: AppBar(
            title: Container(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Hola, ${_userData.nombre}',
                          style: TextStyle(fontSize: 32, color: Colors.white)),
                      IconButton(
                        iconSize: 46,
                        color: Colors.white,
                        padding: EdgeInsets.only(right: 16),
                        onPressed: () async {
                          final result = await Navigator.pushNamed(
                              context, SettingsPage.routeName);
                          if (result == true) {
                            _loadBackgroundImage(); // Reload background image
                          }
                        },
                        icon: Icon(Icons.person_outline),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 8,
                    children: [
                      Icon(
                        Icons.monetization_on,
                        color: Colors.yellow,
                        size: 25,
                      ),
                      Text(
                        '${_userData.puntaje}',
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
            toolbarHeight: sizeh * 0.2,
          ),
        ),
      ],
    );
  }
}

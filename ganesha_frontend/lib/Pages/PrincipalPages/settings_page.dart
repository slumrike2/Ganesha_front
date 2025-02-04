import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:ganesha_frontend/Pages/login_page.dart';
import 'package:ganesha_frontend/Shells/register_shell.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  static final String routeName = '/settings';

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String backgroundImage = 'assets/fondo.jpg'; // Default background image

  @override
  void initState() {
    super.initState();
    _loadBackgroundImage();
  }

  Future<void> _loadBackgroundImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      backgroundImage = prefs.getString('fondo') ?? 'assets/fondo.jpg';
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeh = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    backgroundImage), // Use the preferred background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                toolbarHeight: sizeh * 0.1,
                iconTheme: IconThemeData(color: Colors.white),
              ),
              // ...other widgets...
              Expanded(
                child: Column(
                  spacing: 32,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Cambiar tema',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      height: sizeh * 0.4,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildItemContainer(
                              'Fondo Clasico', 'assets/fondo.jpg', context),
                          SizedBox(width: 10),
                          _buildItemContainer(
                              'Pintura ', 'assets/Blue1.jpg', context),
                          SizedBox(width: 10),
                          _buildItemContainer(
                              'Bosques', 'assets/Blue2.jpg', context),
                          SizedBox(width: 10),
                          _buildItemContainer(
                              'Ciudad', 'assets/Blue3.jpg', context),
                          // Add more items as needed
                        ],
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          await Supabase.instance.client.auth.signOut();
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text('Cerrar Sesión'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemContainer(
      String name, String imagePath, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: Center(child: Image.asset(imagePath)),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('fondo', imagePath);
              setState(() {
                backgroundImage = imagePath;
              });
              Navigator.pop(context, true); // Notify principal shell
            },
            child: Text(
              'Select',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ganesha_frontend/Shells/RegisterShell.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Rutas necesarias para el funcionamiento de la navegacion en la app
      routes: {RegisterShell.routeName: (context) => RegisterShell()},
      initialRoute: RegisterShell.routeName,
    );
  }
}


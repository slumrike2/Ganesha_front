import 'package:flutter/material.dart';
import 'package:ganesha_frontend/Pages/login_page.dart';
import 'package:ganesha_frontend/Shells/principal_shell.dart';
import 'package:ganesha_frontend/Shells/register_shell.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  final supabaseUrl = dotenv.get('SUPABASE_URL');
  final supabaseAnonKey = dotenv.get('SUPABASE_ANON_KEY');

  try {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  } catch (e) {
    print(e);
  }

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      // Rutas necesarias para el funcionamiento de la navegacion en la app
      routes: {
        RegisterShell.routeName: (context) => RegisterShell(),
        LoginPage.routeName: (context) => LoginPage(),
        Principalshell.routeName: (context) => Principalshell(),
      },
      initialRoute: RegisterShell.routeName,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ganesha_frontend/Pages/PrincipalPages/test_page.dart';
import 'package:ganesha_frontend/Pages/login_page.dart';
import 'package:ganesha_frontend/Shells/principal_shell.dart';
import 'package:ganesha_frontend/Shells/register_shell.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ganesha_frontend/dartTypes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ganesha_frontend/Pages/PrincipalPages/exercise_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        Principalshell.routeName: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as GaneshaUser;
          return Principalshell(userData: args);
        },
        TestPage.routeName: (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          if (args is List<Sintoma>) {
            return TestPage(symptoms: args);
          } else {
            throw Exception('Invalid arguments for TestPage');
          }
        },
        ExerciseListPage.routeName: (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          if (args is List<Ejercicio>) {
            return ExerciseListPage(exercises: args);
          } else {
            throw Exception('Invalid arguments for ExerciseListPage');
          }
        },
      },
      initialRoute: RegisterShell.routeName,
    );
  }
}

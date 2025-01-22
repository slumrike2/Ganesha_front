import 'package:flutter/material.dart';
import 'package:ganesha_frontend/Components/exercise_preview.dart';
import 'package:ganesha_frontend/Pages/PrincipalPages/test_page.dart';
import 'package:ganesha_frontend/Pages/PrincipalPages/exercise_list_page.dart';
import 'package:ganesha_frontend/dartTypes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  final GaneshaUser userData;

  const HomePage({super.key, required this.userData});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<Sintoma>? _cachedSymptoms;
  static List<Ejercicio>? _cachedExercises;

  Future<List<dynamic>> fetchData() async {
    final symptomsFuture = fetchSymptoms();
    final exercisesFuture = fetchExercises();
    return Future.wait([symptomsFuture, exercisesFuture]);
  }

  Future<List<Sintoma>> fetchSymptoms() async {
    if (_cachedSymptoms != null) {
      return _cachedSymptoms!;
    }

    final response = await http.get(
      Uri.parse('${dotenv.env['API_URL']}/symptoms'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['API_KEY']}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      _cachedSymptoms = data.map((json) => Sintoma.fromJson(json)).toList();
      return _cachedSymptoms!;
    } else {
      throw Exception('Failed to load symptoms');
    }
  }

  Future<List<Ejercicio>> fetchExercises() async {
    if (_cachedExercises != null) {
      return _cachedExercises!;
    }

    SupabaseClient supabase = Supabase.instance.client;

    final response = await http.get(
      Uri.parse(
          '${dotenv.env['API_URL']}/tests/getUserExercises/${supabase.auth.currentUser!.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['API_KEY']}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      _cachedExercises = body.map((dynamic item) => Ejercicio.fromJson(item)).toList();
      _cachedExercises!.sort((a, b) => b.prioridad.compareTo(a.prioridad)); // Sort by priority
      return _cachedExercises!;
    } else {
      throw Exception('Failed to load exercises');
    }
  }

  void _refreshData() {
    setState(() {
      _cachedSymptoms = null;
      _cachedExercises = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizew = MediaQuery.of(context).size.width;
    final sizeh = MediaQuery.of(context).size.height;
    final userName = widget.userData.nombre;
    final userPoints = widget.userData.puntaje;

    return FutureBuilder<List<dynamic>>(
      future: fetchData(),
      builder: (context, snapshot) {
        final symptoms = snapshot.data?[0] as List<Sintoma>? ?? [];
        final exercises = snapshot.data?[1] as List<Ejercicio>? ?? [];

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: Text(
                  'Welcome, $userName',
                  style: TextStyle(fontSize: 32, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  'Points: $userPoints',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InfoBox(
                      title: 'Racha',
                      value: '5 días',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: InfoBox(
                      title: 'Logros',
                      value: '20',
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                child: Text(
                  'Test Diario',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: snapshot.connectionState == ConnectionState.done
                    ? () async {
                        await Navigator.pushNamed(
                          context,
                          TestPage.routeName,
                          arguments: symptoms,
                        );
                        _refreshData();
                      }
                    : null,
                child: Text('Comenzar Test'),
              ),
              Container(
                  width: double.infinity,
                  child: Text(
                    'Ejercicios',
                    style: TextStyle(fontSize: 32, color: Colors.white),
                    textAlign: TextAlign.center,
                  )),
              ElevatedButton(
                onPressed: snapshot.connectionState == ConnectionState.done
                    ? () async {
                        await Navigator.pushNamed(
                          context,
                          ExerciseListPage.routeName,
                          arguments: exercises,
                        );
                        _refreshData();
                      }
                    : null,
                child: Text('Ver Ejercicios'),
              ),
              InfoBox(
                title: 'Ejercicios Pendientes',
                value: '10', // Replace with actual data
              ),
            ],
          ),
        );
      },
    );
  }
}

class InfoBox extends StatelessWidget {
  final String title;
  final String value;

  const InfoBox({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.4;
    final height = MediaQuery.of(context).size.height * 0.2;

    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blueGrey[900],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8),
          Expanded(
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

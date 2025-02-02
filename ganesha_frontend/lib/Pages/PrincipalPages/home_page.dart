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
  final Function refetchUserData;

  const HomePage(
      {super.key, required this.userData, required this.refetchUserData});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  static List<Sintoma>? _cachedSymptoms;
  static List<Ejercicio>? _cachedExercises;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshData();
    }
  }

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
      _cachedExercises =
          body.map((dynamic item) => Ejercicio.fromJson(item)).toList();
      _cachedExercises!.sort(
          (a, b) => b.prioridad.compareTo(a.prioridad)); // Sort by priority
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InfoBox(
                      title: 'Racha',
                      value: '5 días',
                      size: InfoBoxSize.medium,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: InfoBox(
                      title: 'Logros',
                      value: '20',
                      size: InfoBoxSize.medium,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  '¿Cómo te sientes hoy?',
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
                          arguments: [symptoms, widget.refetchUserData],
                        );
                        widget.refetchUserData();
                        _refreshData();
                      }
                    : null,
                child: Text('Comenzar Test'),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Ejercicios',
                    style: TextStyle(fontSize: 24, color: Colors.white),
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
                        widget.refetchUserData();
                        _refreshData();
                      }
                    : null,
                child: Text('Ver Ejercicios'),
              ),
              InfoBox(
                title: 'Ejercicios Pendientes',
                value: '${exercises.length}', // Replace with actual data
                size: InfoBoxSize.large,
              ),
            ],
          ),
        );
      },
    );
  }
}

enum InfoBoxSize { small, medium, large }

class InfoBox extends StatelessWidget {
  final String title;
  final String value;
  final InfoBoxSize size;

  const InfoBox({
    Key? key,
    required this.title,
    required this.value,
    this.size = InfoBoxSize.medium,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width;
    switch (size) {
      case InfoBoxSize.small:
        width = MediaQuery.of(context).size.width * 0.3;
        break;
      case InfoBoxSize.large:
        width = MediaQuery.of(context).size.width * 0.8;
        break;
      case InfoBoxSize.medium:
        width = MediaQuery.of(context).size.width * 0.4;
        break;
    }
    final height = MediaQuery.of(context).size.height * 0.15;

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

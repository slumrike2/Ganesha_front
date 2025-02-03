import 'package:flutter/material.dart';
import 'package:ganesha_frontend/dartTypes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExerciseListPage extends StatefulWidget {
  static final String routeName = '/exercises';
  final List<Ejercicio> exercises;

  const ExerciseListPage({super.key, required this.exercises});

  @override
  _ExerciseListPageState createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  late List<Ejercicio> _exercises;
  String backgroundImage = 'assets/fondo.jpg'; // Default background image

  @override
  void initState() {
    super.initState();
    _loadBackgroundImage();
    _exercises = widget.exercises;
    _exercises.sort((a, b) => a.prioridad.compareTo(b.prioridad));
  }

  Future<void> _loadBackgroundImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      backgroundImage = prefs.getString('fondo') ?? 'assets/fondo.jpg';
    });
  }

  Future<void> markExerciseAsDone(int exerciseId) async {
    SupabaseClient supabase = Supabase.instance.client;

    final response = await http.post(
      Uri.parse('${dotenv.env['API_URL']}/tests/mark_done'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['API_KEY']}',
      },
      body: jsonEncode({
        'id_usuario': supabase.auth.currentUser!.id,
        'id_ejercicio': exerciseId
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        _exercises
            .removeWhere((exercise) => exercise.idEjercicio == exerciseId);
      });
    } else {
      throw Exception('Failed to mark exercise as done');
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
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: sizeh * 0.1,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          body: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Column(
              children: [
                Text(
                  'Lista de Ejercicios',
                  style: TextStyle(fontSize: 32, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Expanded(
                  child: _exercises.isEmpty
                      ? Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'No hay más ejercicios, \n¡continúa así!',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: _exercises.length,
                          itemBuilder: (context, index) {
                            final exercise = _exercises[index];
                            return ExerciseItem(
                              exercise: exercise,
                              onDone: () async {
                                await markExerciseAsDone(exercise.idEjercicio);
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ExerciseItem extends StatelessWidget {
  final Ejercicio exercise;
  final VoidCallback onDone;

  const ExerciseItem({
    super.key,
    required this.exercise,
    required this.onDone,
  });

  void _showExplanation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                color: Colors.blueGrey[600],
                // Replace with your image widget
              ),
              SizedBox(height: 16),
              Text(
                exercise.descripcion,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                color: Colors.blueGrey[600],
                // Replace with your image widget
              ),
              SizedBox(height: 8),
              Container(
                height: constraints.maxHeight * 0.2,
                child: Center(
                  child: Text(
                    exercise.nombre,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _showExplanation(context),
                    icon: Icon(Icons.info_outline),
                    label: Text('Detalles', style: TextStyle(fontSize: 12)),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: onDone,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    icon: Icon(Icons.check_circle_outline),
                    label: Text(
                      'Hecho',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

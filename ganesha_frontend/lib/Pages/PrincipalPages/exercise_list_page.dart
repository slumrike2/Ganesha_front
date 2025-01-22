import 'package:flutter/material.dart';
import 'package:ganesha_frontend/dartTypes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExerciseListPage extends StatefulWidget {
  static final String routeName = '/exercises';
  const ExerciseListPage({super.key});

  @override
  State<ExerciseListPage> createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  @override
  Widget build(BuildContext context) {
    final sizeh = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/fondo.jpg', // Replace with your image path
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
                Expanded(
                  child: FutureBuilder<List<Ejercicio>>(
                    future: fetchExercises(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No exercises found'));
                      } else {
                        final exercises = snapshot.data!;
                        return ListView.builder(
                          itemCount: exercises.length,
                          itemBuilder: (context, index) {
                            final exercise = exercises[index];
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[50]?.withOpacity(0.8),
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          exercise.nombre,
                                          style: TextStyle(fontSize: 18, color: Colors.black),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await markExerciseAsDone(exercise.idEjercicio);
                                        },
                                        child: Text('Done'),
                                      ),
                                    ],
                                  ),
                                  Divider(color: Colors.grey),
                                  Text(
                                    exercise.descripcion,
                                    style: TextStyle(fontSize: 14, color: Colors.black),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
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

  Future<List<Ejercicio>> fetchExercises() async {
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
      List<Ejercicio> exercises = body.map((dynamic item) => Ejercicio.fromJson(item)).toList();
      exercises.sort((a, b) => b.prioridad.compareTo(a.prioridad)); // Sort by priority
      return exercises;
    } else {
      throw Exception('Failed to load exercises');
    }
  }

  Future<void> markExerciseAsDone(int exerciseId) async {
    final response = await http.post(
      Uri.parse('${dotenv.env['API_URL']}/exercises/mark_done'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['API_KEY']}',
      },
      body: jsonEncode({'exercise_id': exerciseId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to mark exercise as done');
    } else {
      print('Exercise marked as done');
    }
  }
}

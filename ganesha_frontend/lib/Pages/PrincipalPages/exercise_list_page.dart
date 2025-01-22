import 'package:flutter/material.dart';
import 'package:ganesha_frontend/dartTypes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ExerciseListPage extends StatelessWidget {
  static final String routeName = '/exercises';
  const ExerciseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ejercicios'),
      ),
      body: FutureBuilder<List<Ejercicio>>(
        future: fetchExercises(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final exercises = snapshot.data!;
            return ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final exercise = exercises[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
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
                              style: TextStyle(fontSize: 18),
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
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Ejercicio>> fetchExercises() async {
    final response = await http.get(
      Uri.parse('${dotenv.env['API_URL']}/exercises'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['API_KEY']}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Ejercicio.fromJson(item)).toList();
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

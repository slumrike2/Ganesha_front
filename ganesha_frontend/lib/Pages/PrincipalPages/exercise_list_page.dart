import 'package:flutter/material.dart';
import 'package:ganesha_frontend/dartTypes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ExerciseListPage extends StatelessWidget {
  static final String routeName = '/exercises';
  final List<Ejercicio> exercises;

  const ExerciseListPage({super.key, required this.exercises});

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
                  child: ListView.builder(
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
                                    Navigator.pop(context, true);
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
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

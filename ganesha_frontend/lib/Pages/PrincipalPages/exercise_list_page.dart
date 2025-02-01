import 'package:flutter/material.dart';
import 'package:ganesha_frontend/dartTypes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExerciseListPage extends StatefulWidget {
  static final String routeName = '/exercises';
  final List<Ejercicio> exercises;

  const ExerciseListPage({super.key, required this.exercises});

  @override
  _ExerciseListPageState createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  late List<Ejercicio> _exercises;

  @override
  void initState() {
    super.initState();
    _exercises = widget.exercises;
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
                  child: _exercises.isEmpty
                      ? Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'No hay más ejercicios, \n¡continúa así!',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : ListView.builder(
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
                onPressed: onDone,
                child: Text('Hecho'),
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
  }
}

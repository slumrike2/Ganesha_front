import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ganesha_frontend/Components/symptom_test.dart';
import 'package:ganesha_frontend/dartTypes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';

class TestPage extends StatefulWidget {
  static final String routeName = '/test';
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final List<SymptomTest> _symptomTests = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeh = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/fondo.jpg', // Set the path to your background image
            fit: BoxFit.cover,
            color: Colors.black.withAlpha(100), // Corrected method
            colorBlendMode: BlendMode.darken,
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
                  'Test de Sintomas',
                  style: TextStyle(fontSize: 32, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                FutureBuilder<List<Sintoma>>(
                  future: getSymptom(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: SingleChildScrollView(
                            child: Column(
                              children: snapshot.data!
                                  .map((sintoma) {
                                    final symptomTest = SymptomTest(data: sintoma);
                                    _symptomTests.add(symptomTest);
                                    return Container(
                                      margin: EdgeInsets.symmetric(vertical: 8.0),
                                      child: symptomTest,
                                    );
                                  })
                                  .toList(),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      final checkedSymptoms = _symptomTests
                          .where((symptomTest) => symptomTest.isChecked())
                          .map((symptomTest) => symptomTest.data)
                          .toList();

                      for (var symptom in checkedSymptoms) {
                        print(symptom.idSintoma);
                      }

                      submitCheckedSymptoms(checkedSymptoms);
                      Navigator.pop(context);
                      // Do something with checkedSymptoms
                    },
                    child: Text('Submit'))
              ],
            ),
          ),
        ),
      ],
    );
  }

  // HTTP Requests for Symptoms
  Future<List<Sintoma>> getSymptom() async {
    final responseSymptom =
        await http.get(Uri.parse('${dotenv.env['API_URL']}/symptoms/'), headers: {
      'Content-Type': 'application/json',
      'Authorization': '${dotenv.env['API_KEY']}',
    });

    if (responseSymptom.statusCode == 200) {
      List<Sintoma> symptoms = [];
      for (var symptom in jsonDecode(responseSymptom.body)) {
        symptoms.add(Sintoma.fromJson(symptom));
      }
      return symptoms;
    } else {
      throw Exception('Failed to load symptoms');
    }
  }

  // HTTP Requests for User Symptoms
  Future<void> submitCheckedSymptoms(List<Sintoma> checkedSymptoms) async {
    SupabaseClient supabase = Supabase.instance.client;

    final responseCheckedSymptoms =
        await http.post(Uri.parse('${dotenv.env['API_URL']}/tests/submit'), headers: {
      'Content-Type': 'application/json',
      'Authorization': '${dotenv.env['API_KEY']}',
    }, body: jsonEncode({
      'test': checkedSymptoms.map((symptom) => symptom.toJson()).toList(),
      'user_uid': supabase.auth.currentSession?.user.id,
    }));

    if (responseCheckedSymptoms.statusCode != 200) {
      throw Exception('Failed to submit symptoms');
    } else {
      print('Symptoms submitted');
    }
  }
}

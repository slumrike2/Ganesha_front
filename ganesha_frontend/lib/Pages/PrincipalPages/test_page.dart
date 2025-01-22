import 'package:flutter/material.dart';
import 'package:ganesha_frontend/Components/symptom_test.dart';
import 'package:ganesha_frontend/dartTypes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';

class TestPage extends StatefulWidget {
  static final String routeName = '/test';
  final List<Sintoma> symptoms;

  const TestPage({super.key, required this.symptoms});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final List<SymptomTest> _symptomTests = [];
  String _selectedType = 'Todos';
  final List<String> _types = ['Todos'];

  @override
  void initState() {
    super.initState();
    for (var sintoma in widget.symptoms) {
      _symptomTests.add(SymptomTest(data: sintoma));
      if (!_types.contains(sintoma.tipo)) {
        _types.add(sintoma.tipo);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<SymptomTest> _filterSymptoms() {
    if (_selectedType == 'Todos') {
      return _symptomTests;
    } else {
      return _symptomTests
          .where((symptomTest) => symptomTest.data.tipo == _selectedType)
          .toList();
    }
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
                SizedBox(height: 16),
                Container(
                  width: 200,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[800],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedType,
                      dropdownColor: Colors.blueGrey[800],
                      style: TextStyle(color: Colors.white),
                      items: _types.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedType = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        children: _filterSymptoms().map((symptomTest) {
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
                                        symptomTest.data.pregunta,
                                        style: TextStyle(fontSize: 18, color: Colors.black),
                                      ),
                                    ),
                                    StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setState) {
                                        return Checkbox(
                                          value: symptomTest.isChecked(),
                                          onChanged: (bool? value) {
                                            setState(() {
                                              symptomTest.setChecked(value!);
                                            });
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                Divider(color: Colors.grey),
                                Text(
                                  symptomTest.data.descripcion,
                                  style: TextStyle(fontSize: 14, color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      final checkedSymptoms = _symptomTests
                          .where((symptomTest) => symptomTest.isChecked())
                          .map((symptomTest) => symptomTest.data)
                          .toList();

                      await submitCheckedSymptoms(checkedSymptoms);
                      Navigator.pop(context, true);
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

  // HTTP Requests for User Symptoms
  Future<void> submitCheckedSymptoms(List<Sintoma> checkedSymptoms) async {
    SupabaseClient supabase = Supabase.instance.client;

    final responseCheckedSymptoms =
        await http.post(Uri.parse('${dotenv.env['API_URL']}/tests/submit'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': '${dotenv.env['API_KEY']}',
            },
            body: jsonEncode({
              'test':
                  checkedSymptoms.map((symptom) => symptom.toJson()).toList(),
              'user_uid': supabase.auth.currentSession?.user.id,
            }));

    if (responseCheckedSymptoms.statusCode != 200) {
      throw Exception('Failed to submit symptoms');
    } else {
      print('Symptoms submitted');
    }
  }
}

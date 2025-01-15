import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ganesha_frontend/Components/symptom_test.dart';
import 'package:ganesha_frontend/dartTypes.dart';

class TestPage extends StatefulWidget {
  static final String routeName = '/test';
  TestPage({super.key});

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
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(16),
                  child: SingleChildScrollView(
                      child: Column(
                    children: List.generate(15, (index) {
                      final symptomTest = SymptomTest(
                        data: Sintoma(
                          nombre: 'Sintoma $index',
                          descripcion: 'Descripcion del sintoma $index',
                          idSintoma: index,
                        ),
                      );
                      _symptomTests.add(symptomTest);
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: symptomTest,
                      );
                    }),
                  )),
                )),
                ElevatedButton(
                    onPressed: () {
                      final checkedSymptoms = _symptomTests
                          .where((symptomTest) => symptomTest.isChecked())
                          .map((symptomTest) => symptomTest.data)
                          .toList();

                      for (var symptom in checkedSymptoms) {
                        print(symptom.idSintoma);
                      }
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
}

import 'package:flutter/material.dart';
import 'package:ganesha_frontend/Components/symptom_test.dart';
import 'package:ganesha_frontend/dartTypes.dart';

class SymptomsPage extends StatefulWidget {
  SymptomsPage({super.key});

  @override
  State<SymptomsPage> createState() => _SymptomsPageState();
}

class _SymptomsPageState extends State<SymptomsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Sintomas',
            style: TextStyle(fontSize: 32, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    clipBehavior: Clip.antiAlias,
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return SymptomTest(
                        data: Sintoma(
                          nombre: 'Sintoma $index',
                          descripcion: 'Descripcion del sintoma $index',
                          idSintoma: index,
                        ),
                      );
                    },
                  ))),
          ElevatedButton(onPressed: () {}, child: Text('Submit'))
        ],
      ),
    );
  }
}

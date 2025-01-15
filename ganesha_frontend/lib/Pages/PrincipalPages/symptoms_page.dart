import 'package:flutter/material.dart';
import 'package:ganesha_frontend/Components/symptom_test.dart';
import 'package:ganesha_frontend/dartTypes.dart';

class SymptomsPage extends StatefulWidget {
  const SymptomsPage({super.key});

  @override
  State<SymptomsPage> createState() => _SymptomsPageState();
}

class _SymptomsPageState extends State<SymptomsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(),
              Expanded(
                child: Text(
                  'Sintomas',
                  style: TextStyle(fontSize: 32, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Flexible(
                child: Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.list, color: Colors.white),
                        onPressed: () {
                          // Handle list view action
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.grid_view, color: Colors.white),
                        onPressed: () {
                          // Handle grid view action
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              clipBehavior: Clip.antiAlias,
              itemCount: 15,
              itemBuilder: (context, index) {
                return SymptomTest(
                  extended: false,
                  data: Sintoma(
                    nombre: 'Sintoma $index',
                    descripcion: 'Descripcion del sintoma $index',
                    idSintoma: index,
                  ),
                );
              },
            ),
          ),
          ElevatedButton(onPressed: () {}, child: Text('Submit'))
        ],
      ),
    );
  }
}

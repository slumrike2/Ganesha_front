import 'package:flutter/material.dart';
import 'package:ganesha_frontend/Components/exercise_preview.dart';
import 'package:ganesha_frontend/Pages/PrincipalPages/test_page.dart';
import 'package:ganesha_frontend/Pages/PrincipalPages/exercise_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizew = MediaQuery.of(context).size.width;
    final sizeh = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: Text(
              'Progreso',
              style: TextStyle(fontSize: 32, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: sizew * 0.4,
                height: sizew * 0.4,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Racha',
                      style: TextStyle(fontSize: 24),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          '5 días',
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: sizew * 0.4,
                height: sizew * 0.4,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Logros',
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          '20',
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: Text(
              'Test Diario',
              style: TextStyle(fontSize: 24, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, TestPage.routeName);
                },
                child: Text('Comenzar Test')),
          ),
          Container(
              width: double.infinity,
              child: Text(
                'Ejercicios',
                style: TextStyle(fontSize: 32, color: Colors.white),
                textAlign: TextAlign.center,
              )),
          Container(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, ExerciseListPage.routeName);
                },
                child: Text('Ver Ejercicios')),
          ),
          Expanded(
            child: GridView.builder(
              clipBehavior: Clip.none,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: 4, // Show a preview of 4 exercises
              itemBuilder: (context, index) {
                return ExercisePreview();
              },
            ),
          ),
        ],
      ),
    );
  }
}

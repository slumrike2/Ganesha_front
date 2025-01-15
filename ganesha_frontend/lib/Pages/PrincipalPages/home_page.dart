import 'package:flutter/material.dart';
import 'package:ganesha_frontend/Components/exercise_preview.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizew = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              width: double.infinity,
              child: Text(
                'Ejercicios',
                style: TextStyle(fontSize: 32, color: Colors.white),
                textAlign: TextAlign.center,
              )),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 16,
              children: List.generate(5, (index) => ExercisePreview()),
            ),
          ),
        ],
      ),
    );
  }
}

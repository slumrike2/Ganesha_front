import 'package:flutter/material.dart';

class ExercisePreview extends StatelessWidget {
  const ExercisePreview({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeh = MediaQuery.of(context).size.height;
    final sizew = MediaQuery.of(context).size.width;

    return Container(
      width: sizew * 0.2 + sizeh * 0.1,
      height: sizew * 0.2 + sizeh * 0.1,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            
            width: double.infinity,
            height: sizew * 0.1 + sizeh * 0.05,
            decoration: BoxDecoration(
              color: Colors.blueGrey[600],
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          Text('Ejercicio', style: TextStyle(fontSize: 24)),
          Text('Descripcion del ejercicio'),
        ],
      ),
    );
  }
}

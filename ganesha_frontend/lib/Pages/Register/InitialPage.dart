import 'package:flutter/material.dart';

class InitialRegisterpage extends StatelessWidget {
  const InitialRegisterpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20), // Added margin
      padding: EdgeInsets.all(10),
      height: double.infinity,
      width: double.infinity,
      child: Center(
        // Added Center widget
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the column vertically
          children: [
            Center(
                child: Text(
              'Bienvenido',
              style: TextStyle(fontSize: 32),
            )),
            Center(
              child: Text(
                'Esta es una app que te ayudará con tus síntomas de estrés a través de...',
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}

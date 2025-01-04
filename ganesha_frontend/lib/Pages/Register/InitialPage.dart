import 'package:flutter/material.dart';

class InitialRegisterpage extends StatelessWidget {
  const InitialRegisterpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                'esta es una app que te ayudara con tus sintomas de estes a traves de...',
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class RegisterSimtomsPage extends StatelessWidget {
  const RegisterSimtomsPage({Key? key});

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
              'Sintomas',
              style: TextStyle(fontSize: 32),
            )),
            Center(
              child: Text(
                'Por favor ingrese sus sintomas',
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}

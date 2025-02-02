import 'package:flutter/material.dart';

class RegisterSimtomsPage extends StatelessWidget {
  const RegisterSimtomsPage({super.key});

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
              'Bienvenido a Ganesha!',
              style: TextStyle(fontSize: 16),
            )),
          ],
        ),
      ),
    );
  }
}

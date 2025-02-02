import 'package:flutter/material.dart';

class RegisterSimtomsPage extends StatelessWidget {
  const RegisterSimtomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(24),
      padding: EdgeInsets.all(24),
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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

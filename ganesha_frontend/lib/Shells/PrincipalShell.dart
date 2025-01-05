import 'package:flutter/material.dart';

class Principalshell extends StatefulWidget {
  static final String routeName = '/principal';
  const Principalshell({super.key});

  @override
  State<Principalshell> createState() => _PrincipalshellState();
}

class _PrincipalshellState extends State<Principalshell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Principal Shell'),
      ),
    );
  }
}

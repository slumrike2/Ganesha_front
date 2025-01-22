import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String name;

  UserAvatar({required this.name});

  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    final color = colors[name.hashCode % colors.length];
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '';

    return CircleAvatar(
      backgroundColor: color,
      child: Text(
        initial,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}
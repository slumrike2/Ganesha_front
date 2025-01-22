import 'package:flutter/material.dart';
import 'package:ganesha_frontend/dartTypes.dart';

class SymptomTest extends StatefulWidget {
  final Sintoma data;
  bool checked;

  SymptomTest({super.key, required this.data, this.checked = false});

  @override
  State<SymptomTest> createState() => _SymptomTestState();

  bool isChecked() {
    return checked;
  }

  void setChecked(bool value) {
    checked = value;
  }
}

class _SymptomTestState extends State<SymptomTest> {
  @override
  Widget build(BuildContext context) {
    final sizeh = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(8),
      width: double.infinity,
      height: sizeh * 0.075,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        border: Border.all(
            color: Colors.blueGrey[600] ?? Colors.blueGrey, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.data.nombre,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Checkbox(
            value: widget.checked,
            onChanged: (bool? value) {
              setState(() {
                widget.checked = value ?? false;
              });
            },
          )
        ],
      ),
    );
  }
}

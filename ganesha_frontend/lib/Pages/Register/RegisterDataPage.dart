import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RegisterDataPage extends StatefulWidget {
  RegisterDataPage({super.key});

  @override
  State<RegisterDataPage> createState() => _RegisterDataPageState();

  bool validate() {
    return _RegisterDataPageState._formKey.currentState?.saveAndValidate() ??
        false;
  }

  String? getName() {
    return _RegisterDataPageState._formKey.currentState?.fields['name']?.value;
  }
}

class _RegisterDataPageState extends State<RegisterDataPage> {
  static final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: double.infinity,
      width: double.infinity,
      child: Center(
        // Added Center widget
        child: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the column vertically
            children: [
              Center(
                  child: Text(
                'Datos Personales',
                style: TextStyle(fontSize: 32),
              )),
              Center(
                child: Text(
                  'Por favor ingrese sus datos personales',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              FormBuilderTextField(
                name: 'name',
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su nombre';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  validate() {
    if (_formKey.currentState!.saveAndValidate()) {
      print(_formKey.currentState!.value);
    }
  }
}

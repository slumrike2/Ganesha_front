import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RegisterNamePage extends StatefulWidget {
  RegisterNamePage({Key? key}) : super(key: key);

  @override
  _RegisterNamePageState createState() => _RegisterNamePageState();
}

class _RegisterNamePageState extends State<RegisterNamePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sizeh = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              height: sizeh * 0.8,
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Changed from center to start
                spacing: 20,
                children: [
                  Text('Como te llamas?', style: TextStyle(fontSize: 32)),
                  FormBuilderTextField(
                    name: 'name',
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Nombre'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su nombre';
                      }
                      return null;
                    },
                  ),
                  FormBuilderTextField(
                    name: 'last_name',
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Apellido'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su apellido';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text('Ya tienes cuenta?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text('Inicia sesion'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ganesha_frontend/Pages/login_page.dart';

class RegisterNamePage extends StatefulWidget {
  RegisterNamePage({super.key, this.name = '', this.lastName = ''});

  String name;
  String lastName;

  @override
  _RegisterNamePageState createState() => _RegisterNamePageState();

  bool validate() {
    return _RegisterNamePageState._formKey.currentState?.saveAndValidate() ??
        false;
  }

  String? getName() {
    return _RegisterNamePageState._formKey.currentState?.fields['name']?.value;
  }

  String? getLastName() {
    return _RegisterNamePageState
        ._formKey.currentState?.fields['last_name']?.value;
  }
}

class _RegisterNamePageState extends State<RegisterNamePage> {
  static final _formKey = GlobalKey<FormBuilderState>();
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _lastNameController = TextEditingController(text: widget.lastName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeh = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                height: sizeh,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Changed from center to start
                      spacing: 20,
                      children: [
                        Text('¿Cómo te llamas?', style: TextStyle(fontSize: 32)),
                        FormBuilderTextField(
                          name: 'name',
                          controller: _nameController,
                          decoration: InputDecoration(labelText: 'Nombre'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa tu nombre';
                            }
                            return null;
                          },
                        ),
                        FormBuilderTextField(
                          name: 'last_name',
                          controller: _lastNameController,
                          decoration: InputDecoration(labelText: 'Apellido'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa tu apellido';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: sizeh * 0.1,
                      left: 0,
                      right: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('¿Ya tienes cuenta?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, LoginPage.routeName);
                            },
                            child: Text('Inicia sesión'),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

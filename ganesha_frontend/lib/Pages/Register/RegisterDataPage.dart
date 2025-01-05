import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RegisterDataPage extends StatefulWidget {
  dynamic name = '';
  dynamic email = '';
  dynamic password = '';
  dynamic rePassword = '';
  dynamic username = '';
  RegisterDataPage(
      {super.key,
      this.name,
      this.email,
      this.password,
      this.rePassword,
      this.username});

  @override
  State<RegisterDataPage> createState() => _RegisterDataPageState();

  bool validate() {
    return _RegisterDataPageState._formKey.currentState?.saveAndValidate() ??
        false;
  }

  dynamic getData() {
    return _RegisterDataPageState._formKey.currentState;
  }
}

class _RegisterDataPageState extends State<RegisterDataPage> {
  static final _formKey = GlobalKey<FormBuilderState>();

  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _rePasswordController;

  @override
  void initState() {
    // TODO: implement initState
    _usernameController = TextEditingController(text: widget.username);
    _emailController = TextEditingController(text: widget.email);
    _passwordController = TextEditingController(text: widget.password);
    _rePasswordController = TextEditingController(text: widget.rePassword);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeh = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: sizeh,
          padding: EdgeInsets.all(20),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center the column vertically
              children: [
                Center(
                    child: Text(
                  'Datos Personales de ${widget.name}',
                  style: TextStyle(fontSize: 32),
                )),
                Center(
                  child: Text(
                    'Por favor ingrese sus datos personales',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                FormBuilderTextField(
                  name: 'username',
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su Usuario';
                    }
                    return null;
                  },
                ),
                FormBuilderTextField(
                  name: 'email',
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Correo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su Correo';
                    }
                    return null;
                  },
                ),
                FormBuilderTextField(
                    name: 'password',
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Contraseña'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su Contraseña';
                      }

                      return null;
                    }),
                FormBuilderTextField(
                    name: 'rePassword',
                    controller: _rePasswordController,
                    decoration:
                        InputDecoration(labelText: 'Confirmar Contraseña'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su Telefono';
                      }
                      if (value != _formKey.currentState!.value['password']) {
                        return 'Las contraseñas no coinciden';
                      }
                      return null;
                    }),
              ],
            ),
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

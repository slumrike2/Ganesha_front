import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ganesha_frontend/Shells/PrincipalShell.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  static final String routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final sizeh = MediaQuery.of(context).size.height;
    final sizew = MediaQuery.of(context).size.width;

    SupabaseClient supabase = Supabase.instance.client;

    return Scaffold(
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    height: sizeh,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Changed from center to start
                      spacing: 20,
                      children: [
                        Text('Inicio de Sesion?',
                            style: TextStyle(fontSize: 32)),
                        FormBuilderTextField(
                          name: 'email',
                          decoration: InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese su Email';
                            }
                            return null;
                          },
                        ),
                        FormBuilderTextField(
                          name: 'password',
                          decoration: InputDecoration(labelText: 'Password'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese su Password';
                            }
                            return null;
                          },
                        ),
                        Container(
                          child: TextButton(
                            onPressed: () async {
                              if (_formKey.currentState!.saveAndValidate()) {
                                dynamic aux = _formKey.currentState!.value;

                                try {
                                  final res = await supabase.auth
                                      .signInWithPassword(
                                          email: aux['email'],
                                          password: aux['password']);
                                  Navigator.pushReplacementNamed(
                                      context, Principalshell.routeName);
                                } catch (e) {
                                  print(e);
                                }
                              }
                            },
                            child: Text('Siguiente'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: sizeh * 0.1,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Text('No tienes cuenta?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Registrate'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ganesha_frontend/Shells/principal_shell.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ganesha_frontend/dartTypes.dart';

class LoginPage extends StatefulWidget {
  static final String routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  Future<GaneshaUser> fetchUserData() async {
    SupabaseClient supabase = Supabase.instance.client;

    final response = await http.get(
      Uri.parse(
          '${dotenv.env['API_URL']}/user/${supabase.auth.currentUser!.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['API_KEY']}',
      },
    );

    if (response.statusCode == 200) {
      return GaneshaUser.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeh = MediaQuery.of(context).size.height;

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
                    margin: EdgeInsets.all(24),
                    padding: EdgeInsets.all(24),
                    height: sizeh,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 20,
                      children: [
                        Text('Inicio de Sesión',
                            style: TextStyle(fontSize: 32)),
                        FormBuilderTextField(
                          name: 'email',
                          decoration: InputDecoration(labelText: 'Correo'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa tu Correo';
                            }
                            return null;
                          },
                        ),
                        FormBuilderTextField(
                          name: 'password',
                          decoration: InputDecoration(labelText: 'Contraseña'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa tu Contraseña';
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
                                  await supabase.auth.signInWithPassword(
                                      email: aux['email'],
                                      password: aux['password']);

                                  // Fetch user data after successful login
                                  final userData = await fetchUserData();

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Principalshell(userData: userData),
                                    ),
                                  );
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
                    Text('¿No tienes cuenta?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Regístrate'),
                    ),
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

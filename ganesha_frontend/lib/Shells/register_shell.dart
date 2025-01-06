import 'package:flutter/material.dart';
import 'package:ganesha_frontend/Pages/Register/InitialPage.dart';
import 'package:ganesha_frontend/Pages/Register/RegisterDataPage.dart';
import 'package:ganesha_frontend/Pages/Register/RegisterNamePage.dart';
import 'package:ganesha_frontend/Pages/Register/RegisterSimtomsPage.dart';
import 'package:ganesha_frontend/Shells/principal_shell.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterShell extends StatefulWidget {
  static final String routeName = '/register';
  const RegisterShell({super.key});

  @override
  State<RegisterShell> createState() => _RegisterShellState();
}

class _RegisterShellState extends State<RegisterShell> {
  final PageController _pageController = PageController();
  SupabaseClient supabase = Supabase.instance.client;
  dynamic _index = 0;
  RegisterData datos = RegisterData();

  final pages = [
    InitialRegisterpage(),
    RegisterNamePage(),
    RegisterDataPage(name: ''), // Initialize with an empty name
    RegisterSimtomsPage()
  ];

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _index = index;
              });
            },
            children: pages,
          ),
          if (!isKeyboardOpen)
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.all(20),
                child: TextButton.icon(
                  icon: Icon(Icons.arrow_forward_outlined),
                  iconAlignment: IconAlignment.end,
                  label: _index == pages.length - 1
                      ? Text("Registrar")
                      : Text('Siguiente'),
                  onPressed: () {
                    _index == pages.length - 1 ? register() : forward();
                  },
                ),
              ),
            ),
          if (!isKeyboardOpen && _index != 0)
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: EdgeInsets.all(20),
                child: TextButton.icon(
                  icon: Icon(Icons.arrow_back_outlined),
                  label: Text('Anterior'),
                  onPressed: () {
                    back();
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  forward() {
    if (_index == 1 && !(pages[1] as RegisterNamePage).validate()) {
      return;
    }

    if (_index == 2 && !(pages[2] as RegisterDataPage).validate()) {
      return;
    }

    UpdateData();

    if (_index < pages.length - 1) {
      updatePages();
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  back() {
    UpdateData();
    if (_index > 0) {
      updatePages();
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  updatePages() {
    setState(() {
      pages[1] = RegisterNamePage(
          name: datos.name ?? '', lastName: datos.lastName ?? '');
      pages[2] = RegisterDataPage(
        name: datos.name,
        email: datos.email,
        password: datos.password,
        rePassword: datos.repassword,
        username: datos.username,
      );
    });
  }

  UpdateData() {
    switch (_index) {
      case 1:
        datos.name = (pages[1] as RegisterNamePage).getName() ?? '';
        datos.lastName = (pages[1] as RegisterNamePage).getLastName() ?? '';
        break;
      case 2:
        datos.username =
            (pages[2] as RegisterDataPage).getData().fields['username'].value;
        datos.email =
            (pages[2] as RegisterDataPage).getData().fields['email'].value;
        datos.password =
            (pages[2] as RegisterDataPage).getData().fields['password'].value;
        datos.repassword =
            (pages[2] as RegisterDataPage).getData().fields['rePassword'].value;
        break;
      default:
    }
  }

  register() async {
    try {
      final res = await supabase.auth
          .signUp(password: datos.password!, email: datos.email!);
      if (res.user != null) {
        Navigator.pushReplacementNamed(context, Principalshell.routeName);
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

class RegisterData {
  String? name;
  String? lastName;
  String? username;
  String? email;
  String? password;
  String? repassword;
  String? birthDate;

  RegisterData(
      {this.name, this.lastName, this.email, this.password, this.birthDate});
}

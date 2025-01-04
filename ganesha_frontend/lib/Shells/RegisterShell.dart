import 'package:flutter/material.dart';
import 'package:ganesha_frontend/Pages/Register/InitialPage.dart';
import 'package:ganesha_frontend/Pages/Register/RegisterDataPage.dart';
import 'package:ganesha_frontend/Pages/Register/RegisterNamePage.dart';
import 'package:ganesha_frontend/Pages/Register/RegisterSimtomsPage.dart';

class RegisterShell extends StatefulWidget {
  static final String routeName = '/register';
  const RegisterShell({super.key});

  @override
  State<RegisterShell> createState() => _RegisterShellState();
}

class _RegisterShellState extends State<RegisterShell> {
  final PageController _pageController = PageController();
  dynamic _index = 0;

  final pages = [
    InitialRegisterpage(),
    RegisterNamePage(),
    RegisterDataPage(),
    RegisterSimtomsPage()
  ];

  @override
  Widget build(BuildContext context) {
    final double sizew = MediaQuery.of(context).size.width;
    final double sizeh = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: sizeh,
            width: sizew,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _index = index;
                });
              },
              children: pages,
            ),
          ),
          Align(
            alignment:
                Alignment.bottomRight, // Align the button to the bottom right
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
          _index == 0
              ? Container()
              : Align(
                  alignment: Alignment
                      .bottomLeft, // Align the button to the bottom right
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
                )
        ],
      ),
    );
  }

  forward() {
    if (_index == 2 && !(pages[2] as RegisterDataPage).validate()) {
      // Show an error message or handle validation failure

      return;
    }
    if (_index < pages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  back() {
    if (_index > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  register() {
    final name = (pages[2] as RegisterDataPage).getName();
    print('Nombre registrado: $name');
  }
}

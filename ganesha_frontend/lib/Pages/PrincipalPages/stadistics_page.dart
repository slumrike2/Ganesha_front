import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StadisticsPage extends StatefulWidget {
  const StadisticsPage({super.key});

  @override
  State<StadisticsPage> createState() => _StadisticsPageState();
}

class _StadisticsPageState extends State<StadisticsPage> {
  List<bool> isSelected = [true, false];
  PageController _pageController = PageController();
  int _currentPage = 0; // To keep track of the current page index

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  void _onTogglePressed(int index) {
    setState(() {
      for (int i = 0; i < isSelected.length; i++) {
        isSelected[i] = i == index;
      }
      _currentPage = index * 2; // Update the current page index accordingly
      _pageController.jumpToPage(_currentPage);
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
      _currentPage = (_currentPage / 2).floor() * 2; // Constrain page to the current group
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Estadísticas',
              style: TextStyle(fontSize: 32, color: Colors.white)),
          ToggleButtons(
            fillColor: const Color.fromARGB(181, 103, 147, 243),
            borderRadius: BorderRadius.circular(8.0),
            isSelected: isSelected,
            onPressed: _onTogglePressed,
            children: <Widget>[
              Container(
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Semana',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                width: 100,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Mes',
                  style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: <Widget>[
                Page2(data: 'some data'),
                Page3(),
                Page4(data: 'some data'),
                Page5(),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_left, color: Colors.white),
                  onPressed: () {
                    if (_currentPage % 2 != 0) {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: (_currentPage % 2 == 0) ? Colors.white : Colors.grey,
                      size: 12,
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.circle,
                      color: (_currentPage % 2 == 1) ? Colors.white : Colors.grey,
                      size: 12,
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.arrow_right, color: Colors.white),
                  onPressed: () {
                    if (_currentPage % 2 == 0) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Contenido de la Semana',
          style: TextStyle(fontSize: 24, color: Colors.white)),
    );
  }
}

class Page2 extends StatelessWidget {
  final String data;
  Page2({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Racha más larga',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              SizedBox(height: 8),
              Text('2 días',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Ejercicios realizados',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              SizedBox(height: 8),
              Text('4 ejercicios',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Amigos nuevos',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              SizedBox(height: 8),
              Text('1 amigos',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Horas de música',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              SizedBox(height: 8),
              Text('5 horas',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }
}

class Page4 extends StatelessWidget {
  final String data;
  Page4({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Racha más larga',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              SizedBox(height: 8),
              Text('6 días',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Ejercicios realizados',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              SizedBox(height: 8),
              Text('16 ejercicios',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }
}

class Page5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Amigos nuevos',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              SizedBox(height: 8),
              Text('3 amigos',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Horas de música',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              SizedBox(height: 8),
              Text('20 horas',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:udctespenempatan/Pages/fitur/beranda.dart';
import 'package:udctespenempatan/Pages/fitur/data.dart';
import 'package:udctespenempatan/Pages/fitur/maps.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});


  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  late final List<Widget> _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = [
        Beranda(),
        DataPage(),
        mapsPage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black87,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_chart_outlined),
            label: 'Data Sekolah',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Maps Sekolah',
          ),
        ],
        backgroundColor: Colors.white,
      ),
    );
  }
}

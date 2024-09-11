import 'package:flutter/material.dart';
import 'DoctorPage/ICU_PatientsDetails.dart';
import 'DoctorPage/IPD_PatientsDetail.dart';
import 'DoctorPage/OPD_PatientDetail.dart';

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // List of widgets to navigate to
  final List<Widget> _widgetOptions = <Widget>[
    ICUPage(),
    IPDPage(),
    OPDPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [

            Text(
              widget.username,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.bed),
            label: 'ICU',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bed),
            label: 'IPD',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bed),
            label: 'OPD',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

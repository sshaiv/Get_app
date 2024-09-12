import 'package:flutter/material.dart';
import 'DoctorPage/ICU_PatientsDetails.dart';
import 'DoctorPage/IPD_PatientsDetail.dart';
import 'DoctorPage/OPD_PatientDetail.dart';
import 'package:google_fonts/google_fonts.dart';

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
        backgroundColor: const Color.fromARGB(255, 165, 216, 239),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("Login : ", style: GoogleFonts.daysOne(
              fontSize: 10,
              color: Colors.black,
            ),),

            Text(
              widget.username,
              style: GoogleFonts.daysOne(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
        leading:
        IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
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

import 'package:flutter/material.dart';
import 'DoctorPage/ICU_PatientsDetails.dart';
import 'DoctorPage/IPD_PatientsDetail.dart';
import 'DoctorPage/OPD_PatientDetail.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final String username;
  final String empid;

  const HomePage({super.key, required this.username, required this.empid});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

 
  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = [
      ICUPage(empid: widget.empid),
      IPDPage(empid: widget.empid),
      // OPDPage(empid: widget.empid),
    ];
  }

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
            Text("Login: ", style: GoogleFonts.daysOne(fontSize: 10, color: Colors.red)),
            Text(widget.username, style: GoogleFonts.daysOne(fontSize: 18, color: Colors.red)),
            const SizedBox(width: 8), 
            Text(widget.empid, style: GoogleFonts.daysOne(fontSize: 18, color: Colors.red)),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.local_hospital), label: 'ICU'),
          BottomNavigationBarItem(icon: Icon(Icons.local_hospital), label: 'IPD'),
          BottomNavigationBarItem(icon: Icon(Icons.local_hospital), label: 'OPD'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

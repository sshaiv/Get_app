//
// import 'package:doctor_app/DoctorPage/ICUPage_icons/MedicinePage.dart';
// import 'package:doctor_app/DoctorPage/ICUPage_icons/SummaryPage.dart';
// import 'package:doctor_app/DoctorPage/ICUPage_icons/VitalsPage.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// import 'GraphPage.dart';
//
//
// class InvestigationPage extends StatefulWidget {
//   const InvestigationPage({super.key});
//
//   @override
//   InvestigationPageState createState() => InvestigationPageState();
// }
//
// class InvestigationPageState extends State<InvestigationPage> {
//   int _currentIndex = 0;
//
//   final List<Widget> _widgetOptions = <Widget>[
//     const InvestigationContent(), // Custom widget to hold the investigation content
//     VitalsPage(),
//     MedicinePage(),
//     SummaryPage(),
//   ];
//
//   void onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _widgetOptions.elementAt(_currentIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: _currentIndex,
//         onTap: onTabTapped,
//         items: const [
//           BottomNavigationBarItem(
//             icon: FaIcon(FontAwesomeIcons.vial),
//             label: 'Investigation',
//           ),
//           BottomNavigationBarItem(
//             icon: FaIcon(FontAwesomeIcons.heartPulse),
//             label: 'Vitals',
//           ),
//           BottomNavigationBarItem(
//             icon: FaIcon(FontAwesomeIcons.pills),
//             label: 'Medicine',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.description),
//             label: 'Summary',
//           ),
//         ],
//         selectedItemColor: Colors.black,
//         backgroundColor: Colors.blue[100],
//       ),
//     );
//   }
// }
//
// class InvestigationContent extends StatelessWidget {
//   const InvestigationContent({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('ICU : Patient Name',
//             style: TextStyle(fontWeight: FontWeight.bold)),
//         backgroundColor: const Color(0xffcdd8dc),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     height: 50,
//                     width: 125,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: Colors.grey[300],
//                     ),
//                     child: const Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Icon(Icons.calendar_month),
//                         Text(
//                           '05/08/2024',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 15),
//                         ),
//                       ],
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       print('order clicked');
//                     },
//                     child: Container(
//                       height: 50,
//                       width: 100,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(50),
//                         color: const Color(0xff89aec3),
//                       ),
//                       child: const Center(
//                         child: Text(
//                           'Order',
//                           style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.white),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: InkWell(
//                       onTap: () {
//                         // Define the action when the container is tapped
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => GraphPage()),
//                         );
//                       },
//                       child: Container(
//                         height: 100,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           color: const Color(0xfff4f1f1),
//                         ),
//                         child: const Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'CBC',
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black),
//                               ),
//                               Text(
//                                 '23-07-2023',
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black54),
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     '09:30 AM ',
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black54),
//                                   ),
//                                   Icon(
//                                     Icons.circle,
//                                     color: Colors.red,
//                                     size: 20,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: InkWell(
//                       onTap: () {
//                         // Define the action when the container is tapped
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => GraphPage()),
//                         );
//                       },
//                       child: Container(
//                         height: 100,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           color: const Color(0xfff4f1f1),
//                         ),
//                         child: const Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Blood Culture',
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black),
//                               ),
//                               Text(
//                                 '23-07-2023',
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black54),
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     '09:30 AM ',
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black54),
//                                   ),
//                                   Icon(
//                                     Icons.circle,
//                                     color: Colors.green,
//                                     size: 20,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: InkWell(
//                       onTap: () {
//                         // Define the action when the container is tapped
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => GraphPage()),
//                         );
//                       },
//                       child: Container(
//                         height: 100,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           color: const Color(0xfff4f1f1),
//                         ),
//                         child: const Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Electrolyte',
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black),
//                               ),
//                               Text(
//                                 '23-07-2023',
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black54),
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     '09:30 AM ',
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black54),
//                                   ),
//                                   Icon(
//                                     Icons.circle,
//                                     color: Colors.yellow,
//                                     size: 20,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: InkWell(
//                       onTap: () {
//                         // Define the action when the container is tapped
//                         // Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(builder: (context) => GraphPage()),
//                         // );
//                       },
//                       child: Container(
//                         height: 100,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           color: const Color(0xfff4f1f1),
//                         ),
//                         child: const Padding(
//                           padding: EdgeInsets.all(8.0),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../MedicinePage.dart';
import '../SummaryPage.dart';
import '../VitalsPage.dart';
import 'GraphPage.dart';


class InvestigationPage extends StatefulWidget {
  final String visitId;

  const InvestigationPage({super.key, required this.visitId});

  @override
  InvestigationPageState createState() => InvestigationPageState();
}

class InvestigationPageState extends State<InvestigationPage> {
  int _currentIndex = 0;
  late Future<Map<String, dynamic>> _investigationDetails;

  @override
  void initState() {
    super.initState();
    // Initialize _investigationDetails in initState
    _investigationDetails = fetchInvestigationDetails(widget.visitId);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      // Pass visitId to InvestigationContent here
      InvestigationContent(visitId: widget.visitId),
      VitalsPage(),
      MedicinePage(),
      SummaryPage(),
    ];

    return Scaffold(
      body: _widgetOptions.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.vial),
            label: 'Investigation',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.heartPulse),
            label: 'Vitals',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.pills),
            label: 'Medicine',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Summary',
          ),
        ],
        selectedItemColor: Colors.black,
        backgroundColor: Colors.blue[100],
      ),
    );
  }

  Future<Map<String, dynamic>> fetchInvestigationDetails(String visitId) async {
    final url = 'https://doctorapi.medonext.com/api/DoctorAPI/GetData?JsonAppInbox=${Uri.encodeComponent(json.encode({
      "doctorid": "24",
      "fromdate": "",
      "todate": "",
      "datafor": "INV",
      "gCookieSessionOrgID": "48",
      "gCookieSessionDBId": "gdnew",
      "AcName": "IPD",
      "visitid": visitId
    }))}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load investigation details');
    }
  }
}




class InvestigationContent extends StatelessWidget {
  final String visitId;

  const InvestigationContent({super.key, required this.visitId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ICU_Patient:$visitId', // Display visitId in the title
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
        backgroundColor: const Color(0xffcdd8dc),
      ),
      body: Center(
        child: Text("Investigation Content will be displayed here"),
      ),
    );
  }
}



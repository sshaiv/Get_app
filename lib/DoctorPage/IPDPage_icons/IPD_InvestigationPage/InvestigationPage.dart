// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:http/http.dart' as http;
// import '../MedicinePage.dart';
// import '../SummaryPage.dart';
// import '../VitalsPage.dart';

// class IPD_InvestigationPage extends StatefulWidget {
//   final String visitId;

//   const IPD_InvestigationPage({super.key, required this.visitId});

//   @override
//   IPD_InvestigationPageState createState() => IPD_InvestigationPageState();
// }

// class IPD_InvestigationPageState extends State<IPD_InvestigationPage> {
//   int _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> _widgetOptions = <Widget>[
//       IPD_InvestigationContent(visitId: widget.visitId),
//       IPD_VitalsPage(),
//       IPD_MedicinePage(),
//       IPD_SummaryPage(),
//     ];

//     return Scaffold(
//       body: _widgetOptions.elementAt(_currentIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
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

// class IPD_InvestigationContent extends StatelessWidget {
//   final String visitId;

//   const IPD_InvestigationContent({super.key, required this.visitId});

// Future<Map<String, dynamic>> fetchInvestigationDetails(String visitId) async {
//   final url = 'https://doctorapi.medonext.com/api/DoctorAPI/GetData?JsonAppInbox=${Uri.encodeComponent(json.encode({
//     "doctorid": "",
//     "fromdate": "",
//     "todate": "",
//     "datafor": "INV",
//     "gCookieSessionOrgID": "48",
//     "gCookieSessionDBId": "gdnew",
//     "AcName": "IPD",
//     "visitid": visitId,
//   }))}';

//   final response = await http.get(Uri.parse(url));

//   if (response.statusCode == 200) {
//     // Decode the response body
//     final responseData = json.decode(response.body);
//     // Ensure it's a Map<String, dynamic>
//     if (responseData is Map<String, dynamic>) {
//       return responseData;
//     } else {
//       throw Exception('Unexpected response format');
//     }
//   } else {
//     throw Exception('Failed to load investigation details: ${response.statusCode}');
//   }
// }


  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('IPD_Patient: $visitId',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
//         backgroundColor: const Color(0xffcdd8dc),
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: fetchInvestigationDetails(visitId),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data == null) {
//             return Center(child: Text('No data available'));
//           }

//           final data = snapshot.data!;
//           List<dynamic> items = data['Table'] ?? [];

//           if (items.isEmpty) {
//             return Center(child: Text('No investigations found.'));
//           }

//           return ListView.builder(
//             itemCount: items.length,
//             itemBuilder: (context, index) {
//               final item = items[index];
//               return Card(
//                 margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                 elevation: 4,
//                 child: ListTile(
//                   contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   title: Text(
//                     item['servname'] ?? 'No name',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                       color: Color.fromARGB(255, 2, 66, 130),
//                     ),
//                   ),
//                   subtitle: Text(
//                     'Order Date: ${item['orddate'] ?? 'No date'}',
//                     style: TextStyle(
//                       color: Colors.grey[600],
//                       fontSize: 14,
//                     ),
//                   ),
//                   trailing: IconButton(
//                     icon: Icon(Icons.picture_as_pdf),
//                     color: Colors.red,
//                     onPressed: () {
//                       final pdfUrl = item['pdfpath'];
//                       if (pdfUrl != null && pdfUrl.isNotEmpty) {
//                         // Handle PDF URL action here (e.g., open PDF)
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('PDF not available')),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../MedicinePage.dart';
import '../SummaryPage.dart';
import '../VitalsPage.dart';

class IPD_InvestigationPage extends StatefulWidget {
  final String visitId;

  const IPD_InvestigationPage({super.key, required this.visitId});

  @override
  IPD_InvestigationPageState createState() => IPD_InvestigationPageState();
}

class IPD_InvestigationPageState extends State<IPD_InvestigationPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      IPD_InvestigationContent(visitId: widget.visitId),
      IPD_VitalsPage(),
      IPD_MedicinePage(),
      IPD_SummaryPage(),
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
}

class IPD_InvestigationContent extends StatelessWidget {
  final String visitId;

  const IPD_InvestigationContent({super.key, required this.visitId});

// Future<Map<String, dynamic>> fetchInvestigationDetails(String visitId) async {
//   final url = 'https://doctorapi.medonext.com/api/DoctorAPI/GetData?JsonAppInbox=${Uri.encodeComponent(json.encode({
//     "doctorid": "",
//     "fromdate": "",
//     "todate": "",
//     "datafor": "INV",
//     "gCookieSessionOrgID": "48",
//     "gCookieSessionDBId": "gdnew",
//     "AcName": "IPD",
//     "visitid": visitId,
//   }))}';

//   final response = await http.get(Uri.parse(url));
//   print('Response status: ${response.statusCode}');
//   print('Response body: ${response.body}');

//   if (response.statusCode == 200) {
//     final responseData = json.decode(response.body);
//     if (responseData is Map<String, dynamic>) {
//       return responseData;
//     } else {
//       throw Exception('Unexpected response format: ${responseData.toString()}');
//     }
//   } else {
//     throw Exception('Failed to load investigation details: ${response.statusCode}');
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('IPD Patient: $visitId',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
//         backgroundColor: const Color(0xffcdd8dc),
//       ),
// body: FutureBuilder<Map<String, dynamic>>(
//   future: fetchInvestigationDetails(visitId),
//   builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return Center(child: CircularProgressIndicator());
//     } else if (snapshot.hasError) {
//       return Center(child: Text('Error: ${snapshot.error}'));
//     } else if (!snapshot.hasData || snapshot.data == null) {
//       return Center(child: Text('No data available'));
//     }

//     final data = snapshot.data!;
//     List<dynamic> items = data['Table'] ?? [];

//     if (items.isEmpty) {
//       return Center(child: Text('No investigations found.'));
//     }

//     return ListView.builder(
//       itemCount: items.length,
//       itemBuilder: (context, index) {
//         final item = items[index];
//         return Card(
//           margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//           elevation: 4,
//           child: ListTile(
//             contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             title: Text(
//               item['servname'] ?? 'No name',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//                 color: Color.fromARGB(255, 2, 66, 130),
//               ),
//             ),
//             subtitle: Text(
//               'Order Date: ${item['orddate'] ?? 'No date'}',
//               style: TextStyle(
//                 color: Colors.grey[600],
//                 fontSize: 14,
//               ),
//             ),
//             trailing: IconButton(
//               icon: Icon(Icons.picture_as_pdf),
//               color: Colors.red,
//               onPressed: () {
//                 final pdfUrl = item['pdfpath'];
//                 if (pdfUrl != null && pdfUrl.isNotEmpty) {
//                   // Handle PDF URL action here (e.g., open PDF)
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('PDF not available')),
//                   );
//                 }
//               },
//             ),
//           ),
//         );
//       },
//     );
//   },
// ),
//     );
//   }
// }

Future<Map<String, dynamic>> fetchInvestigationDetails(String visitId) async {
  final url = 'https://doctorapi.medonext.com/api/DoctorAPI/GetData?JsonAppInbox=${Uri.encodeComponent(json.encode({
    "doctorid": "",
    "fromdate": "",
    "todate": "",
    "datafor": "INV",
    "gCookieSessionOrgID": "48",
    "gCookieSessionDBId": "gdnew",
    "AcName": "IPD",
    "visitid": visitId,
  }))}';

  final response = await http.get(Uri.parse(url));
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    final responseData = json.decode(json.decode(response.body));
    if (responseData is Map<String, dynamic>) {
      return responseData;
    } 
    else {
      throw Exception('Unexpected response format: ${responseData.toString()}');
    }
  } else {
    throw Exception('Failed to load investigation details: ${response.statusCode}');
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('IPD Patient: $visitId',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      backgroundColor: const Color(0xffcdd8dc),
    ),
    body: FutureBuilder<Map<String, dynamic>>(
      future: fetchInvestigationDetails(visitId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No data available'));
        }

        final data = snapshot.data!;
        List<dynamic> items = data['Table'] ?? [];

        // Handle empty items gracefully
        if (items.isEmpty) {
          return Center(child: Text('No investigations found.'));
        }

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              elevation: 4,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Text(
                  item['servname'] ?? 'No name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color.fromARGB(255, 2, 66, 130),
                  ),
                ),
                subtitle: Text(
                  'Order Date: ${item['orddate'] ?? 'No date'}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.picture_as_pdf),
                  color: Colors.red,
                  onPressed: () {
                    final pdfUrl = item['pdfpath'];
                    if (pdfUrl != null && pdfUrl.isNotEmpty) {
                      // Handle PDF URL action here (e.g., open PDF)
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('PDF not available')),
                      );
                    }
                  },
                ),
              ),
            );
          },
        );
      },
    ),
  );
}
}
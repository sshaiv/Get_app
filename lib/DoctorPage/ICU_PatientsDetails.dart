
import 'package:flutter/material.dart';
import 'package:doctor_app/DoctorPage/ICUPage_icons/InvestigationPage/InvestigationPage.dart';
import 'package:doctor_app/DoctorPage/ICUPage_icons/MedicinePage.dart';
import 'package:doctor_app/DoctorPage/ICUPage_icons/SettingsPage.dart';
import 'package:doctor_app/DoctorPage/ICUPage_icons/SummaryPage.dart';
import 'package:doctor_app/DoctorPage/ICUPage_icons/VitalsPage.dart';
import 'package:doctor_app/DoctorPage/ICUPage_icons/register.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ICUPage extends StatelessWidget {
  const ICUPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ICUPatientList(username: '',);
  }
}

class ICUPatientList extends StatelessWidget {
  const ICUPatientList({super.key, required String username});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/patient_img.png'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Patient Name',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        const Text(
                          'IPD No. D1123240010383',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 4),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildIconButton(
                                  context, Icons.add, Colors.red, AddPage()),
                              _buildFontAwesomeIconButton(
                                  context,
                                  FontAwesomeIcons.vial,
                                  Colors.blue,
                                  const InvestigationPage()),
                              _buildFontAwesomeIconButton(
                                  context,
                                  FontAwesomeIcons.heartPulse,
                                  Colors.red,
                                  VitalsPage()),
                              _buildFontAwesomeIconButton(
                                  context,
                                  FontAwesomeIcons.pills,
                                  Colors.blue,
                                  MedicinePage()),
                              _buildIconButton(context, Icons.description,
                                  Colors.red, SummaryPage()),
                              _buildIconButton(context, Icons.settings,
                                  Colors.grey, SettingsPage()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIconButton(BuildContext context, IconData icon,
      Color backgroundColor, Widget destinationPage) {
    return Container(
      width: 32.0,
      height: 32.0,
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 18.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destinationPage),
          );
        },
      ),
    );
  }

  Widget _buildFontAwesomeIconButton(BuildContext context, IconData icon,
      Color backgroundColor, Widget destinationPage) {
    return Container(
      width: 32.0,
      height: 32.0,
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: IconButton(
        icon: FaIcon(icon, color: Colors.white, size: 18.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destinationPage),
          );
        },
      ),
    );
  }
}








// import 'package:flutter/material.dart';
// import 'package:doctor_app/DoctorPage/ICUPage_icons/InvestigationPage/InvestigationPage.dart';
// import 'package:doctor_app/DoctorPage/ICUPage_icons/MedicinePage.dart';
// import 'package:doctor_app/DoctorPage/ICUPage_icons/SettingsPage.dart';
// import 'package:doctor_app/DoctorPage/ICUPage_icons/SummaryPage.dart';
// import 'package:doctor_app/DoctorPage/ICUPage_icons/VitalsPage.dart';
// import 'package:doctor_app/DoctorPage/ICUPage_icons/register.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;


// class ICUPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ICUPatientList(username: ''),
//     );
//   }
// }
//
// // ICUPatientList widget
// class ICUPatientList extends StatefulWidget {
//   const ICUPatientList({super.key, required this.username});
//
//   final String username;
//
//   @override
//   _ICUPatientListState createState() => _ICUPatientListState();
// }
//
// class Patient {
//   final String name;
//
//   Patient({required this.name});
//
//   factory Patient.fromJson(Map<String, dynamic> json) {
//     return Patient(
//       name: json['patname'] ?? 'No Name',
//     );
//   }
// }
//b
// class _ICUPatientListState extends State<ICUPatientList> {
//   late Future<List<Patient>> _patients;
//
//   @override
//   void initState() {
//     super.initState();
//     _patients = ApiService().fetchPatients();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Patient>>(
//       future: _patients,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return Center(child: Text('No patients found.'));
//         } else {
//           List<Patient> patients = snapshot.data!;
//
//           return ListView.builder(
//             itemCount: patients.length,
//             itemBuilder: (context, index) {
//               final patient = patients[index];
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Card(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(width: 15),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 patient.name,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               SingleChildScrollView(
//                                 scrollDirection: Axis.horizontal,
//                                 child: Row(
//                                   children: [
//                                     _buildIconButton(context, Icons.add, Colors.red, AddPage()),
//                                     _buildFontAwesomeIconButton(context, FontAwesomeIcons.vial, Colors.blue, InvestigationPage()),
//                                     _buildFontAwesomeIconButton(context, FontAwesomeIcons.heartPulse, Colors.red, VitalsPage()),
//                                     _buildFontAwesomeIconButton(context, FontAwesomeIcons.pills, Colors.blue, MedicinePage()),
//                                     _buildIconButton(context, Icons.description, Colors.red, SummaryPage()),
//                                     _buildIconButton(context, Icons.settings, Colors.grey, SettingsPage()),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//       },
//     );
//   }

//   Widget _buildIconButton(BuildContext context, IconData icon, Color backgroundColor, Widget destinationPage) {
//     return Container(
//       width: 32.0,
//       height: 32.0,
//       margin: const EdgeInsets.symmetric(horizontal: 3.0),
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(4.0),
//       ),
//       child: IconButton(
//         icon: Icon(icon, color: Colors.white, size: 18.0),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => destinationPage),
//           );
//         },
//       ),
//     );
//   }


//   Widget _buildFontAwesomeIconButton(BuildContext context, IconData icon, Color backgroundColor, Widget destinationPage) {
//     return Container(
//       width: 32.0,
//       height: 32.0,
//       margin: const EdgeInsets.symmetric(horizontal: 3.0),
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(4.0),
//       ),
//       child: IconButton(
//         icon: FaIcon(icon, color: Colors.white, size: 18.0),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => destinationPage),
//           );
//         },
//       ),
//     );
//   }
// }


// API Service class
// class ApiService {
//   final String baseUrl = 'https://doctorapi.medonext.com/api/DoctorAPI/GetData?JsonAppInbox={%22doctorid%22:%2224%22,%22fromdate%22:%22%22,%22todate%22:%22%22,%22datafor%22:%22IPD%22,%22gCookieSessionOrgID%22:%2248%22,%22gCookieSessionDBId%22:%22gdnew%22}';
//
//   Future<List<Patient>> fetchPatients() async {
//     final response = await http.get(Uri.parse(baseUrl));
//
//     if (response.statusCode == 200) {
//       List<dynamic> data = json.decode(json.decode(response.body));
//       return data.map((json) => Patient.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load patients');
//     }
//   }
// }

import 'dart:convert';
import 'package:doctor_app/DoctorPage/IPDPage_icons/MedicinePage.dart';
import 'package:doctor_app/DoctorPage/IPDPage_icons/SettingsPage.dart';
import 'package:doctor_app/DoctorPage/IPDPage_icons/SummaryPage.dart';
import 'package:doctor_app/DoctorPage/IPDPage_icons/VitalsPage.dart';
import 'package:doctor_app/DoctorPage/IPDPage_icons/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'IPDPage_icons/IPD_InvestigationPage/InvestigationPage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IPDPage(),
    );
  }
}

class IPDPage extends StatelessWidget {
  Future<List<PatientData>> fetchPatientData() async {
    final response = await http.get(Uri.parse(
        'https://doctorapi.medonext.com/api/DoctorAPI/GetData?JsonAppInbox={"doctorid":"24","fromdate":"","todate":"","datafor":"IPD","gCookieSessionOrgID":"48","gCookieSessionDBId":"gdnew"}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(json.decode(response.body));
      final List<dynamic> patientsList = data['Table'] as List<dynamic>;
      return patientsList.map((patient) => PatientData.fromJson(patient)).toList();
    } else {
      throw Exception('Failed to load patient data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<PatientData>>(
        future: fetchPatientData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final patients = snapshot.data!;
            return ListView.builder(
              itemCount: patients.length,
              itemBuilder: (context, index) {
                final patient = patients[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/images/patient_img.png'),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      patient.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      'Visit ID: ${patient.visitId}',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    // Text(
                                    //   'Bed No: ${patient.bedNo}',
                                    //   style: const TextStyle(
                                    //     fontSize: 16,
                                    //     color: Colors.black54,
                                    //   ),
                                    // ),
                                    // Text(
                                    //   'Ward: ${patient.wardCategory}',
                                    //   style: const TextStyle(
                                    //     fontSize: 16,
                                    //     color: Colors.black54,
                                    //   ),
                                    // ),
                                    // Text(
                                    //   'Admission Date: ${patient.admissionDate}',
                                    //   style: const TextStyle(
                                    //     fontSize: 16,
                                    //     color: Colors.black54,
                                    //   ),
                                    // ),


                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                _buildIconButton(
                                    context, Icons.add,Colors.red, IPD_AddPage()),
                                _buildFontAwesomeIconButton(
                                    context,
                                    FontAwesomeIcons.vial,
                                    Colors.blue,
                                    const IPD_InvestigationPage()),
                                _buildFontAwesomeIconButton(
                                    context,
                                    FontAwesomeIcons.heartPulse,
                                    Colors.red,
                                    IPD_VitalsPage()),
                                _buildFontAwesomeIconButton(
                                    context,
                                    FontAwesomeIcons.pills,
                                    Colors.blue,
                                   IPD_MedicinePage()),
                                _buildIconButton(context, Icons.description,
                                    Colors.red, IPD_SummaryPage()),
                                _buildIconButton(context, Icons.settings,
                                    Colors.grey, IPD_SettingsPage()),
                              ],
                            ),
                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildIconButton(BuildContext context, IconData icon,
      Color backgroundColor, Widget destinationPage) {
    return Container(
      width: 25.0,
      height: 25.0,
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 12.0),
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
      width: 25.0,
      height: 25.0,
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: IconButton(
        icon: FaIcon(icon, color: Colors.white, size: 12.0),
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

class PatientData {
  final String name;
  final String visitId;
  // final String bedNo;
  // final String wardCategory;
  // final String admissionDate;

  PatientData({
    required this.name,
    required this.visitId,
    // required this.bedNo,
    // required this.wardCategory,
    // required this.admissionDate,
  });

  factory PatientData.fromJson(Map<String, dynamic> json) {
    return PatientData(
      name: json['patname'] ?? 'Unknown',
      visitId: json['visitid'] ?? '',
      // bedNo: json['bedno'] ?? '',
      // wardCategory: json['wardcatg'] ?? '',
      // admissionDate: json['admisiondate'] ?? '',
    );
  }
}
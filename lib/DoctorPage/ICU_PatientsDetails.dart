import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:doctor_app/DoctorPage/ICUPage_icons/MedicinePage.dart';
import 'package:doctor_app/DoctorPage/ICUPage_icons/SettingsPage.dart';
import 'package:doctor_app/DoctorPage/ICUPage_icons/SummaryPage.dart';
import 'package:doctor_app/DoctorPage/ICUPage_icons/VitalsPage.dart';
import 'package:doctor_app/DoctorPage/ICUPage_icons/register.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'ICUPage_icons/ICU_InvestigationPage/InvestigationPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ICUPage(),
    );
  }
}

class ICUPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ICUPatientList(username: 'exampleUser'),
    );
  }
}


class ICUPatientList extends StatelessWidget {
  final String username;

  const ICUPatientList({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PatientData>>(
      // fetch patient data
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
                    child: Row(
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
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                'ICU ID: ${patient.visitId}', // Adjust according to your data model
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
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
                                        context, FontAwesomeIcons.vial, Colors.blue, InvestigationPage(visitId: patient.visitId)),
                                    _buildFontAwesomeIconButton(
                                        context, FontAwesomeIcons.heartPulse, Colors.red, VitalsPage()),
                                    _buildFontAwesomeIconButton(
                                        context, FontAwesomeIcons.pills, Colors.blue, MedicinePage()),
                                    _buildIconButton(
                                        context, Icons.description, Colors.red, SummaryPage()),
                                    _buildIconButton(
                                        context, Icons.settings, Colors.grey, SettingsPage()),
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
              );
            },
          );
        }
      },
    );
  }

  Widget _buildIconButton(BuildContext context, IconData icon, Color backgroundColor, Widget destinationPage) {
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

  Widget _buildFontAwesomeIconButton(BuildContext context, IconData icon, Color backgroundColor, Widget destinationPage) {
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

  Future<List<PatientData>> fetchPatientData() async {
    final response = await http.get(Uri.parse(
        'https://doctorapi.medonext.com//api/DoctorAPI/GetData?JsonAppInbox={%22doctorid%22:%2224%22,%22fromdate%22:%22%22,%22todate%22:%22%22,%22datafor%22:%22ICU%22,%22gCookieSessionOrgID%22:%2248%22,%22gCookieSessionDBId%22:%22gdnew%22}'
    ));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(json.decode(response.body));
      final List<dynamic> patientsList = data['Table'] as List<dynamic>;
      return patientsList.map((patient) => PatientData.fromJson(patient)).toList();
    } else {
      throw Exception('Failed to load patient data');
    }
  }
}

class PatientData {
  final String name;
  final String visitId;

  PatientData({
    required this.name,
    required this.visitId,
  });

  factory PatientData.fromJson(Map<String, dynamic> json) {
    return PatientData(
      name: json['patname'] ?? 'Unknown',
      visitId: json['visitid'] ?? '',
    );
  }
}

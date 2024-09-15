import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'IPDPage_icons/IPD_InvestigationPage/InvestigationPage.dart';
import 'IPDPage_icons/MedicinePage.dart';
import 'IPDPage_icons/SettingsPage.dart';
import 'IPDPage_icons/SummaryPage.dart';
import 'IPDPage_icons/VitalsPage.dart';
import 'IPDPage_icons/register.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IPDPatientList(username: 'exampleUser'),
    );
  }
}

class IPDPatientList extends StatelessWidget {
  final String username;

  const IPDPatientList({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchPatientData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!['Table'] == null || (snapshot.data!['Table'] as List).isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          final List<dynamic> patientsList = snapshot.data!['Table'] as List<dynamic>;
          final patients = patientsList.map((patient) => PatientData.fromJson(patient)).toList();

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
                                'IPD ID: ${patient.visitId}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
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
                                    _buildIconButton(context, Icons.add, Colors.red, IPD_AddPage()),
                                    _buildFontAwesomeIconButton(context, FontAwesomeIcons.vial, Colors.blue, IPD_InvestigationPage(visitId: patient.visitId)),
                                    _buildFontAwesomeIconButton(context, FontAwesomeIcons.heartPulse, Colors.red, IPD_VitalsPage()),
                                    _buildFontAwesomeIconButton(context, FontAwesomeIcons.pills, Colors.blue, IPD_MedicinePage()),
                                    _buildIconButton(context, Icons.description, Colors.red, IPD_SummaryPage()),
                                    _buildIconButton(context, Icons.settings, Colors.grey, IPD_SettingsPage()),
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

  Future<Map<String, dynamic>> fetchPatientData() async {
    final url = 'https://doctorapi.medonext.com/api/DoctorAPI/GetData?JsonAppInbox=${Uri.encodeComponent(json.encode({
      "doctorid": "24",
      "fromdate": "",
      "todate": "",
      "datafor": "IPD",
      "gCookieSessionOrgID": "48",
      "gCookieSessionDBId": "gdnew",
    }))}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(json.decode(response.body)) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load patient data');
    }
  }
}

class PatientData {
  final String name;
  final String visitId;
  final String gssuhid;

  PatientData({
    required this.name,
    required this.visitId,
    required this.gssuhid,
  });

  factory PatientData.fromJson(Map<String, dynamic> json) {
    return PatientData(
      name: json['patname'] ?? 'Unknown',
      visitId: json['visitid'] ?? '',
      gssuhid: json['gssuhid']?.toString() ?? '',
    );
  }
}

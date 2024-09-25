import 'dart:convert';
import 'package:doctor_app/DoctorPage/IPDPage_icons/MedicinePage.dart';
import 'package:doctor_app/DoctorPage/IPDPage_icons/SummaryPage.dart';
import 'package:doctor_app/DoctorPage/IPDPage_icons/VitalsPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;


class IPD_InvestigationPage extends StatefulWidget {
  final String visitId;
  final String gssuhid; // gssuhid parameter

  const IPD_InvestigationPage({
    super.key,
    required this.visitId,
    required this.gssuhid,
  });

  @override
  IPD_InvestigationPageState createState() => IPD_InvestigationPageState();
}

class IPD_InvestigationPageState extends State<IPD_InvestigationPage> {
  int _currentIndex = 0;

  Future<Map<String, dynamic>> fetchInvestigationDetails(String visitId) async {
    final url = 'https://doctorapi.medonext.com/api/DoctorAPI/GetData?JsonAppInbox=${Uri.encodeComponent(json.encode({
      "doctorid": "",
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
      return json.decode(json.decode(response.body));
    } else {
      throw Exception('Failed to load investigation details');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      IPD_InvestigationContent(visitId: widget.visitId),
      IPD_VitalsPage(),
      IPD_MedicinePage(),
      IPD_SummaryPage(),
    ];

    return Scaffold(
      body: widgetOptions.elementAt(_currentIndex),
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
            label: 'IPD Investigation',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.heartPulse),
            label: 'IPD Vitals',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.pills),
            label: 'IPD Medicine',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'IPD Summary',
          ),
        ],
        selectedItemColor: Colors.black,
        backgroundColor: Colors.blue[100],
      ),
    );
  }
}

// Content for Investigation Page
class IPD_InvestigationContent extends StatelessWidget {
  final String visitId;

  const IPD_InvestigationContent({super.key, required this.visitId});

  Future<Map<String, dynamic>> fetchInvestigationDetails(String visitId) async {
    final url = 'https://doctorapi.medonext.com/api/DoctorAPI/GetData?JsonAppInbox=${Uri.encodeComponent(json.encode({
      "doctorid": "",
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
      return json.decode(json.decode(response.body));
    } else {
      throw Exception('Failed to load investigation details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ICU Patient: $visitId',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        backgroundColor: Colors.blueGrey[100],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchInvestigationDetails(visitId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available'));
          }

          final data = snapshot.data!;
          List<dynamic> items = data['Table'] ?? [];

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 4,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    item['servname'] ?? 'No name',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    'Order Date: ${item['orddate'] ?? 'No date'}',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.picture_as_pdf,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      final pdfUrl = item['pdfpath'];
                      if (pdfUrl != null && pdfUrl.isNotEmpty) {
                        // Implement PDF URL action here
                        // For example, use the `url_launcher` package to open the PDF
                        // launch(pdfUrl);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('PDF not available')),
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

// Example Page with Button to Navigate to IPD_InvestigationPage
class ExamplePage extends StatelessWidget {
  final String visitId = "12345"; // Sample visit ID
  final String gssuhid = "ABC123"; // Sample gssuhid

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Example Page")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IPD_InvestigationPage(visitId: visitId, gssuhid: gssuhid),
              ),
            );
          },
          child: const Text("Go to Investigation Page"),
        ),
      ),
    );
  }
}

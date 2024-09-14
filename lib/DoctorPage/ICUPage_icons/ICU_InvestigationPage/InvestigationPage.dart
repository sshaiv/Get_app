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
  final String gssuhid;

  const InvestigationPage({super.key, required this.visitId, required this.gssuhid});

  @override
  InvestigationPageState createState() => InvestigationPageState();
}

class InvestigationPageState extends State<InvestigationPage> {
  int _currentIndex = 0;
  late Future<Map<String, dynamic>> _investigationDetails;

  @override
  void initState() {
    super.initState();
    _investigationDetails = fetchInvestigationDetails(widget.visitId, widget.gssuhid);
  }

  Future<Map<String, dynamic>> fetchInvestigationDetails(String visitId, String gssuhid) async {
    final url = 'https://doctorapi.medonext.com/api/DoctorAPI/GetData?JsonAppInbox=${Uri.encodeComponent(json.encode({
      "doctorid": "24",
      "fromdate": "",
      "todate": "",
      "datafor": "INV",
      "gCookieSessionOrgID": "48",
      "gCookieSessionDBId": "gdnew",
      "AcName": "IPD",
      "visitid": visitId,
      "gssuhid": gssuhid,
      "invid": "785",  // Include these if required
      "servid": "0",
      "status": "FillResultDtl"
    }))}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load investigation details');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      InvestigationContent(visitId: widget.visitId, gssuhid: widget.gssuhid),
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
}

class InvestigationContent extends StatelessWidget {
  final String visitId;
  final String gssuhid;

  const InvestigationContent({super.key, required this.visitId, required this.gssuhid});

  Future<Map<String, dynamic>> fetchInvestigationDetails(String visitId, String gssuhid) async {
    final url = 'https://doctorapi.medonext.com/api/DoctorAPI/GetData?JsonAppInbox=${Uri.encodeComponent(json.encode({
      "doctorid": "24",
      "fromdate": "",
      "todate": "",
      "datafor": "INV",
      "gCookieSessionOrgID": "48",
      "gCookieSessionDBId": "gdnew",
      "AcName": "IPD",
      "visitid": visitId,
      "gssuhid": gssuhid,
      "invid": "785",
      "servid": "0",
      "status": "FillResultDtl"
    }))}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(json.decode(response.body)); // Assuming the response is already decoded
    } else {
      throw Exception('Failed to load investigation details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ICU Patient: $visitId , UHID: $gssuhid',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        backgroundColor: const Color(0xffcdd8dc),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchInvestigationDetails(visitId, gssuhid),
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
                        // Implement PDF URL action here
                        // For example, you could use the `url_launcher` package to open the PDF
                        // launch(pdfUrl);
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





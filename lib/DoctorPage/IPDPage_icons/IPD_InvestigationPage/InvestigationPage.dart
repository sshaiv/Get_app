import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../MedicinePage.dart';
import '../SummaryPage.dart';
import '../VitalsPage.dart';


class IPD_InvestigationPage extends StatefulWidget {
  final String visitId;

  const IPD_InvestigationPage({super.key, required this.visitId, required String gssuhid});

  @override
  IPD_InvestigationPageState createState() => IPD_InvestigationPageState();
}

class IPD_InvestigationPageState extends State<IPD_InvestigationPage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>> fetchIPD_InvestigationDetails(String visitId) async {
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
      throw Exception('Failed to load IPD investigation details');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> 
    widgetOptions = <Widget>
    [
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
            label: 'IPD_Investigation',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.heartPulse),
            label: 'IPD_Vitals',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.pills),
            label: 'IPD_Medicine',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'IPD_Summary',
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

  Future<Map<String, dynamic>> fetchIPD_InvestigationDetails(String visitId) async {
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
      throw Exception('Failed to load IPD_investigation details');
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
  future: fetchIPD_InvestigationDetails(visitId),
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
    
    // Debugging information
    // print('Data: $data');
    // print('Items length: ${items.length}');

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





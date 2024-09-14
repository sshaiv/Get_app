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
    _investigationDetails = fetchInvestigationDetails(widget.visitId);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
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




// class InvestigationContent extends StatelessWidget {
//   final String visitId;
//
//   const InvestigationContent({super.key, required this.visitId});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ICU_Patient:$visitId', // Display visitId in the title
//             style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
//         backgroundColor: const Color(0xffcdd8dc),
//       ),
//       body: Center(
//         child: Text("Investigation Content will be displayed here"),
//       ),
//     );
//   }
// }





class InvestigationContent extends StatelessWidget {
  final String visitId;

  const InvestigationContent({super.key, required this.visitId});

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
      return json.decode(json.decode(response.body));
    } else {
      throw Exception('Failed to load investigation details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ICU_Patient: $visitId',
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

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text(item['servname'] ?? 'No name'),
                subtitle: Text('Order Date: ${item['orddate'] ?? 'No date'}'),
                trailing: IconButton(
                  icon: Icon(Icons.picture_as_pdf),
                  onPressed: () {

                    final pdfUrl = item['pdfpath'];
                    if (pdfUrl != null && pdfUrl.isNotEmpty) {

                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OPDPage extends StatelessWidget {
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
                          // child: Row(
                          //   children: [
                          //     _buildIconButton(
                          //         context, Icons.add, Colors.red, AddPage()),
                          //     _buildFontAwesomeIconButton(
                          //         context,
                          //         FontAwesomeIcons.vial,
                          //         Colors.blue,
                          //         InvestigationPage()),
                          //     _buildFontAwesomeIconButton(
                          //         context,
                          //         FontAwesomeIcons.heartPulse,
                          //         Colors.red,
                          //         VitalsPage()),
                          //     _buildFontAwesomeIconButton(
                          //         context,
                          //         FontAwesomeIcons.pills,
                          //         Colors.blue,
                          //         MedicinePage()),
                          //     _buildIconButton(context, Icons.description,
                          //         Colors.red, SummaryPage()),
                          //     _buildIconButton(context, Icons.settings,
                          //         Colors.grey, SettingsPage()),
                          //   ],
                          // ),
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

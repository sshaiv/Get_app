import 'dart:ui';
import 'package:flutter/material.dart';

class IPD_VitalsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vitals',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xffcdd8dc),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class IPD_GraphPage extends StatefulWidget {
  const IPD_GraphPage({super.key});

  @override
  State<IPD_GraphPage> createState() => _IPD_GraphPageState();
}

class _IPD_GraphPageState extends State<IPD_GraphPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Graph_page'),
      ),
    );
  }
}
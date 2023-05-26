import 'package:flutter/material.dart';

class MeansOfIdentificationPage extends StatefulWidget {
  const MeansOfIdentificationPage({super.key});

  @override
  State<MeansOfIdentificationPage> createState() =>
      _MeansOfIdentificationPageState();
}

class _MeansOfIdentificationPageState extends State<MeansOfIdentificationPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Means Of Identification Page'),
      ),
    );
  }
}

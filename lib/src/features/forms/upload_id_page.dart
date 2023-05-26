import 'package:flutter/material.dart';

class UploadIdPage extends StatefulWidget {
  const UploadIdPage({super.key});

  @override
  State<UploadIdPage> createState() => _UploadIdPageState();
}

class _UploadIdPageState extends State<UploadIdPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Upload Id Page'),
      ),
    );
  }
}

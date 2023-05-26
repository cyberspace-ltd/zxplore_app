import 'package:flutter/material.dart';

class UploadPassportPage extends StatefulWidget {
  const UploadPassportPage({super.key});

  @override
  State<UploadPassportPage> createState() => _UploadPassportPageState();
}

class _UploadPassportPageState extends State<UploadPassportPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Upload Passport Page'),
      ),
    );
  }
}

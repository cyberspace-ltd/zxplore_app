import 'package:flutter/material.dart';

class SignatoryPage extends StatefulWidget {
  const SignatoryPage({super.key});

  @override
  State<SignatoryPage> createState() => _SignatoryPageState();
}

class _SignatoryPageState extends State<SignatoryPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Signatory Page'),
      ),
    );
  }
}

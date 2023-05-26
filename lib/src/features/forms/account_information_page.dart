import 'package:flutter/material.dart';

class AccountInformationPage extends StatefulWidget {
  const AccountInformationPage({super.key});

  @override
  State<AccountInformationPage> createState() => _AccountInformationPageState();
}

class _AccountInformationPageState extends State<AccountInformationPage> {
  final _node = FocusScopeNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: const Column(
              children: [
                Text('Account Information Page'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

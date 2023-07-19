import 'package:flutter/material.dart';
import 'package:zxplore_app/src/constants/constants.dart';

class AccountInformationPage extends StatefulWidget {
  const AccountInformationPage({super.key});

  @override
  State<AccountInformationPage> createState() => _AccountInformationPageState();
}

class _AccountInformationPageState extends State<AccountInformationPage> {
  final _node = FocusScopeNode();
  final _formKey = GlobalKey<FormState>();
  String? _email;

  String? _selectedAccountType;
  final String _selectedAccFilter = "";

  final _accountHolderTypes = ['INDIVIDUAL'];
  final _riskRanks = ['HIGH', 'LOW', 'MEDIUM'];
  final _accountTypes = [savingAccount, currentAccount];

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
            child: Column(
              children: [
                const Text('Account Information Page'),
                const SizedBox(height: 24),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  autofocus: true,
                  focusNode: _node,
                  onSaved: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

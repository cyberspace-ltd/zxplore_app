import 'package:flutter/material.dart';
import 'package:zxplore_app/src/features/forms/account_information_page.dart';
import 'package:zxplore_app/src/shared/app_sizes.dart';
import 'package:zxplore_app/src/shared/primary_button.dart';

class UploadUtilityBillPage extends StatefulWidget {
  const UploadUtilityBillPage({super.key});

  @override
  State<UploadUtilityBillPage> createState() => _UploadUtilityBillPageState();
}

class _UploadUtilityBillPageState extends State<UploadUtilityBillPage> {
  Future<void> _onSubmit() async {
    if (!accountInfoFormKey.currentState!.validate()) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Upload Utility Bill Page'),
            gapH12,
            PrimaryButton(
              text: 'SUBMIT',
              onPressed: _onSubmit,
            )
          ],
        ),
      ),
    );
  }
}

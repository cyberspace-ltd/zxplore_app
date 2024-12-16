import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/submit_account_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/create_new_screen.dart';
import 'package:zxplore_app/screens/pending_drafts_requests_screen.dart';
import 'package:zxplore_app/widgets/alert_dialogs.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class ProcessFlowWidget extends ConsumerStatefulWidget {
  const ProcessFlowWidget({Key? key, required this.formIndividualData})
      : super(key: key);
  final Map<String, dynamic> formIndividualData;

  @override
  ConsumerState<ProcessFlowWidget> createState() => _ProcessFlowWidgetState();
}

class _ProcessFlowWidgetState extends ConsumerState<ProcessFlowWidget> {
  @override
  Widget build(BuildContext context) {
    return ZxploreProgress(
      inAsyncCall: ref.watch(submitAccountRequestControllerProvider).isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Process Flow'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Instructions:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _buildInstructionStep(
                'i',
                'Ensure you have completed all required fields on previous forms and tap on "Validate" to validate the status of the request.',
              ),
              SizedBox(height: 8),
              _buildInstructionStep(
                'ii',
                'Tap on "Process External" to send data you have submitted.',
              ),
              SizedBox(height: 8),
              _buildInstructionStep(
                'iii',
                'Tap on "Complete" to send data to the ADMIN.',
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => _onValidatePressed(context),
                        child: Text('Validate'),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextButton(
                        onPressed: () => _onProcessExternalPressed(context),
                        child: Text('Process External'),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextButton(
                        onPressed: () => _onCompletePressed(context),
                        child: Text('Complete'),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 

  Widget _buildInstructionStep(String stepNumber, String instruction) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$stepNumber. ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(child: Text(instruction)),
      ],
    );
  }

  Widget _buildTextButton(
      BuildContext context, String label, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(label),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: TextStyle(fontSize: 18),
      ),
    );
  }

  Future<void> _onValidatePressed(BuildContext context) async {
  
    ref
        .read(submitAccountRequestControllerProvider.notifier)
        .validateRequestForSubmission(context,
            afterSuccess: () {
      zXFlushBar(context, "Validation successful,you can now process..");
    });
  }

  void _onProcessExternalPressed(BuildContext context) {
 
    ref
        .read(submitAccountRequestControllerProvider.notifier)
        .processRequestExternal(context, 
            afterSuccess: () {
      zXFlushBar(
          context, "Processing successful,you can now complete creation..");
    });
  }

  void _onCompletePressed(BuildContext context) {
  
    ref
        .read(submitAccountRequestControllerProvider.notifier)
        .completeRequest(context, 
            afterSuccess: () {
      showErrorDialog(
        context,
        "Validation complete",
        retry: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    PendingDraftsRequestsScreen()),
          );
        },
        title: 'Success',
      );
    });
  }
}

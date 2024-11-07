import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/submit_account_request_controller.dart';
import 'package:zxplore_app/widgets/async_ui.dart';
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
    //   ref.listen<AsyncValue>(
    //   submitAccountRequestControllerProvider,
    //   (_, state) => state.showAlertDialogOnError(context,okAction: (){

    //   }),
    // );
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
              _buildInstructions(),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTextButton(context, 'Validate',()=> _onValidatePressed(context)),
                      SizedBox(height: 16),
                      _buildTextButton(context,
                          'Process External',()=> _onProcessExternalPressed(context)),
                      SizedBox(height: 16),
                      _buildTextButton(context,'Complete',()=> _onCompletePressed(context)),
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

  Widget _buildInstructions() {
    return Column(
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
      ],
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

  Widget _buildTextButton(BuildContext  context,String label, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(label),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: TextStyle(fontSize: 18),
      ),
    );
  }

  Future<void> _onValidatePressed(BuildContext  context) async {
    final ViewAccountRequestResponse? requestData =
        ViewAccountRequestResponse.fromMap(widget.formIndividualData);
    final sectionData = requestData?.data?.taxJurisdiction ?? [];
    ref
        .read(submitAccountRequestControllerProvider.notifier)
        .validateRequestForSubmission(context,RequestId: sectionData[0].reqId);
  }

  void _onProcessExternalPressed(BuildContext  context) {
    final ViewAccountRequestResponse? requestData =
        ViewAccountRequestResponse.fromMap(widget.formIndividualData);
    final sectionData = requestData?.data?.taxJurisdiction ?? [];
    ref
        .read(submitAccountRequestControllerProvider.notifier)
        .processRequestExternal(context,RequestId: sectionData[0].reqId);
  }

  void _onCompletePressed(BuildContext  context) {
    final ViewAccountRequestResponse? requestData =
        ViewAccountRequestResponse.fromMap(widget.formIndividualData);
    final sectionData = requestData?.data?.taxJurisdiction ?? [];
    ref
        .read(submitAccountRequestControllerProvider.notifier)
        .completeRequest(context,RequestId: sectionData[0].reqId);
  }
}

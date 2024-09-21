import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/edit_account_purpose.dart';
import 'package:zxplore_app/models/epma_models/get_account_purpose_response.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_account_purpose_controller.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/base_edit_screen.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_personal_info.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_funding_sources_sreen.dart';
import 'package:zxplore_app/utils/app_sizes.dart';
import 'package:zxplore_app/widgets/custom_text_field.dart';
import 'package:zxplore_app/widgets/submit_button.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class EditAccountPurposeScreen extends ConsumerStatefulWidget {
  const EditAccountPurposeScreen({super.key, this.data});
  final GetAccountPurposeToEditResponse? data;

  @override
  ConsumerState<EditAccountPurposeScreen> createState() =>
      _EditAccountPurposeScreenState();
}

class _EditAccountPurposeScreenState extends ConsumerState<EditAccountPurposeScreen> {
  final _fundingFormFormKey = GlobalKey<FormState>();

  // funding TextEditingControllers
  final TextEditingController othersController = TextEditingController();
  final TextEditingController actionFlagController = TextEditingController();

  bool salaryProcessing = false;
  bool toOtainLoan = false;
  bool businessTransactional = false;
  bool savingsInvestment = false;
  bool conductSingleTransaction = false;
  bool secutirySafeKeeping = false;
  bool accessToBankingServices = false;
  bool thirdPartyPayment = false;
  bool recieptOfInflows = false;
  bool others = false;

  @override
  void initState() {
    super.initState();
    try {
       final originalData = widget.data?.data;
       WidgetsBinding.instance.addPostFrameCallback((_){
        setState(() {
          salaryProcessing  = originalData?.salaryProcessing??false;
          toOtainLoan  = originalData?.toOtainLoan??false;
          businessTransactional  = originalData?.businessTransactional??false;
          savingsInvestment  = originalData?.savingsInvestment??false;
          conductSingleTransaction  = originalData?.conductSingleTransaction??false;
          secutirySafeKeeping  = originalData?.secutirySafeKeeping??false;
          accessToBankingServices  = originalData?.accessToBankingServices??false;
          thirdPartyPayment  = originalData?.thirdPartyPayment??false;
          recieptOfInflows  = originalData?.recieptOfInflows??false;
          others  = originalData?.others??false;
        });
       });
    } catch (e) {}
  }

  @override
  void dispose() {
    // Dispose the controllers to free up resources
    othersController.dispose();
    actionFlagController.dispose();
    super.dispose();
  }

  // Method to handle checkbox state changes
  void _handleCheckboxChange(int checkboxNumber, bool? value) {
    setState(() {
      switch (checkboxNumber) {
        case 1:
          salaryProcessing = value ?? false;
          break;
        case 2:
          toOtainLoan = value ?? false;
          break;
        case 3:
          businessTransactional = value ?? false;
          break;
        case 4:
          savingsInvestment = value ?? false;
          break;
        case 5:
          conductSingleTransaction = value ?? false;
          break;
        case 6:
          secutirySafeKeeping = value ?? false;
          break;
        case 7:
          accessToBankingServices = value ?? false;
          break;
        case 8:
          thirdPartyPayment = value ?? false;
          break;
        case 9:
          recieptOfInflows = value ?? false;
          break;
        case 10:
          others = value ?? false;
          break;
      }
    });
  }

  Future<void> _submitForm(BuildContext context) async{
    final originalData = widget.data?.data;
     await ref.read(editAccountPurposeControllerProvider.notifier).editAccountPurposeDaata(context: context,data: EditAccountPurpose(
      accessToBankingServices:accessToBankingServices,
      accountPurposesId:originalData?.accountPurposesId ,
      actionFlag:actionFlagController.text ,
      businessTransactional:businessTransactional ,
      conductSingleTransaction:conductSingleTransaction ,
      itemStage: originalData?.itemStage ,
      others: others,
      othersSpecify:othersController.text ,
      recieptOfInflows:recieptOfInflows ,
      requestId:originalData?.reqId ,
      rowVersion:originalData?.rowVersion ,
      salaryProcessing: salaryProcessing, 
      savingsInvestment: savingsInvestment,
      secutirySafeKeeping: secutirySafeKeeping,
      thirdPartyPayment:thirdPartyPayment ,
      toOtainLoan:toOtainLoan ,
     )).then((onValue){
      // AccountPurposeScreen
     });
  }

  @override
  Widget build(BuildContext context) {
    return ZxploreProgress(inAsyncCall: ref.watch(editAccountPurposeControllerProvider).isLoading
      || ref.watch(viewRequestControllerProvider).isLoading,

      child: BaseEditForm(
        title: 'Editing Account Purposes',
        widgetToGoOnCancel: FundingSourcesScreen(
          requestData: widget.data!.toJson(),
        ),
        onCancel: () {},
        
        data: widget.data?.toJson(),
        addMore: IconButton(onPressed: () {}, icon: Icon(Icons.add_box)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              // Add bottom padding to ensure content is above the keyboard
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Form(
              key: _fundingFormFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  gapH24,
                  Text(
                    'Account Purpose',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  div,
                  gapH16,
                  CheckboxListTile(
                    title: Text('To Obtain Loan'),
                    value: salaryProcessing,
                    onChanged: (value) => _handleCheckboxChange(2, value),
                  ),
                  gapH12,
      
                  CheckboxListTile(
                    title: Text('Business Transactional'),
                    value: businessTransactional,
                    onChanged: (value) => _handleCheckboxChange(3, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Savings Investment'),
                    value: savingsInvestment,
                    onChanged: (value) => _handleCheckboxChange(4, value),
                  ),
                  gapH12,
      
                  CheckboxListTile(
                    title: Text('Conduct Single Transaction'),
                    value: conductSingleTransaction,
                    onChanged: (value) => _handleCheckboxChange(5, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Secutiry Safe Keeping'),
                    value: secutirySafeKeeping,
                    onChanged: (value) => _handleCheckboxChange(6, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Access To Banking Services'),
                    value: accessToBankingServices,
                    onChanged: (value) => _handleCheckboxChange(7, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Third Party Payment'),
                    value: thirdPartyPayment,
                    onChanged: (value) => _handleCheckboxChange(8, value),
                  ),
                  gapH12,
      
                  CheckboxListTile(
                    title: Text('Reciept Of Inflows'),
                    value: recieptOfInflows,
                    onChanged: (value) => _handleCheckboxChange(9, value),
                  ),
                  gapH12,
      
                  CheckboxListTile(
                    title: Text('Others'),
                    value: others,
                    onChanged: (value) => _handleCheckboxChange(10, value),
                  ),
      
                  if (others) ...[
                    gapH12,
                    CustomTextFormField(
                      title: 'Specicy others',
                      fillColor: Colors.transparent,
                      controller: actionFlagController,
                      hint: 'Enter others',
                      inputType: TextInputType.text,
                      useDefaultErrorText: false,
                      validator: (value) {
                        return null;
                      },
                    ),
                  ],
      
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    title: 'Action Flag',
                    fillColor: Colors.transparent,
                    controller: actionFlagController,
                    hint: 'Action Flag',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      return null;
                    },
                  ),
            
                  const SizedBox(height: 24),
                  PrimaryButton(
                      onPressed: () {
                        if (!_fundingFormFormKey.currentState!.validate()) {
                          return;
                        }
                        _submitForm( context);
                      },
                      title: 'Save')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

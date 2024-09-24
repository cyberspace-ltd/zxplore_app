import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/edit_funding_sources.dart';
import 'package:zxplore_app/models/epma_models/get_funding_sources_response.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_funding_sources_controller.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/base_edit_screen.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_personal_info.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_funding_sources_sreen.dart';
import 'package:zxplore_app/utils/app_sizes.dart';
import 'package:zxplore_app/widgets/async_ui.dart';
import 'package:zxplore_app/widgets/custom_text_field.dart';
import 'package:zxplore_app/widgets/submit_button.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class EditFundingSourceScreen extends ConsumerStatefulWidget {
  const EditFundingSourceScreen({super.key, this.data});
  final GetFundingSourceToEditResponse? data;

  @override
  ConsumerState<EditFundingSourceScreen> createState() =>
      _EditFundingSourceScreenState();
}

class _EditFundingSourceScreenState extends ConsumerState<EditFundingSourceScreen> {
  final _fundingFormFormKey = GlobalKey<FormState>();

  // funding TextEditingControllers
  final TextEditingController othersController = TextEditingController();
  final TextEditingController actionFlagController = TextEditingController();

  bool commissions = false;
  bool dividends = false;
  bool businessIncome = false;
  bool personalSavings = false;
  bool trustFund = false;
  bool salary = false;
  bool familyFriends = false;
  bool rentalIncome = false;
  bool inheritanceGift = false;
  bool othersSpecify = false;
  bool others = false;

  @override
  void initState() {
    super.initState();
    try {
       final originalData = widget.data?.data;
       WidgetsBinding.instance.addPostFrameCallback((_){
        setState(() {
          commissions=originalData?.commissions??false;
          dividends=originalData?.dividends??false;
          businessIncome=originalData?.businessIncome??false;
          personalSavings=originalData?.personalSavings??false;
          trustFund=originalData?.trustFund??false;
          salary=originalData?.salary??false;
          familyFriends=originalData?.familyFriends??false;
          rentalIncome=originalData?.rentalIncome??false;
          inheritanceGift=originalData?.inheritanceGift??false;
          others=originalData?.others??false;
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
          commissions = value ?? false;
          break;
        case 2:
          dividends = value ?? false;
          break;
        case 3:
          businessIncome = value ?? false;
          break;
        case 4:
          personalSavings = value ?? false;
          break;
        case 5:
          trustFund = value ?? false;
          break;
        case 6:
          salary = value ?? false;
          break;
        case 7:
          familyFriends = value ?? false;
          break;
        case 8:
          rentalIncome = value ?? false;
          break;
        case 9:
          inheritanceGift = value ?? false;
          break;
        case 10:
          others = value ?? false;
          break;
        
      }
    });
  }

  Future<void> _submitForm(BuildContext context) async{
    final originalData = widget.data?.data;
     await ref.read(editFundingSourcesControllerProvider.notifier).editFundingSourcesData(context: context,editFundingData: EditFundingSource(
      itemStage: originalData?.itemStage??'Saved' ,
      othersSpecify:othersController.text ,
      requestId:originalData?.reqId ,
      rowVersion:originalData?.rowVersion ,
      actionFlag: actionFlagController.text,
         commissions:commissions,
          dividends:dividends,
          businessIncome:businessIncome,
          personalSavings:personalSavings,
          trustFund:trustFund,
          salary:salary,
          familyFriends:familyFriends,
          rentalIncome:rentalIncome,
          inheritanceGift:inheritanceGift,
          others:others,
          fundingSourcesId: originalData?.fundingSourcesId,

     )).then((_){

     });
  }

  @override
  Widget build(BuildContext context) {
           ref.listen<AsyncValue>(
      editFundingSourcesControllerProvider,
      (_, state) => state.showAlertDialogOnError(context, okAction: () {}),
    );

    return ZxploreProgress(
      inAsyncCall: ref.watch(editFundingSourcesControllerProvider).isLoading
      || ref.watch(viewRequestControllerProvider).isLoading,
      child: BaseEditForm(
        title: 'Editing Funding Sources',
        widgetToGoOnCancel: FundingSourcesScreen(
          requestData: widget.data!.toJson(),
        ),
        onCancel: ()=>Navigator.pop(context),
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
                    'Funding Sources',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  gapH6,
                  div,
                  gapH16,
                  CheckboxListTile(
                    title: Text('Commissions'),
                    value: commissions,
                    onChanged: (value) => _handleCheckboxChange(1, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Dividends'),
                    value: dividends,
                    onChanged: (value) => _handleCheckboxChange(2, value),
                  ),
                  gapH12,
      
                  CheckboxListTile(
                    title: Text('Business Income'),
                    value: businessIncome,
                    onChanged: (value) => _handleCheckboxChange(3, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Personal Savings'),
                    value: personalSavings,
                    onChanged: (value) => _handleCheckboxChange(4, value),
                  ),
                  gapH12,
      
                  CheckboxListTile(
                    title: Text('TrustFund'),
                    value: trustFund,
                    onChanged: (value) => _handleCheckboxChange(5, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Salary'),
                    value: salary,
                    onChanged: (value) => _handleCheckboxChange(6, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Family Friends'),
                    value: familyFriends,
                    onChanged: (value) => _handleCheckboxChange(7, value),
                  ),
                  gapH12,
                  CheckboxListTile(
                    title: Text('Rental Income'),
                    value: rentalIncome,
                    onChanged: (value) => _handleCheckboxChange(8, value),
                  ),
                  gapH12,
      
                  CheckboxListTile(
                    title: Text('Inheritance/Gift'),
                    value: inheritanceGift,
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
      
                  // const SizedBox(height: 16),
                  // CustomTextFormField(
                  //   title: 'Action Flag',
                  //   fillColor: Colors.transparent,
                  //   controller: actionFlagController,
                  //   hint: 'Action Flag',
                  //   inputType: TextInputType.text,
                  //   useDefaultErrorText: false,
                  //   validator: (value) {
                  //        if (value.toString().isEmpty) {
                  //       return 'Action flag  is required';
                  //     }
                  //     return null;
                  //   },
                  // ),
            
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

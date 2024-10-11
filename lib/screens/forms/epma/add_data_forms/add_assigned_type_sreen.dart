import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/models/epma_models/get_assigned_account_to_edit_response.dart';
import 'package:zxplore_app/models/epma_models/meta/account_series_response.dart';
import 'package:zxplore_app/models/epma_models/meta/account_types.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_assigned_account_controller.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/meta/get_account_series.dart';
import 'package:zxplore_app/screens/controllers/meta/get_account_types.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/base_edit_screen.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_personal_info.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_assigned_type_sreen.dart';
import 'package:zxplore_app/utils/app_sizes.dart';
import 'package:zxplore_app/widgets/async_ui.dart';
import 'package:zxplore_app/widgets/custom_text_field.dart';
import 'package:zxplore_app/widgets/submit_button.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class AddAssignedAccount extends ConsumerStatefulWidget {
  const AddAssignedAccount({super.key, this.requestId});
  final String? requestId;

  @override
  ConsumerState<AddAssignedAccount> createState() => _AddAssignedAccountState();
}

class _AddAssignedAccountState extends ConsumerState<AddAssignedAccount> {
  final _assignedAccountEditFormKey = GlobalKey<FormState>();

  // Individual TextEditingControllers
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController accountClassController = TextEditingController();
  final TextEditingController accountTypeController = TextEditingController();
  final TextEditingController accountNoController = TextEditingController();

  AccountSeriesDatum? selectedAccountSeriesDatumItem;
  String? selectedaccountSeries;
  String? selectedaccountSeriesName;

 AccountTypesDatum? accountTypeItemValue;
  String? accountTypeValue;
  String? accountTypeName;

  @override
  void dispose() {
    // Dispose the controllers to free up resources
    accountNameController.dispose();
    accountClassController.dispose();
    accountTypeController.dispose();
    accountNoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
 
  }

  void _submitForm(BuildContext context) {
    final data = GenerateAssignedAccount(
        assignedAcctId: 0,
        requestId: widget.requestId,
        accountName:accountNameController.text,
        accountClass: accountClassController.text,
        accountType: accountTypeController.text,
        recon: '0',
        actionFlag: 'A',
     );

    ref.read(editAssignedAccountControllerProvider.notifier)
        .addAssignedAccount(data: data, context: context);
  }

  @override
  Widget build(BuildContext context) {

      ref.listen<AsyncValue>(
      editAssignedAccountControllerProvider,
      (_, state) => state.showAlertDialogOnError(context, okAction: () {},errorMsg: state.error),
    );
    return ZxploreProgress(
      inAsyncCall: ref.watch(editAssignedAccountControllerProvider).isLoading ||
          ref.watch(viewRequestControllerProvider).isLoading,
      child: BaseEditForm(
        title: 'Add/Generate Account',
        widgetToGoOnCancel: ViewAssignedAccountScreen(formIndividualData: ref.read(activelyViewedRequestProvider)!.toMap(),),
        onCancel: () =>Navigator.pop(context),
        data: {},
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
              key: _assignedAccountEditFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  gapH24,
                  Text(
                    'Assigned Account',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                   gapH16,
                  div,
                  gapH16,
                  CustomTextFormField(
                    title: 'Account Name ',
                    fillColor: Colors.transparent,
                    controller: accountNameController,
                    hint: 'Enter Account Name',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Account Name is  required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),



              gapH32,
              Row(
                children: [
                  Text(
                    'Document Type',
                    overflow: TextOverflow.fade,
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              gapH12,
              Consumer(
                builder: (context, ref, child) {
                  return ref.watch(getAccountTypesProvider).when(
                      data: (data) => (data != null && data.isNotEmpty == true)
                          ? DropdownButtonHideUnderline(
                              child: DropdownButton2<AccountTypesDatum>(
                                isExpanded: true,
                                hint: Text(
                                  'Select Document Type',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: ZxplorePrimaryColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                items: data
                                    .map<DropdownMenuItem<AccountTypesDatum>>(
                                        (AccountTypesDatum item) =>
                                            DropdownMenuItem<AccountTypesDatum>(
                                              value: item,
                                              child: Text(
                                                item.accountTypeName??'-',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: ZxplorePrimaryColor,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                    .toList(),
                                value: accountTypeItemValue,
                                onChanged: (AccountTypesDatum? newValue) {
                                  setState(() {
                                    accountTypeItemValue = newValue;
                                    accountTypeValue =
                                        newValue?.accountTypeValue;
                                    accountTypeName =
                                        newValue?.accountTypeName;
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 60,
                                  // width: 160,
                                  padding:
                                      const EdgeInsets.only(left: 14, right: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: ZxplorePrimaryColor.withOpacity(0.6),
                                    ),
                                  ),
                                  elevation: 0,
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    CupertinoIcons.chevron_down,
                                  ),
                                  iconSize: 14,
                                  iconEnabledColor: ZxplorePrimaryColor,
                                  iconDisabledColor: Colors.grey,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                  // width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  // offset: const Offset(0, 0),
                                  scrollbarTheme: const ScrollbarThemeData(
                                    radius: Radius.circular(40),
                                    thickness: WidgetStatePropertyAll<double>(6),
                                    thumbVisibility:
                                        WidgetStatePropertyAll<bool>(true),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      error: (e, s) => const SizedBox.shrink(),
                      loading: () => gapH64);
                },
              ),
              gapH12,
                  CustomTextFormField(
                    title: 'Account Class',
                    fillColor: Colors.transparent,
                    controller: accountClassController,
                    hint: 'Enter Class',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Account Class is  required';
                      }
                      return null;
                    },
                  ),
                  if (widget.requestId != null &&
                      widget.requestId != null) ...[
                    Text(
                      'Account Series',
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    const SizedBox(height: 6),
                    Consumer(
                      builder: (context, ref, child) {
                        return ref
                            .watch(getAccountSeriesProvider(
                                widget.requestId,
                                widget.requestId))
                            .when(
                              data: (data) => (data != null &&
                                      data.isNotEmpty == true)
                                  ? DropdownButtonHideUnderline(
                                      child: DropdownButton2<AccountSeriesDatum>(
                                        isExpanded: true,
                                        hint: Text(
                                          'Select series',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.normal,
                                            color: ZxplorePrimaryColor,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        items: data
                                            .map<
                                                DropdownMenuItem<
                                                    AccountSeriesDatum>>((item) =>
                                                DropdownMenuItem<
                                                    AccountSeriesDatum>(
                                                  value: item,
                                                  child: Text(
                                                    '${item.accountSeriesName}',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: ZxplorePrimaryColor,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ))
                                            .toList(),
                                        value: selectedAccountSeriesDatumItem,
                                        onChanged:
                                            (AccountSeriesDatum? newValue) {
                                          setState(() {
                                            /// Set selected item params
                                            selectedAccountSeriesDatumItem =
                                                newValue;
                                            selectedaccountSeries =
                                                newValue?.accountSeries;
                                            selectedaccountSeriesName =
                                                newValue?.accountSeriesName;
                                          });
                                        },
                                        buttonStyleData: ButtonStyleData(
                                          height: 60,
                                          // width: 160,
                                          padding: const EdgeInsets.only(
                                              left: 0, right: 14),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            border: Border.all(
                                              color: ZxplorePrimaryColor,
                                            ),
                                          ),
                                          elevation: 0,
                                        ),
                                        iconStyleData: const IconStyleData(
                                          icon: Icon(
                                            CupertinoIcons.chevron_down,
                                          ),
                                          iconSize: 14,
                                          iconEnabledColor: ZxplorePrimaryColor,
                                          iconDisabledColor: Colors.grey,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          maxHeight: 200,
                                          // width: 200,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                          ),
                                          // offset: const Offset(0, 0),
                                          scrollbarTheme:
                                              const ScrollbarThemeData(
                                            radius: Radius.circular(40),
                                            thickness:
                                                WidgetStatePropertyAll<double>(6),
                                            thumbVisibility:
                                                WidgetStatePropertyAll<bool>(
                                                    true),
                                          ),
                                        ),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          height: 40,
                                          padding: EdgeInsets.only(
                                              left: 14, right: 14),
                                        ),
                                      ),
                                    )
                                  : TextButton(
                                      onPressed: () => ref.invalidate(
                                          getAccountSeriesProvider(
                                              widget.requestId,
                                              widget.requestId)),
                                      child: Text('Empty data, Tap to retry')),
                              error: (e, s) => GestureDetector(
                                  onTap: () => ref.invalidate(
                                      getAccountSeriesProvider(
                                          widget.requestId,
                                          widget.requestId)),
                                  child: const Text(
                                    'An error occured',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              loading: () => SizedBox(height: 16.0),
                            );
                      },
                    ),
                  ],
                  const SizedBox(height: 24),
                  PrimaryButton(
                      onPressed: () {
                        if (!_assignedAccountEditFormKey.currentState!
                            .validate()) {
                          return;
                        }
      
                        /// perform trn if all is well
                        _submitForm(context);
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

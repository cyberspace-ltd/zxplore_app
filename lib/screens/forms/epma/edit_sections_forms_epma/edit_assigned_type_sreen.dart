import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/models/epma_models/get_assigned_account_to_edit_response.dart';
import 'package:zxplore_app/models/epma_models/meta/account_series_response.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_assigned_account_controller.dart';
import 'package:zxplore_app/screens/controllers/meta/get_account_series.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/base_edit_screen.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_personal_info.dart';
import 'package:zxplore_app/utils/app_sizes.dart';
import 'package:zxplore_app/widgets/custom_text_field.dart';
import 'package:zxplore_app/widgets/submit_button.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class EditAssignedAccout extends ConsumerStatefulWidget {
  const EditAssignedAccout({super.key, this.data});
  final GetAssignedAccountToEditResponse? data;

  @override
  ConsumerState<EditAssignedAccout> createState() => _EditAssignedAccoutState();
}

class _EditAssignedAccoutState extends ConsumerState<EditAssignedAccout> {
  final _assignedAccountEditFormKey = GlobalKey<FormState>();

  // Individual TextEditingControllers
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController accountClassController = TextEditingController();
  final TextEditingController accountTypeController = TextEditingController();
  final TextEditingController accountNoController = TextEditingController();

  AccountSeriesDatum? selectedAccountSeriesDatumItem;
  String? selectedaccountSeries;
  String? selectedaccountSeriesName;

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
    final userData = widget.data;
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      accountClassController.text = userData?.data?.accountClass ?? '';
      accountNameController.text = userData?.data?.accountName ?? '';
      accountTypeController.text = userData?.data?.accountType ?? '';
    });
  }

  void _submitForm(BuildContext context) {
    final userData = widget.data?.data;
    final data = AssignedAccountToEditData(
        assignedAcctId: userData?.assignedAcctId,
        reqId: userData?.reqId,
        itemStage: userData?.itemStage,
        accountName: userData?.accountName,
        accountClass: accountClassController.text,
        accountType: accountTypeController.text,
        accountNo: userData?.accountNo,
        recon: userData?.recon,
        actionFlag: userData?.actionFlag,
        isNewRequest: userData?.isNewRequest);

    ref
        .read(editAssignedAccountControllerProvider.notifier)
        .editAssignedAAccount(data: data, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return ZxploreProgress(
      inAsyncCall: ref.watch(editAssignedAccountControllerProvider).isLoading ||
          ref.watch(viewRequestControllerProvider).isLoading,
      child: BaseEditForm(
        title: 'Editing Assigned Accounts',
        widgetToGoOnCancel: Container(),
        onCancel: () {},
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
                  if (widget.data?.data?.reqId != null &&
                      widget.data?.data?.accountType != null) ...[
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
                                widget.data?.data?.reqId,
                                widget.data?.data?.accountType))
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
                                              widget.data?.data?.reqId,
                                              widget.data?.data?.accountType)),
                                      child: Text('Empty data, Tap to retry')),
                              error: (e, s) => GestureDetector(
                                  onTap: () => ref.invalidate(
                                      getAccountSeriesProvider(
                                          widget.data?.data?.reqId,
                                          widget.data?.data?.accountType)),
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

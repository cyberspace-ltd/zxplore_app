import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/models/epma_models/meta/gender_response.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/create_account_controller.dart';
import 'package:zxplore_app/screens/controllers/meta/gender.dart';
import 'package:zxplore_app/widgets/custom_text_field.dart';
import 'package:zxplore_app/widgets/submit_button.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:zxplore_app/models/epma_models/login_modes_response.dart';


///CreateNewAccountScreen new account request primarily usinngthe EPMA service
class CreateNewAccountScreen extends ConsumerStatefulWidget {
  const CreateNewAccountScreen({super.key});

  @override
  ConsumerState<CreateNewAccountScreen> createState() =>
      _CreateNewAccountScreenState();
}

class _CreateNewAccountScreenState
    extends ConsumerState<CreateNewAccountScreen> {
  final creatFrmKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final otherNameController = TextEditingController();
  final idIssueAuthorityController = TextEditingController();
  final identificationNoController = TextEditingController();
  final niaVerificationNoController = TextEditingController();
  final iddCodeController = TextEditingController();
  final telNoController = TextEditingController();
  final mobileNoController = TextEditingController();
  final residentialAddressController = TextEditingController();
  final residentialAddressController2 = TextEditingController();
  final cityController = TextEditingController();
  // String?  selectedGenderCode;
  String? selectedGenderCode;
  String? selectedGenderName;
  String? selectedIdentificationTypeId;
  String? selectedCountryCode;
  String? selectedCitizenshipCode;

  GendersDatum? selectedGenderItem;

  @override
  Widget build(BuildContext context) {
    return ZxploreProgress(
      inAsyncCall: ref.watch(createAccountControllerProvider).isLoading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ZxplorePrimaryColor,
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: const Text(
            'Create account',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(onPressed: (){
              ref.invalidate(getGenderProvider);
            }, icon: Icon(Icons.refresh))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              // Add bottom padding to ensure content is above the keyboard
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Form(
              key: creatFrmKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextFormField(
                    title: 'First name',
                    fillColor: Colors.transparent,
                    controller: firstNameController,
                    hint: 'Enter first name',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'first name is  required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    title: 'Last name',
                    fillColor: Colors.transparent,
                    controller: lastNameController,
                    hint: 'Enter last name',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'last name is  required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    title: 'Other name',
                    fillColor: Colors.transparent,
                    controller: otherNameController,
                    hint: 'Enter other name',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'other name is  required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                     Text(
                        'Gender',
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                  const SizedBox(height: 6),
                  Consumer(
                    builder: (context, ref, child) {
                      return ref.watch(getGenderProvider).when(
                            data: (data) =>
                                (data != null && data.isNotEmpty == true)
                                    ? DropdownButtonHideUnderline(
                                    child: DropdownButton2<GendersDatum>(
                                      isExpanded: true,
                                      hint: Text(
                                        'Select preferred Login',
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
                                                      GendersDatum>>(
                                              ( item) =>
                                                  DropdownMenuItem<
                                                      GendersDatum>(
                                                    value: item,
                                                    child: Text(
                                                      item.genderName ?? '',
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            ZxplorePrimaryColor,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ))
                                          .toList(),
                                      value: selectedGenderItem,
                                      onChanged: (GendersDatum? newValue) {
                                        setState(() {
                                          /// Set selected item params
                                          selectedGenderItem = newValue;
                                          selectedGenderCode =
                                              newValue?.genderCode;
                                          selectedGenderName =
                                              newValue?.genderName;
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
                               
                                    : Text('empty gender'),
                            error: (e, s) => GestureDetector(
                                onTap: () => ref.invalidate(getGenderProvider),
                                child: const Text(
                                  'An error occured fetch login modes.Tap to refresh',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            loading: () => SizedBox(height: 16.0),
                          );
                    },
                  ),
                  const SizedBox(height: 8),
                  const Divider(
                    height: 16,
                    color: Color.fromARGB(255, 169, 189, 201),
                    thickness: 0.5,
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    title: 'Telephone Number',
                    fillColor: Colors.transparent,
                    controller: telNoController,
                    hint: 'Enter telephone number',
                    inputType: TextInputType.phone,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Telephone Number is  required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    title: 'Mobile Number',
                    fillColor: Colors.transparent,
                    controller: mobileNoController,
                    hint: 'Enter mobile number',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      // if (value.toString().isEmpty) {
                      //   return 'other name is  required';
                      // }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    title: 'Address',
                    fillColor: Colors.transparent,
                    controller: residentialAddressController,
                    hint: 'Enter adress',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Address is  required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    title: 'Other Address',
                    fillColor: Colors.transparent,
                    controller: residentialAddressController2,
                    hint: 'Enter other adress',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      // if (value.toString().isEmpty) {
                      //   return 'Address is  required';
                      // }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    title: 'City  ',
                    fillColor: Colors.transparent,
                    controller: residentialAddressController2,
                    hint: 'Enter city',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'City is  required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  const Divider(
                    height: 16,
                    color: Color.fromARGB(255, 169, 189, 201),
                    thickness: 0.5,
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    title: 'ID Issuer',
                    fillColor: Colors.transparent,
                    controller: idIssueAuthorityController,
                    hint: 'Enter ID Issuer',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'ID Issuer is  required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    title: 'ID Number',
                    fillColor: Colors.transparent,
                    controller: identificationNoController,
                    hint: 'Enter ID Number',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'ID Number is  required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    title: 'NIA Number',
                    fillColor: Colors.transparent,
                    controller: niaVerificationNoController,
                    hint: 'Enter NIA number',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      // if (value.toString().isEmpty) {
                      //   return 'other name is  required';
                      // }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    title: 'IDD Code',
                    fillColor: Colors.transparent,
                    controller: iddCodeController,
                    hint: 'Enter IDD code',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'IDD Code is  required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                      onPressed: () {
                        if (!creatFrmKey.currentState!.validate()) {
                          return;
                        }
                      },
                      title: 'Create Account')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

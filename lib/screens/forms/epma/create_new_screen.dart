import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/create_account_controller.dart';
import 'package:zxplore_app/widgets/custom_text_field.dart';
import 'package:zxplore_app/widgets/submit_button.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

///CreateNewAccountScreen new account request primarily usinngthe EPMA service
class CreateNewAccountScreen extends ConsumerStatefulWidget {
  const CreateNewAccountScreen({super.key});

  @override
  ConsumerState<CreateNewAccountScreen> createState() => _CreateNewAccountScreenState();
}

class _CreateNewAccountScreenState extends ConsumerState<CreateNewAccountScreen> {
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
  String?  selectedGenderCode;
  String?  selectedIdentificationTypeId;
  String?  selectedCountryCode;
  String?  selectedCitizenshipCode;

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
                        const SizedBox(height: 8),
                     const Divider(
                                height: 16,
                                color:Color.fromARGB(255, 169, 189, 201),
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
                                color:Color.fromARGB(255, 169, 189, 201),
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

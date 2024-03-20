import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/src/api/dio_error_handler.dart';
import 'package:zxplore_app/src/router/router.dart';
import 'package:zxplore_app/src/shared/alert_dialogs.dart';
import 'package:zxplore_app/src/shared/app_exception.dart';
import 'package:zxplore_app/src/shared/app_sizes.dart';
import 'package:zxplore_app/src/shared/providers.dart';
import 'package:zxplore_app/src/shared/secondary_button.dart';
import 'package:zxplore_app/src/utils/zxplore_crypto_helper.dart';

final personalInfoFormKey = GlobalKey<FormState>(debugLabel: 'personalInfo');

class PersonalInformationPage extends ConsumerStatefulWidget {
  const PersonalInformationPage({super.key});

  @override
  ConsumerState<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState
    extends ConsumerState<PersonalInformationPage> {
  final _titles = [
    'Miss',
    'Dr.',
    'Prof.',
    'Rev.',
    'Chief',
    'Mr.',
    'Barrister',
    'Pastor',
    'Otunba',
    'Mrs',
    'Engr',
    'Alhaji',
    'Alhaja',
    'Mr & Mrs',
    'Dr. & Mrs.',
    'Hon Just.',
    'Hon'
  ];

  String? _selectedTitle;
  String? _selectedCountry;
  String? _selectedState;
  DateTime? _dateOfBirth;
  bool isFetchingBvn = false;
  bool bvnVerified = false;

  late final TextEditingController _bvnController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _surnameController;
  late final TextEditingController _middleNameController;
  late final TextEditingController _mothersMaidenNameController;

  final initialDate = DateTime.now().subtract(const Duration(days: 365 * 14));
  final firstDate = DateTime.now().subtract(const Duration(days: 365 * 80));
  final lastDate = DateTime.now().subtract(const Duration(days: 365 * 13));

  Future<void> verifyBvn(String bvn) async {
    try {
      setState(() {
        isFetchingBvn = true;
      });
      final response =
          await ref.read(accountsRepositoryProvider).verifyBvn(bvn);
      if (response.bvn == null) {
        throw AppException('BVN not found');
      } else {
        _firstNameController.text = response.firstName != null
            ? CryptoHelper.decrypt(response.firstName!)
            : '';
        _middleNameController.text = response.middleName != null
            ? CryptoHelper.decrypt(response.middleName!)
            : '';
        _surnameController.text = response.lastName != null
            ? CryptoHelper.decrypt(response.lastName!)
            : '';
        _dateOfBirth = response.dateOfBirth != null
            ? DateTime.tryParse(CryptoHelper.decrypt(response.dateOfBirth!))
            : null;
        _selectedCountry = response.nationality;
        _selectedState = response.stateOfOrigin;
      }
      if (mounted) {
        setState(() {
          bvnVerified = true;
        });
      }
    } catch (e) {
      if (mounted) {
        showExceptionAlertDialog(
          context: rootNavigatorKey.currentState!.context,
          title: 'Operation failed',
          exception: e,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isFetchingBvn = false;
        });
      }
    }
  }

  Future<List<String>> fetchCountries() async {
    try {
      return await ref.read(accountsRepositoryProvider).getCountries();
    } catch (err, _) {
      throw AppException('${err.toString()}. Please try again');
    }
  }

  Future<List<String>> fetchStates() async {
    try {
      return await ref.read(accountsRepositoryProvider).getStates();
    } catch (err, _) {
      throw AppException('${getErrorMessage(err)}. Please try again');
    }
  }

  @override
  void initState() {
    super.initState();
    _bvnController = TextEditingController()
      ..addListener(() {
        if (_bvnController.text.length == 11) {
          verifyBvn(_bvnController.text);
        }
      });
    _firstNameController = TextEditingController();
    _surnameController = TextEditingController();
    _middleNameController = TextEditingController();
    _mothersMaidenNameController = TextEditingController();
  }

  @override
  void dispose() {
    _bvnController.dispose();
    _firstNameController.dispose();
    _surnameController.dispose();
    _middleNameController.dispose();
    _mothersMaidenNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: personalInfoFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _bvnController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Bank Verification Number (BVN)',
                      helperText: "* Required",
                      isDense: true,
                    ),
                    maxLength: 11,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter you BVN';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      children: [
                        const Spacer(),
                        Expanded(
                          child: SecondaryButton(
                            text: 'VERIFY BVN',
                            isLoading: isFetchingBvn,
                            onPressed: () {
                              if (_bvnController.text.length == 11) {
                                verifyBvn(_bvnController.text);
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  gapH16,
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Select Title',
                      helperText: "* Required",
                    ),
                    value: _selectedTitle,
                    isDense: true,
                    items: _titles.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedTitle = value;
                      });
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please choose a title';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  TextFormField(
                    controller: _surnameController,
                    decoration: InputDecoration(
                      labelText: 'Enter Last Name',
                      helperText: "* Required",
                      isDense: true,
                      enabled: !bvnVerified,
                    ),
                    maxLength: 40,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    keyboardType: TextInputType.name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter you last name';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: 'Enter First Name',
                      helperText: "* Required",
                      isDense: true,
                      enabled: !bvnVerified,
                    ),
                    maxLength: 40,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    keyboardType: TextInputType.name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter you first name';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  TextFormField(
                    controller: _middleNameController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Middle Name',
                      isDense: true,
                    ),
                    keyboardType: TextInputType.name,
                  ),
                  gapH16,
                  TextFormField(
                    controller: _mothersMaidenNameController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Mother Maiden Name',
                      helperText: "* Required",
                      isDense: true,
                    ),
                    maxLength: 40,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    keyboardType: TextInputType.name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter you first name';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      InputDatePickerFormField(
                        firstDate: firstDate,
                        lastDate: lastDate,
                        initialDate: _dateOfBirth,
                        errorInvalidText: 'Please enter a valid date of birth',
                        fieldLabelText: 'Date of Issue',
                        fieldHintText: 'M/D/YYYY',
                        keyboardType: TextInputType.datetime,
                        onDateSubmitted: (DateTime value) {
                          setState(() {
                            _dateOfBirth = value;
                          });
                        },
                        onDateSaved: (value) {
                          setState(() {
                            _dateOfBirth = value;
                          });
                        },
                      ),
                      IconButton(
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: initialDate,
                            firstDate: firstDate,
                            lastDate: lastDate,
                          );

                          if (date != null) {
                            setState(() {
                              _dateOfBirth = date;
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.calendar_month,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '* Required',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: Colors.grey.shade600),
                    ),
                  ),
                  gapH12,
                  DropdownSearch<String>(
                    popupProps: PopupProps.menu(
                      showSearchBox: true,
                      emptyBuilder: (context, string) => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Failed to fetch countries. Please try again',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Select Country Of Origin',
                        helperText: '* Required',
                        isDense: true,
                        enabled: !bvnVerified,
                      ),
                    ),
                    asyncItems: (string) => fetchCountries(),
                    selectedItem: _selectedCountry,
                    itemAsString: (String s) => s,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedCountry = value;
                      });
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null) {
                        return 'Please choose a country';
                      } else {
                        return null;
                      }
                    },
                  ),
                  gapH16,
                  DropdownSearch<String>(
                    popupProps: PopupProps.menu(
                      showSearchBox: true,
                      emptyBuilder: (context, string) => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Failed to fetch states. Please try again',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Select State of Origin',
                        helperText: '* Required',
                        isDense: true,
                        enabled: !bvnVerified,
                      ),
                    ),
                    asyncItems: (string) => fetchStates(),
                    selectedItem: _selectedState,
                    itemAsString: (String s) => s,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedState = value;
                      });
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null) {
                        return 'Please choose a state';
                      } else {
                        return null;
                      }
                    },
                  ),
                  gapH16,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

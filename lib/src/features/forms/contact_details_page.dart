import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/src/shared/app_exception.dart';
import 'package:zxplore_app/src/shared/app_sizes.dart';
import 'package:zxplore_app/src/shared/providers.dart';

final contactDetailsFormKey = GlobalKey<FormState>(debugLabel: 'contact');

class ContactDetailsPage extends ConsumerStatefulWidget {
  const ContactDetailsPage({super.key});

  @override
  ConsumerState<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends ConsumerState<ContactDetailsPage> {
  final _genders = ['MALE', 'FEMALE'];
  final _maritalStatus = ['SINGLE', 'MARRIED', 'SEPERATED', 'DIVORCED'];

  String? _selectedGender;
  String? _selectedMaritalStatus;
  String? _selectedOccupation;
  String? _selectedCountry;
  String? _selectedState;
  String? _selectedCity;

  late final TextEditingController _genderController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _nextOfKinController;
  late final TextEditingController _address1Controller;
  late final TextEditingController _address2Controller;

  @override
  void initState() {
    super.initState();
    _genderController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _nextOfKinController = TextEditingController();
    _address1Controller = TextEditingController();
    _address2Controller = TextEditingController();
  }

  @override
  void dispose() {
    _genderController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nextOfKinController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    super.dispose();
  }

  Future<List<String>> fetchOccupations() async {
    try {
      return await ref.read(accountsRepositoryProvider).getOccupations();
    } catch (err, _) {
      throw AppException('${err.toString()}. Please try again');
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
      throw AppException('${err.toString()}. Please try again');
    }
  }

  Future<List<String>> fetchCities() async {
    try {
      return await ref.read(accountsRepositoryProvider).getCities();
    } catch (err, _) {
      throw AppException('${err.toString()}. Please try again');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: contactDetailsFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      helperText: "* Required",
                      isDense: true,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 40,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      helperText: "* Required",
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 11,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phone number';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  TextFormField(
                    controller: _nextOfKinController,
                    decoration: const InputDecoration(
                      labelText: 'Next Of Kin',
                      helperText: "* Required",
                      isDense: true,
                    ),
                    maxLength: 40,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  TextFormField(
                    controller: _address1Controller,
                    decoration: const InputDecoration(
                      labelText: 'Address 1',
                      helperText: "* Required",
                      isDense: true,
                    ),
                    maxLength: 40,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    keyboardType: TextInputType.streetAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an address';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  TextFormField(
                    controller: _address2Controller,
                    decoration: const InputDecoration(
                      labelText: 'Address 2',
                      helperText: "* Required",
                      isDense: true,
                    ),
                    maxLength: 40,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    keyboardType: TextInputType.streetAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an address';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Select Gender',
                      helperText: "* Required",
                    ),
                    value: _selectedGender,
                    isDense: true,
                    items: _genders.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please choose an account type';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Selected Marital Status',
                      helperText: "* Required",
                    ),
                    value: _selectedMaritalStatus,
                    isDense: true,
                    items: _maritalStatus.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedMaritalStatus = value;
                      });
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please choose an account type';
                      }
                      return null;
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
                            'Failed to fetch occupations. Please try again',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Select Occupation',
                        helperText: '* Required',
                        isDense: true,
                      ),
                    ),
                    asyncItems: (string) => fetchOccupations(),
                    selectedItem: _selectedOccupation,
                    itemAsString: (String s) => s,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedOccupation = value;
                      });
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null) {
                        return 'Please choose an occupation';
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
                            'Failed to fetch countries. Please try again',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Select Country Of Residence',
                        helperText: '* Required',
                        isDense: true,
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
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Select State of Residence',
                        helperText: '* Required',
                        isDense: true,
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
                  DropdownSearch<String>(
                    popupProps: PopupProps.menu(
                      showSearchBox: true,
                      emptyBuilder: (context, string) => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Failed to fetch cities. Please try again',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Select City of Residence',
                        helperText: '* Required',
                        isDense: true,
                      ),
                    ),
                    asyncItems: (string) => fetchCities(),
                    selectedItem: _selectedCity,
                    itemAsString: (String s) => s,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedCity = value;
                      });
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null) {
                        return 'Please choose a city';
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

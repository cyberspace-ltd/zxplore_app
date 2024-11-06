import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/models/epma_models/create_account.dart';
import 'package:zxplore_app/models/epma_models/meta/country_response.dart';
import 'package:zxplore_app/models/epma_models/meta/gender_response.dart';
import 'package:zxplore_app/models/epma_models/meta/identification_types.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/create_account_controller.dart';
import 'package:zxplore_app/screens/controllers/meta/countries.dart';
import 'package:zxplore_app/screens/controllers/meta/gender.dart';
import 'package:zxplore_app/screens/controllers/meta/identification_types.dart';
import 'package:zxplore_app/screens/home_screen.dart';
import 'package:zxplore_app/utils/flushbar_helper.dart';
import 'package:zxplore_app/widgets/async_ui.dart';
import 'package:zxplore_app/widgets/custom_text_field.dart';
import 'package:zxplore_app/widgets/submit_button.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';

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
  final dateExpireController = TextEditingController();
  final dobController = TextEditingController();
  final datedIssuedController = TextEditingController();
  /// country
  final countryValueListenable = ValueNotifier<CountryDatum?>(null);
  final TextEditingController? searchCountryController = TextEditingController();
    
  GendersDatum? selectedGenderItem;
  String? selectedGenderCode;
  String? selectedGenderName;

  IdentificationTypesDatum? selectedIdType;
  int? selectedIdentificationTypeCode;
  String? selectedIdentificationTypeName;

  CountryDatum? selectedCountry;
  String? selectedCountryCode;
  String? selectedCountryName;
  String? selectedCitizenshipCode;
  String? dob;
  String? datedIssued;
  String? dateExpire;
  DateTime? dobInit = DateTime.now();
  final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');
  final DateFormat sdateFormatter = DateFormat('yyyy/mm/dd');
  String dobFormattedDate = 'dd/mm/yyy';
  String sDobFormattedDate = 'yyyy/mm/dd';
  // DateTime? _selectedDate;

  @override
  void dispose() {
    // Dispose the controllers to free up resources
    countryValueListenable.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    otherNameController.dispose();
    idIssueAuthorityController.dispose();
    identificationNoController.dispose();
    niaVerificationNoController.dispose();
    iddCodeController.dispose();
    telNoController.dispose();
    mobileNoController.dispose();
    residentialAddressController.dispose();
    cityController.dispose();
    dobController.dispose();
    dateExpireController.dispose();
    datedIssuedController.dispose();
    residentialAddressController2.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

        // /check  for  errors here
    ref.listen<AsyncValue>(
      createAccountControllerProvider,
      (_, state) => state.showAlertDialogOnError(context,
          okAction: () {}, errorMsg: state.error),
    );
    return ZxploreProgress(
      inAsyncCall: ref.watch(createAccountControllerProvider).isLoading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ZxplorePrimaryColor,
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: const Text(
            'Create Account',
            style: TextStyle(color: Colors.white),
          ),
          // actions: [
          //   IconButton(onPressed: (){
          //     ref.invalidate(getGenderProvider);
          //   }, icon: Icon(Icons.refresh))
          // ],
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
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    onTap: () {
                      _showDatePicker(context, dateCategory: 'DOB');
                    },
                    title: 'Date Of Birth',
                    readOnly: true,
                    showCursor: false,
                    suffixIcon: Icon(
                      Icons.calendar_today_rounded,
                      color: ZxplorePrimaryColor.withOpacity(.5),
                    ),
                    showDropDownSuffixIcon: true,
                    fillColor: Colors.transparent,
                    controller: dobController,
                    hint: 'Date Of Birth ',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Date Of Birth is required';
                      } else if (value == 'dd-mm-yyyy') {
                        return 'Enter a valid date';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Gender',
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
                      return ref.watch(getGenderProvider).when(
                            data: (data) => (data != null &&
                                    data.isNotEmpty == true)
                                ? DropdownButtonHideUnderline(
                                    child: DropdownButton2<GendersDatum>(
                                      isExpanded: true,
                                      hint: Text(
                                        'Select gender',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal,
                                          color: ZxplorePrimaryColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      items: data
                                          .map<DropdownMenuItem<GendersDatum>>(
                                              (item) => DropdownMenuItem<
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
                  const SizedBox(height: 16),
                  Text(
                    'Country',
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
                      return ref.watch(getCountriesProvider).when(
                            data: (data) => (data != null &&
                                    data.isNotEmpty == true)
                                ? DropdownButtonHideUnderline(
                                    child: DropdownButton2<CountryDatum>(
                                      isExpanded: true,
                                      hint: Text(
                                        'Select country',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal,
                                          color: ZxplorePrimaryColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      dropdownSearchData: DropdownSearchData<
                                              CountryDatum>(
                                          searchInnerWidgetHeight: 150,
                                          searchInnerWidget: Container(
                                            height: 50,
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                              bottom: 4,
                                              right: 8,
                                              left: 8,
                                            ),
                                            child: TextFormField(
                                              expands: true,
                                              maxLines: null,
                                              controller:
                                                  searchCountryController,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 8,
                                                ),
                                                hintText:
                                                    'Search for country...',
                                                hintStyle: const TextStyle(
                                                    fontSize: 12),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            ),
                                          ),
                                          searchController:
                                              searchCountryController,
                                          searchMatchFn: (item, searchValue) {
                                            return item.value!.countryName!.toUpperCase()
                                            .startsWith(searchValue.toUpperCase());
                                          }),
                                      onMenuStateChange: (isOpen) {
                                        if (!isOpen) {
                                          searchCountryController?.clear();
                                        }
                                      },
                                      items: data
                                          .map<DropdownMenuItem<CountryDatum>>(
                                              (item) => DropdownMenuItem<
                                                      CountryDatum>(
                                                    value: item,
                                                    child: Text(
                                                      item.countryName ?? '',
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
                                      value: selectedCountry,
                                      onChanged: (CountryDatum? newValue) {
                                        setState(() {
                                          /// Set selected item params
                                          selectedCountry = newValue;
                                          selectedCountryCode =
                                              newValue?.countryCode;
                                          selectedCountryName =
                                              newValue?.countryName;
                                          selectedCitizenshipCode =
                                              newValue?.countryCode;
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
                                : GestureDetector(
                                    child: Text(
                                        'No? countries?, Tap to refresh, '),
                                    onTap: () =>
                                        ref.invalidate(getCountriesProvider),
                                  ),
                            error: (e, s) => GestureDetector(
                                onTap: () =>
                                    ref.invalidate(getCountriesProvider),
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
                    hint: 'Telephone number eg.2338032489922',
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
                    hint: 'Mobile number eg.2338032489922',
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
                    title: 'City',
                    fillColor: Colors.transparent,
                    controller: cityController,
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
                  const SizedBox(height: 16),
                  Text(
                    'ID Type',
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
                      return ref.watch(getIdentificationTypesProvider).when(
                            data: (data) => (data != null &&
                                    data.isNotEmpty == true)
                                ? DropdownButtonHideUnderline(
                                    child: DropdownButton2<
                                        IdentificationTypesDatum>(
                                      isExpanded: true,
                                      hint: Text(
                                        'Select ID type',
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
                                                      IdentificationTypesDatum>>(
                                              (item) => DropdownMenuItem<
                                                      IdentificationTypesDatum>(
                                                    value: item,
                                                    child: Text(
                                                      item.identificationTypeName ??
                                                          '',
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
                                      value: selectedIdType,
                                      onChanged:
                                          (IdentificationTypesDatum? newValue) {
                                        setState(() {
                                          /// Set selected item params
                                          selectedIdType = newValue;
                                          selectedIdentificationTypeCode =
                                              newValue?.identificationTypeId;
                                          selectedCountryName =
                                              newValue?.identificationTypeName;
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
                                : GestureDetector(
                                    child: Text('No? types?, Tap to refresh, '),
                                    onTap: () => ref.invalidate(
                                        getIdentificationTypesProvider),
                                  ),
                            error: (e, s) => GestureDetector(
                                onTap: () => ref
                                    .invalidate(getIdentificationTypesProvider),
                                child: const Text(
                                  'An error occured fetch login modes.Tap to refresh',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            loading: () => SizedBox(height: 16.0),
                          );
                    },
                  ),
                  const SizedBox(height: 16),
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
                    showTitleTip: true,
                    titleTip: ' (If its a Ghana CARD eg. GHA-00000-9)',
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
                    onTap: () {
                      _showDatePicker(context, dateCategory: 'ISSUE');
                    },
                    title: 'Issue Date',
                    showCursor: false,
                    readOnly: true,
                    fillColor: Colors.transparent,
                    controller: datedIssuedController,
                    showDropDownSuffixIcon: true,
                    hint: 'ID Issue Date',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    suffixIcon: Icon(
                      Icons.calendar_today_rounded,
                      color: ZxplorePrimaryColor.withOpacity(.5),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'ID Issue is required';
                      } else if (value == 'dd-mm-yyyy') {
                        return 'Enter a valid date';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    onTap: () {
                      _showDatePicker(context, dateCategory: 'EXPIRY');
                    },
                    title: 'Expiry Date',
                    readOnly: true,
                    showDropDownSuffixIcon: true,
                    showCursor: false,
                    suffixIcon: Icon(
                      Icons.calendar_today_rounded,
                      color: ZxplorePrimaryColor.withOpacity(.5),
                    ),
                    fillColor: Colors.transparent,
                    controller: dateExpireController,
                    hint: 'ID Expiry Date',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'ID Expiry is required';
                      } else if (value == 'dd-mm-yyyy') {
                        return 'Enter a valid date';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    title: 'NIA Number',
                    fillColor: Colors.transparent,
                    controller: niaVerificationNoController,
                    hint: 'NIA number eg. 1234000',
                    maxLenght: 7,
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
                    hint: 'Enter IDD code eg. 0000',
                    maxLenght: 4,
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
                        if (selectedCountry == null) {
                          zXFlushBar(context, "Country is required");
                          return;
                        }
                        if (selectedGenderItem == null) {
                          zXFlushBar(context, "Gender is required");
                          return;
                        }

                        if (selectedIdType == null) {
                          zXFlushBar(context, "ID type is required");
                          return;
                        }
                        if (dob == null) {
                          zXFlushBar(context, "Date of birth is required");
                          return;
                        }
                        if (dateExpire == null) {
                          zXFlushBar(context, "ID expiry date id required");
                          return;
                        }

                        if (datedIssued == null) {
                          zXFlushBar(context, "ID issued date id required");
                          return;
                        }
                        createAccountRequest();
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

  Future<void> createAccountRequest() async {
    ref.read(createAccountControllerProvider.notifier).createNnewAAccount(
        accountData: CreateAccountData(
            surname: lastNameController.text.toString(),
            firstName: firstNameController.text.toString(),
            otherNames: otherNameController.text.toString(),
            identificationNo: identificationNoController.text.toString(),
            niaVerificationNo: niaVerificationNoController.text.toString(),
            iddCode: iddCodeController.text.toString(),
            city: cityController.text.toString(),
            mobileNo: mobileNoController.text.toString(),
            telNo: telNoController.text.toString(),
            residentialAddress: residentialAddressController.text.toString(),
            residentialAddress2: residentialAddressController2.text.toString(),
            citizenshipCode: selectedCitizenshipCode ?? '',
            idCountryCode: selectedCountryCode ?? '',
            genderCode: selectedGenderCode,
            identificationTypeId: selectedIdentificationTypeCode,
            idIssueAuthority: idIssueAuthorityController.text.toString(),
            birthDate: dob ?? '',
            idExpiryDate: dateExpire ?? '',
            idIssueDate: datedIssued ?? ''),
        onFailure: () {},
        afterFetched: () {
          if (mounted) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (builder) {
                  return AlertDialog.adaptive(
                    content: Text('Personal infomation saved'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MyHomePage()),
                            );
                          },
                          child: Text('Done'))
                    ],
                  );
                });
          }
        });
  }

  /// Date Picker
  Future<void> _showDatePicker(BuildContext dateContext,
      {required String dateCategory}) async {
    final DateTime firstDate = DateTime(1900);
    final DateTime lastDate = DateTime(2060);
    if (mounted) {
      final DateTime? fPickedDate = await showDatePicker(
        context: context,
        initialDate: dobInit!,
        firstDate: firstDate,
        lastDate: lastDate,
      );
      if (fPickedDate != null) {
        if (dateCategory == 'DOB') {
          setState(() {
            dobInit = fPickedDate;
            dob = fPickedDate.toIso8601String();
            dobFormattedDate = dateFormatter.format(dobInit!);
            sDobFormattedDate = sdateFormatter.format(dobInit!);
            dobController.text = dobFormattedDate;
          });
        } else if (dateCategory == 'ISSUE') {
          setState(() {
            dobInit = fPickedDate;
            datedIssued = fPickedDate.toIso8601String();

            dobFormattedDate = dateFormatter.format(dobInit!);
            sDobFormattedDate = sdateFormatter.format(dobInit!);
            datedIssuedController.text = dobFormattedDate;
          });
        } else {
          setState(() {
            dobInit = fPickedDate;
            dateExpire = fPickedDate.toIso8601String();

            dobFormattedDate = dateFormatter.format(dobInit!);
            sDobFormattedDate = sdateFormatter.format(dobInit!);
            dateExpireController.text = dobFormattedDate;
          });
        }
      }
    }
  }
}

Widget zXFlushBar(BuildContext context, String? message) {
  return FlushbarHelper.createError(
      message: message ?? "Required field(s) missing")
    ..show(context);
}

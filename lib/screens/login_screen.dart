import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/models/epma_models/login_modes_response.dart';
import 'package:zxplore_app/screens/controllers/login/get_login_modes.dart';
import 'package:zxplore_app/screens/controllers/login/login_view_controller.dart';
import 'package:zxplore_app/screens/controllers/meta/anticiapted_amount.dart';
import 'package:zxplore_app/screens/controllers/meta/anticipated_transactions.dart';
import 'package:zxplore_app/screens/controllers/meta/business_natures.dart';
import 'package:zxplore_app/screens/controllers/meta/countries.dart';
import 'package:zxplore_app/screens/controllers/meta/customer_classification.dart';
import 'package:zxplore_app/screens/controllers/meta/employment_types.dart';
import 'package:zxplore_app/screens/controllers/meta/fatca_status.dart';
import 'package:zxplore_app/screens/controllers/meta/gender.dart';
import 'package:zxplore_app/screens/controllers/meta/get_documents_types.dart';
import 'package:zxplore_app/screens/controllers/meta/identification_types.dart';
import 'package:zxplore_app/screens/controllers/meta/marital_status.dart';
import 'package:zxplore_app/screens/controllers/meta/recon_status.dart';
import 'package:zxplore_app/screens/controllers/meta/regions.dart';
import 'package:zxplore_app/screens/controllers/meta/search_options.dart';
import 'package:zxplore_app/screens/home_screen.dart';
import 'package:zxplore_app/widgets/async_ui.dart';
import 'package:zxplore_app/widgets/custom_text_field.dart';
import 'package:zxplore_app/widgets/submit_button.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class LoginPage extends ConsumerStatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final loginFrmKey = GlobalKey<FormState>();
  final loginPasswordController = TextEditingController();
  final loginUserNameController = TextEditingController();
  LoginModesData? selectedValue;

  bool _passwordHidden = false;
  String appVersion = '';
  String? loginModeValue = '';
  String? loginModeName = '';
  @override
  void initState() {
    super.initState();
    getPackageInfo();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _passwordHidden = !_passwordHidden;
    });
  }

  getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
  }

  Future<void> loginUser() async {
    ref.read(loginControllerProvider.notifier).loginUser(
        onSuccess: () {
          /// call the required Meta
          ref.read(getAnticipatedAmountProvider);
          ref.read(getAnticipatedTransactionProvider);
          ref.read(getBusinessNaturesProvider);
          ref.read(getCountriesProvider);
          ref.read(getCustomerClassificationProvider);
          ref.read(getEmploymentTypeProvider);
          ref.read(getFatcaStatusProvider);
          ref.read(getGenderProvider);
          ref.read(getDocumentTypesProvider);
          ref.read(getIdentificationTypesProvider);
          ref.read(getMaritalStatusProvider);
          ref.read(getReconStatusProvider);
          ref.read(getRegionsProvider);
          ref.read(getSearchOptionsProvider);

          /// Todo add recent params when i item has been selected
          ///  set this items only when there is a recently viewed or editable request
          // ref.read(getAccountSeriesProvider('',''));
          // ref.read(getAccountClassProvider('','',''));
          // ref.read(getSubBusinessNaturesProvider(0));
          ///! End
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (BuildContext context) => MyHomePage()),
          );
        },
        loginMode: loginModeName,
        username: loginUserNameController.text.toString(),
        password: loginPasswordController.text.toString());
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      loginControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    return ZxploreProgress(
      inAsyncCall: ref.watch(getLoginModesProvider).isLoading ||
          ref.watch(loginControllerProvider).isLoading,
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: loginFrmKey,
            child: ListView(
              children: [
                Container(
                  color: ZxplorePrimaryColor,
                  height: 0.5 * MediaQuery.of(context).size.height,
                  child: Center(
                    child: Container(
                      height: 120,
                      width: 120,
                      color: Colors.white,
                      child: Center(
                        child: Container(
                          width: 60,
                          height: 60,
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      'Enter your Zenith bank active directory credential(s) below. This helps identify the employee that wants to access the application.',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Text(
                        'Preferred Login',
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: 
                  Consumer(
                    builder: (context, ref, child) {
                      return ref.watch(getLoginModesProvider).when(
                            data: (data) => (data != null &&
                                    data.isNotEmpty == true)
                                ? DropdownButtonHideUnderline(
                                    child: DropdownButton2<LoginModesData>(
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
                                                      LoginModesData>>(
                                              ( item) =>
                                                  DropdownMenuItem<
                                                      LoginModesData>(
                                                    value: item,
                                                    child: Text(
                                                      item.loginModeName ?? '',
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
                                      value: selectedValue,
                                      onChanged: (LoginModesData? newValue) {
                                        setState(() {
                                          /// Set selected item params
                                          selectedValue = newValue;
                                          loginModeValue =
                                              newValue?.loginModeValue;
                                          loginModeName =
                                              newValue?.loginModeName;
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
                                : const SizedBox.shrink(),
                            error: (e, s) => GestureDetector(
                                onTap: () =>
                                    ref.invalidate(getLoginModesProvider),
                                child: const Text(
                                  'An error occured fetch login modes.Tap to refresh',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            loading: () => SizedBox(height: 16.0),
                          );
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomTextFormField(
                    title: 'Username',
                    fillColor: Colors.transparent,
                    controller: loginUserNameController,
                    hint: 'Enter username',
                    inputType: TextInputType.text,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Username is  required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 12.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomTextFormField(
                    title: 'Password',
                    isEyeIconHidden: false,
                    fillColor: Colors.transparent,
                    controller: loginPasswordController,
                    hint: 'Enter Password',
                    inputType: TextInputType.visiblePassword,
                    isPassword: _passwordHidden,
                    togglePasswordVisibility: _togglePasswordVisibility,
                    showPasswordSuffixIcon: true,
                    useDefaultErrorText: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Password is  required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 12.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                  child: PrimaryButton(
                    onPressed: () {
                      if (!loginFrmKey.currentState!.validate()) {
                        return;
                      }
                      loginUser();
                    },
                    title: 'Login',
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                        child: Text(
                      'Zxplore GH Version $appVersion',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

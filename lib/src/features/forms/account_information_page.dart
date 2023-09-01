import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/src/api/dio_error_handler.dart';
import 'package:zxplore_app/src/api/models/account_class_response.dart';
import 'package:zxplore_app/src/constants/constants.dart';
import 'package:zxplore_app/src/shared/app_exception.dart';
import 'package:zxplore_app/src/shared/app_sizes.dart';
import 'package:zxplore_app/src/shared/providers.dart';

final accountInfoFormKey = GlobalKey<FormState>(debugLabel: 'accountInfo');

class AccountInformationPage extends ConsumerStatefulWidget {
  const AccountInformationPage({super.key});

  @override
  ConsumerState<AccountInformationPage> createState() =>
      _AccountInformationPageState();
}

class _AccountInformationPageState
    extends ConsumerState<AccountInformationPage> {
  final _accountHolderTypes = ['INDIVIDUAL'];
  final _riskRanks = ['HIGH', 'LOW', 'MEDIUM'];
  final _accountTypes = [savingAccount, currentAccount];

  String? _selectedAccountType;
  String? _selectedAccFilter;
  String? _selectedAccHolderType;
  String? _selectedRiskRank;
  AccountClassCode? _selectedAccountClassCode;

  Future<List<AccountClassCode>> fetchAccountClasses() async {
    try {
      final response =
          await ref.read(accountsRepositoryProvider).getAccountClasses();
      return response.accountClassCodes ?? [];
    } on DioException catch (err, _) {
      throw AppException('${getErrorMessage(err)}. Please try again');
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
              key: accountInfoFormKey,
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Account Holder Type',
                      helperText: "* Required",
                    ),
                    value: _selectedAccountType,
                    isDense: true,
                    items: _accountTypes.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedAccountType = value;
                        if (value == savingAccount) {
                          _selectedAccFilter = "SA";
                        } else if (value == currentAccount) {
                          _selectedAccFilter = "CA";
                        } else {
                          _selectedAccFilter = null;
                        }
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
                      labelText: 'Account Holder Type',
                      helperText: "* Required",
                    ),
                    value: _selectedAccHolderType,
                    isDense: true,
                    items: _accountHolderTypes.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedAccHolderType = value;
                      });
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please choose an account holder type';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Risk Rank',
                      helperText: "* Required",
                    ),
                    value: _selectedRiskRank,
                    isDense: true,
                    items: _riskRanks.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedRiskRank = value;
                      });
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please choose a risk rank';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  DropdownSearch<AccountClassCode>(
                    popupProps: PopupProps.menu(
                      showSearchBox: true,
                      emptyBuilder: (context, string) => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Failed to fetch account classes. Please try again',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Select Account Category',
                        helperText: '* Required',
                        isDense: true,
                      ),
                    ),
                    asyncItems: (string) => fetchAccountClasses(),
                    selectedItem: _selectedAccountClassCode,
                    itemAsString: (AccountClassCode a) => a.description!,
                    onChanged: (AccountClassCode? value) {
                      setState(() {
                        _selectedAccountClassCode = value;
                      });
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null) {
                        return 'Please choose an account category';
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

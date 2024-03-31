import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:zxplore_app/blocs/account_class_bloc.dart';
import 'package:zxplore_app/blocs/account_form_bloc.dart';
import 'package:zxplore_app/blocs/provider.dart';
import 'package:zxplore_app/data/entities/account_class_entity.dart';
import 'package:zxplore_app/utils/const.dart';
import 'package:zxplore_app/utils/preferences.dart';

class AccountInformationStep extends StatefulWidget {
  @override
  _AccountInformationState createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformationStep>
    with AutomaticKeepAliveClientMixin<AccountInformationStep> {
  AccountFormBloc? accountFormBloc;
  late AccountClassBloc _accountClassBloc;

  final _accountHolderTypes = ['INDIVIDUAL'];
  final _riskRanks = ['HIGH', 'LOW', 'MEDIUM'];
  final _accountTypes = [SAVINGS_ACCOUNT, CURRENT_ACCOUNT];

  String? _selectedAccountType;
  String? _anticipatedNoOfTransaction;
  String? _anticipatedAmountOfTransaction;

  String? _anticipatedWithdrawerNoTransaction;
  String? _anticipatedWithdrawerAmountTransaction;

  String _selectedAccFilter = "";
  List<AccountClassEntity>? accountClasses;

  String? numberOfDepoit;
  TextEditingController? _otherPurposeController;
  // String? amtOfDepoit;

//  String? numberOfWithdraw;
  // String? amtOfWithdraw;

  Preference? prefs;

  TextEditingController? _expectedAmountController;

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _accountClassBloc.dispose();
    _otherPurposeController!.dispose();
    _expectedAmountController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    prefs = Preference();
    //  getDetails();
    _expectedAmountController = TextEditingController();
    _otherPurposeController = TextEditingController();
    accountFormBloc = BlocProvider.of<AccountFormBloc>(context);
    _accountClassBloc = AccountClassBloc();
    _accountClassBloc.getAccountClasses();
    //  getSharedPref();
    _accountClassBloc.accountClasses.listen((data) {
      accountClasses = data;
    });
    accountFormBloc!.getCurrentLocation();
  }

/*
    void getDetailsn() async {
    await prefs!.load();
    final purposeOfAcctListJson = prefs!.getString("PurposeOfAcct");
    final transactionTypeListJson = prefs!.getString("TransactionType");
     final transactionCountListJson = prefs!.getString("NoOfTransaction");

  final purposeOfAcct = cardTypeFromJson(purposeOfAcctListJson).menu;
  if (purposeOfAcct != null) {
    accountFormBloc!.setPurposeOfAcct(purposeOfAcct);
  }
  final transactionType = cardTypeFromJson(transactionTypeListJson).menu;
  if (transactionType != null) {

  }
      final transactionCount = cardTypeFromJson(transactionCountListJson).menu;
  if (transactionCount != null) {
    numberOfDepoit = transactionCount.first;
 //     accountFormBloc!.setAnticipatedNoTransaction(transactionCount);
  }

  }
*/

  Widget accountTypeField() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.accountType,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidateMode: AutovalidateMode.always,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                   enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 8), // Highlight on focus
                  ),
                  labelText: 'Account Type',
                  helperText: "* Required",
                  errorText: snapshot.error as String?),
//              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.data ?? _selectedAccountType,
                  isDense: true,
                  items: _accountTypes.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedAccountType = value;
                      if (value == SAVINGS_ACCOUNT) {
                        _selectedAccFilter = "SA";
                      } else if (value == CURRENT_ACCOUNT) {
                        _selectedAccFilter = "CA";
                      } else {
                        _selectedAccFilter = "";
                      }
                    });
                    accountFormBloc!.updateAccountType(value);
                    accountFormBloc!.updateAccountCategoryType(null);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget accountHolderTypeField() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.accountHolderType,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidateMode: AutovalidateMode.always,
          builder: (FormFieldState<String> state) {
            return InputDecorator(

              decoration: InputDecoration(
                   enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 8), // Highlight on focus
                  ),
                  labelText: 'Account Holder Type',
                  helperText: "* Required",
                  errorText: snapshot.error as String?),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.data ?? _accountHolderTypes[0],
                  isDense: true,
                  onChanged:accountFormBloc!.changeHolderType,
                  items: _accountHolderTypes.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget riskRankField() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.riskRankType,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidateMode: AutovalidateMode.always,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                   enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 8), // Highlight on focus
                  ),
                  labelText: 'Risk Rank', errorText: snapshot.error as String?),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.data,
                  isDense: true,
                  onChanged: accountFormBloc!.changeRiskRank,
                  items: _riskRanks.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _accountCategoryField() {
    return StreamBuilder<List<AccountClassEntity>>(
      stream: _accountClassBloc.accountClasses,
      builder: (context, listSnapshot) {
        return StreamBuilder(
            stream: accountFormBloc!.accountCategoryType,
            builder: (context, itemSnapshot) {
              return FormField<String>(
                autovalidateMode: AutovalidateMode.always,
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                         enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 8), // Highlight on focus
                  ),
                        labelText: 'Account Category',
                        helperText: "* Required",
                        errorText: itemSnapshot.error as String?),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _getAccountTypeValue(itemSnapshot, listSnapshot),
                        isDense: true,
                        items: listSnapshot.hasData
                            ? listSnapshot.data!
                                .where((x) =>
                                    x.type!.startsWith(_selectedAccFilter))
                                .map((AccountClassEntity entity) {
                                return DropdownMenuItem<String>(
                                  value: entity.name.toString(),
                                  child: Text(entity.name.toString()),
                                );
                              }).toList()
                            : null,
                        onChanged: (value) {
                          accountFormBloc!.updateAccountCategoryType(value);
                        },
                      ),
                    ),
                  );
                },
              );
            });
      },
    );
  }

/*
  Widget purposeOfAcctField() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.purposeAcct,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidateMode: AutovalidateMode.always,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText:  'Purpose of Account',
                  helperText: "* Required",
                  errorText: snapshot.error as String?),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.data,
                  isDense: true,
                  onChanged: accountFormBloc!.changePurposeOfAccount,
                  items:purposeOfAcctList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: textValue(value),
                      //Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget textValue(String text) {
    return Text(text);
  }

   Widget transactionTypeField() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.transactionType,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidateMode: AutovalidateMode.always,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Transaction Type',
                  helperText: "* Required",
                  errorText: snapshot.error as String?),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.data,
                  isDense: true,
                  onChanged: accountFormBloc!.changeTransactionType,
                  items: transactionTypeList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        );
      },
    );
  }
*/

  Widget transactionCountFieldDeposit() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.anticipatedNoTran,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidateMode: AutovalidateMode.always,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                   enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 8), // Highlight on focus
                  ),
                  labelText: 'Anticipated No of Transaction',
                  helperText: "* Required",
                  errorText: snapshot.error as String?),
              //   isEmpty: snapshot.data == null,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.data ?? _anticipatedNoOfTransaction,
                  isDense: true,
                  onChanged: (value) {
                    if (value != null) {
                      accountFormBloc!.setAnticipatedNoTransaction(value);

                      setState(() {
                        _anticipatedNoOfTransaction = value;
                      });
                    }
                  },
                  items: noOfTransaction.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget transactionAmountFieldDeposit() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.anticipatedAmountTran,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidateMode: AutovalidateMode.always,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                   enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 8), // Highlight on focus
                  ),
                  labelText: 'Anticipated Amount',
                  helperText: "* Required",
                  errorText: snapshot.error as String?),
              //  isEmpty: snapshot.data == null,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.data ?? _anticipatedAmountOfTransaction,
                  isDense: true,
                  onChanged: (value) {
                    if (value != null) {
                      numberOfDepoit = value;
                      accountFormBloc!.setAnticipatedAmountTransaction(value);
                      setState(() {
                        _anticipatedAmountOfTransaction = value;
                      });
                    }
                  },
                  items: amountOfTransaction.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget transactionCountFieldWithdraw() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.anticipatedNoWithdraw,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidateMode: AutovalidateMode.always,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 8), // Highlight on focus
                  ),
                  labelText: 'Anticipated No of Transaction',
                  helperText: "* Required",
                  errorText: snapshot.error as String?),
              //  isEmpty: snapshot.data == null,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.data ?? _anticipatedWithdrawerNoTransaction,
                  isDense: true,
                  onChanged: (value) {
                    if (value != null) {
                      accountFormBloc!.setAnticipatedNoWithdraw(value);
                    }
                    setState(() {
                      _anticipatedWithdrawerNoTransaction = value;
                    });
                  },
                  items: noOfTransaction.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget transactionAmountFieldWithdraw() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.anticipatedAmountWithdraw,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidateMode: AutovalidateMode.always,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                   enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 8), // Highlight on focus
                  ),
                  labelText: 'Anticipated Amount',
                  helperText: "* Required",
                  errorText: snapshot.error as String?),
              // isEmpty: snapshot.data == null,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value:
                      snapshot.data ?? _anticipatedWithdrawerAmountTransaction,
                  isDense: true,
                  onChanged: (value) {
                    if (value != null) {
                      // numberOfDepoit = value;
                      accountFormBloc!.setAnticipatedAmountWithdraw(value);
                      setState(() {
                        _anticipatedWithdrawerAmountTransaction = value;
                      });
                    }
                  },
                  items: amountOfTransaction.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget checkBoxWidget(String purpose) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(purpose),
      value: true,
      onChanged: (bool? value) {},
      //   secondary: const Icon(Icons.hourglass_empty),
    );
  }

  Widget _otherPurpose() {
    return StreamBuilder<bool?>(
        stream: accountFormBloc!.others,
        builder: (context, snapshot) {
          return Visibility(
              visible: snapshot.hasData ? snapshot.data! : false,
              child: StreamBuilder<String?>(
                  stream: accountFormBloc!.othersPurpose,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (_otherPurposeController!.text !=
                          snapshot.data.toString()) {
                        _otherPurposeController!.text =
                            snapshot.data.toString();
                        _otherPurposeController!.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: _otherPurposeController!.text.length));
                      }
                    }
                    return TextField(
                      controller: _otherPurposeController,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      onChanged: accountFormBloc!.changeOthersPurpose,
                      decoration: InputDecoration(
                        labelText: 'Enter purpose',
                        errorText: snapshot.error as String?,
                      ),
                    );
                  }));
        });
  }

  getInfo() {}

  String? _getAccountTypeValue(AsyncSnapshot itemSnapshot,
      AsyncSnapshot<List<AccountClassEntity>> listSnapshot) {
    var data = (listSnapshot.hasData &&
            listSnapshot.data!.length > 0 &&
            listSnapshot.data!.firstWhereOrNull(
                    (x) => x.name == itemSnapshot.data.toString()) !=
                null)
        ? itemSnapshot.data.toString()
        : null;

    return data;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 16.0),
                  accountTypeField(),
                  SizedBox(height: 30.0),
                  accountHolderTypeField(),
                  SizedBox(height: 30.0),
                  riskRankField(),
                  SizedBox(height: 30.0),
                  _accountCategoryField(),
                  SizedBox(height: 10.0),
                  Divider(),
                  SizedBox(height: 10.0),
                  purposeOfAcctWidget(),
                  _otherPurpose(),
                  SizedBox(height: 10.0),
                  Divider(),
                  SizedBox(height: 10.0),
                  Text("Deposit"),
                  SizedBox(height: 10.0),
                  Divider(),
                  SizedBox(height: 10.0),
                  transactionCountFieldDeposit(),
                  SizedBox(height: 20.0),
                  transactionAmountFieldDeposit(),
                  SizedBox(height: 10.0),
                  Divider(),
                  SizedBox(height: 10.0),
                  Text("Withdrawal"),
                  SizedBox(height: 10.0),
                  Divider(),
                  SizedBox(height: 10.0),
                  transactionCountFieldWithdraw(),
                  SizedBox(height: 20.0),
                  transactionAmountFieldWithdraw(),
                  SizedBox(height: 60.0),
                ],
              ),
              SizedBox(height: 60.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget purposeOfAcctWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Purpose Of Account"),
          SizedBox(
            height: 5,
          ),
          Divider(),
          SizedBox(
            height: 5,
          ),
          purposeOfAccountList(),
        ],
      );

  Widget purposeOfAccountList() => Column(
        children: [
          StreamBuilder<bool?>(
              stream: accountFormBloc!.salaryProcessing,
              builder: (context, snapshot) {
                return CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Salary Processing"),
                  activeColor: Colors.red,
                  value: snapshot.hasData ? snapshot.data : false,
                  onChanged: accountFormBloc!.changeSalaryProcessing,
                );
              }),
          StreamBuilder<bool?>(
              stream: accountFormBloc!.bankingService,
              builder: (context, snapshot) {
                return CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Access to banking Services"),
                    activeColor: Colors.red,
                    value: snapshot.hasData ? snapshot.data : false,
                    onChanged: accountFormBloc!.changeBankingService);
              }),
          StreamBuilder<bool?>(
              stream: accountFormBloc!.business,
              builder: (context, snapshot) {
                return CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Business/Transactional"),
                    activeColor: Colors.red,
                    value: snapshot.hasData ? snapshot.data : false,
                    onChanged: accountFormBloc!.changeBusiness);
              }),
          StreamBuilder<bool?>(
              stream: accountFormBloc!.singleTransaction,
              builder: (context, snapshot) {
                return CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Facilitation of a single transaction"),
                    activeColor: Colors.red,
                    value: snapshot.hasData ? snapshot.data : false,
                    onChanged: accountFormBloc!.changeSingleTransaction);
              }),
          StreamBuilder<bool?>(
              stream: accountFormBloc!.safeKeeping,
              builder: (context, snapshot) {
                return CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Security/Safekeeping"),
                    activeColor: Colors.red,
                    value: snapshot.hasData ? snapshot.data : false,
                    onChanged: accountFormBloc!.changeSafeKeeping);
              }),
          StreamBuilder<bool?>(
              stream: accountFormBloc!.savingAndInvestment,
              builder: (context, snapshot) {
                return CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Savings & Investment"),
                    activeColor: Colors.red,
                    value: snapshot.hasData ? snapshot.data : false,
                    onChanged: accountFormBloc!.changeSavingAndInvestment);
              }),
          StreamBuilder<bool?>(
              stream: accountFormBloc!.receipt,
              builder: (context, snapshot) {
                return CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Receipt of inflows for Personal upkeep"),
                    activeColor: Colors.red,
                    value: snapshot.hasData ? snapshot.data : false,
                    onChanged: accountFormBloc!.changeReceipt);
              }),
          StreamBuilder<bool?>(
              stream: accountFormBloc!.others,
              builder: (context, snapshot) {
                return CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Other"),
                    activeColor: Colors.red,
                    value: snapshot.hasData ? snapshot.data : false,
                    onChanged: accountFormBloc!.changeOthers);
              }),
        ],
      );

/*
    Widget sourceOfAccountList()=>Column(
      children: [

        StreamBuilder<bool?>(
          stream: accountFormBloc!.salaryProcessing,
          builder: (context, snapshot) {
            return CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("Salary Processing"),
               activeColor: Colors.red,
              value: snapshot.hasData ? snapshot.data : false,
              onChanged: accountFormBloc!.changeSalaryProcessing, 
              
              );
          }
        ),


       StreamBuilder<bool?>(
         stream: accountFormBloc!.rentalIncome,
         builder: (context, snapshot) {
           return CheckboxListTile(
             contentPadding: EdgeInsets.zero,
             title: Text("Rental Income"),
              activeColor: Colors.red,
             value: snapshot.hasData ? snapshot.data : false,
             onChanged: accountFormBloc!.changeRentalIncome );
         }
       ),

       StreamBuilder<bool?>(
         stream: accountFormBloc!.personalSaving,
         builder: (context, snapshot) {
           return CheckboxListTile(
             contentPadding: EdgeInsets.zero,
             title: Text("Personal Savings"),
              activeColor: Colors.red,
             value: snapshot.hasData ? snapshot.data : false,
             onChanged: accountFormBloc!.changepersonalSaving );
         }
       ),

       StreamBuilder<bool?>(
         stream: accountFormBloc!.familyFriend,
         builder: (context, snapshot) {
           return CheckboxListTile(
             contentPadding: EdgeInsets.zero,
             title: Text("Family & Friends"),
              activeColor: Colors.red,
             value: snapshot.hasData ? snapshot.data : false,
             onChanged: accountFormBloc!.changefamilyFriend );
         }
       ),

       StreamBuilder<bool?>(
         stream: accountFormBloc!.dividends,
         builder: (context, snapshot) {
           return CheckboxListTile(
             contentPadding: EdgeInsets.zero,
             title: Text("Dividends"),
              activeColor: Colors.red,
             value: snapshot.hasData ? snapshot.data : false,
             onChanged: accountFormBloc!.changeDividends );
         }
       ),

       StreamBuilder<bool?>(
         stream: accountFormBloc!.commission,
         builder: (context, snapshot) {
           return CheckboxListTile(
             contentPadding: EdgeInsets.zero,
             title: Text("Commissions"),
              activeColor: Colors.red,
             value: snapshot.hasData ? snapshot.data : false,
             onChanged: accountFormBloc!.changeCommission );
         }
       ),

       StreamBuilder<bool?>(
         stream: accountFormBloc!.businessProceed,
         builder: (context, snapshot) {
           return CheckboxListTile(
             contentPadding: EdgeInsets.zero,
             title: Text("Business Proceeds"),
              activeColor: Colors.red,
             value: snapshot.hasData ? snapshot.data : false,
             onChanged: accountFormBloc!.changeBusinessProceed );
         }
       ),

       StreamBuilder<bool?>(
         stream: accountFormBloc!.others,
         builder: (context, snapshot) {
           return CheckboxListTile(
             contentPadding: EdgeInsets.zero,
             title: Text("Other"),
              activeColor: Colors.red,
             value: snapshot.hasData ? snapshot.data : false,
             onChanged: accountFormBloc!.changeOthers );
         }
       ),

      ],
    );

*/
}

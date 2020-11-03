import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zxplore_app/blocs/account_form_bloc.dart';
import 'package:zxplore_app/blocs/provider.dart';
import 'package:zxplore_app/blocs/states_bloc.dart';
import 'package:zxplore_app/data/entities/state_entity.dart';
import 'package:zxplore_app/utils/const.dart';

import '../../colors.dart';
import '../../login.dart';
import 'package:zxplore_app/utils/flushbar_helper.dart';

class MeansOfIdentificationStep extends StatefulWidget {
  @override
  _MeansOfIdentificationStepStepState createState() =>
      _MeansOfIdentificationStepStepState();
}

class _MeansOfIdentificationStepStepState
    extends State<MeansOfIdentificationStep>
    with AutomaticKeepAliveClientMixin<MeansOfIdentificationStep> {
  final TextEditingController _idTypeController = TextEditingController();
  final TextEditingController _idPlaceOfIssueController =
      TextEditingController();
  final TextEditingController _idIssueDateController = TextEditingController();
  final TextEditingController _idExpiryDateController = TextEditingController();

  final TextEditingController _idIssuerController = TextEditingController();
  final TextEditingController _idIssuerOthersController =
      TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();

  final _idTypes = [
    'DRIVER\'S LICENSE',
    'INT\'L PASSPORT',
    'NATIONAL ID',
    'VOTER\'S ID CARD',
    'STUDENT ID',
    'OTHERS'
  ];

  final _idIssuer = [
    'ELECTORAL COMMISSION',
    'DVLA',
    'MINISTRY OF FOREIGN AFFAIRS',
    'NIA',
    'BA1',
    'OTHERS'
  ];
  String _selectedIdentityType;
  String _selectedIdentityIssuer;
  int _selectedIdFilter = 99;
  bool others = false;

  AccountFormBloc accountFormBloc;

  StatesBloc statesBloc;

  @override
  void initState() {
    super.initState();
    statesBloc = StatesBloc();
    accountFormBloc = BlocProvider.of<AccountFormBloc>(context);
  }

  Widget _idTypeTextField() {
    return StreamBuilder(
      stream: accountFormBloc.idType,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidate: true,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'ID Type',
                  helperText: "* Required",
                  errorText: snapshot.error),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.data,
                  isDense: true,
                  onChanged: (value) {
                    _selectedIdentityType = value;
                    if (value == DRIVERS_LICENSE) {
                      _selectedIdFilter = 0;
                    } else if (value == VOTERS_CARD) {
                      _selectedIdFilter = 1;
                    } else if (value == INT_PASSPORT) {
                      _selectedIdFilter = 2;
                    } else {
                      _selectedIdFilter = 3;
                    }
                    accountFormBloc.updateIdentityType(value);
                  },
                  items: _idTypes.map((String value) {
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

  Widget _idIssuerTextField() {
    return StreamBuilder(
      stream: accountFormBloc.idIssuer,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _idIssuerController.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _idIssuerController.selection);
        }
        return FormField<String>(
          autovalidate: true,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                labelText: 'ID Issuer',
                helperText: '* Required',
                errorText: snapshot.error,
              ),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.data,
                  isDense: true,
                  onChanged: (value) {
                    setState(() {
                      _selectedIdentityIssuer = value;
                      if (value == OTHERS) {
                        others = true;
                      } else {
                        others = false;
                      }
                    });

                    accountFormBloc.updateIDIssuerType(value);
                  },
                  items: _idIssuer.map((String value) {
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

  Widget _otherIdIssuerTextField() {
    return StreamBuilder(
      stream: accountFormBloc.idOthersIssuer,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _idIssuerOthersController.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _idIssuerOthersController.selection);
        }
        return TextField(
          controller: _idIssuerOthersController,
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc.changeIdOtherIssuer,
          keyboardType: TextInputType.text,
          maxLength: 40,
          maxLines: null,
          maxLengthEnforced: true,
          decoration: InputDecoration(
            labelText: 'ID Other Issuer',
            helperText: '* Required',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget _idNumberTextField() {
    return StreamBuilder(
      stream: accountFormBloc.idNumber,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _idNumberController.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _idNumberController.selection);
        }
        return TextField(
          controller: _idNumberController,
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc.changeIdNumber,
          keyboardType: TextInputType.text,
          maxLength: 20,
          maxLines: null,
          maxLengthEnforced: true,
          decoration: InputDecoration(
            labelText: 'ID Number',
            helperText: '* Required',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget _idPlaceOfIssue() {
    return StreamBuilder(
      stream: accountFormBloc.idPlaceOfIssue,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidate: true,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'ID Place of Issue',
                  helperText: "* Required",
                  errorText: snapshot.error),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: StreamBuilder<List<StateEntity>>(
                    stream: statesBloc.states,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<StateEntity>> shot) {
                      if (!shot.hasData)
                        return SizedBox(
                            height: 24.0,
                            child: Center(child: CircularProgressIndicator()));
                      return DropdownButton<String>(
                        value: snapshot.data,
                        items: shot.data.map((StateEntity value) {
                          return DropdownMenuItem<String>(
                            value: value.name,
                            child: Text(value.name),
                          );
                        }).toList(),
                        onChanged: accountFormBloc.changePlaceOfIssue,

                        isDense: true, //value: _currentUser,
                      );
                    }),
              ),
            );
          },
        );
      },
    );
  }

  Widget _scan_to_pay_checkBox() {
    return StreamBuilder(
        stream: accountFormBloc.isScanToPay,
        builder: (context, snapshot) {
          return CheckboxListTile(
            onChanged: accountFormBloc.changeIsScanToPay,
            title: new Text('Scan To Pay'),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.red,
            dense: true,
            value: snapshot.hasData ? snapshot.data : false,
          );
        });
  }

  Widget _z_mobile_checkBox() {
    return StreamBuilder(
        stream: accountFormBloc.isZMobile,
        builder: (context, snapshot) {
          return CheckboxListTile(
            onChanged: accountFormBloc.changeIsZMobile,
            title: new Text('Z - Mobile'),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.red,
            dense: true,
            value: snapshot.hasData ? snapshot.data : false,
          );
        });
  }

  Widget _z_prompt_checkBox() {
    return StreamBuilder(
        stream: accountFormBloc.isZPrompt,
        builder: (context, snapshot) {
          return CheckboxListTile(
            onChanged: accountFormBloc.changeIsZPrompt,
            title: new Text('Z - Prompt'),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.red,
            dense: true,
            value: snapshot.hasData ? snapshot.data : false,
          );
        });
  }

  Widget _statement_via_email_CheckBox() {
    return StreamBuilder(
        stream: accountFormBloc.isStatementViaEmail,
        builder: (context, snapshot) {
          return CheckboxListTile(
            onChanged: accountFormBloc.changeIsStatementViaEmail,
            title: new Text('Statement Via Email'),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.red,
            dense: true,
            value: snapshot.hasData ? snapshot.data : false,
          );
        });
  }

  Widget _ussd_checkBox() {
    return StreamBuilder(
        stream: accountFormBloc.isUssd,
        builder: (context, snapshot) {
          return CheckboxListTile(
            onChanged: accountFormBloc.changeIsUssd,
            title: new Text('USSD'),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.red,
            dense: true,
            value: snapshot.hasData ? snapshot.data : false,
          );
        });
  }

  Widget _bank_to_wallet_checkBox() {
    return StreamBuilder(
        stream: accountFormBloc.isBankToWallet,
        builder: (context, snapshot) {
          return CheckboxListTile(
            onChanged: accountFormBloc.changeIsBankToWallet,
            title: new Text('Bank to Wallet'),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.red,
            dense: true,
            value: snapshot.hasData ? snapshot.data : false,
          );
        });
  }

  @override
  void dispose() {
    _idTypeController.dispose();
    _idPlaceOfIssueController.dispose();
    _idIssueDateController.dispose();
    _idExpiryDateController.dispose();
    _idNumberController.dispose();
    _idIssuerController.dispose();
    statesBloc.dispose();
    super.dispose();
  }

  Widget _idIssueDateField() {
    return StreamBuilder(
      stream: accountFormBloc.idIssueDate,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _idIssueDateController.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _idIssueDateController.selection);
        }
        return GestureDetector(
            onTap: () async {
              DateTime picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: new DateTime(DateTime.now().year - 25),
                  lastDate: new DateTime.now());

              if (picked != null) {
                var formatter = new DateFormat('dd-MMM-yy');

                var date = formatter.format(picked);

                _idIssueDateController.text = date;
                accountFormBloc.changeIssueDate(date);
              }
            },
            child: AbsorbPointer(
              child: TextField(
                controller: _idIssueDateController,
                onChanged: accountFormBloc.changeIssueDate,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'ID Issue Date',
                  helperText: "* Required",
                  suffixIcon: Icon(Icons.date_range),
                  errorText: snapshot.error,
                ),
              ),
            ));
      },
    );
  }

  Widget _idExpiryDateField() {
    return StreamBuilder(
      stream: accountFormBloc.idExpiryDate,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _idExpiryDateController.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _idExpiryDateController.selection);
        }
        return GestureDetector(
            onTap: () async {
              DateTime picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: new DateTime.now(),
                  lastDate: new DateTime(DateTime.now().year + 25));

              if (picked != null) {
                var formatter = new DateFormat('dd-MMM-yy');

                var date = formatter.format(picked);

                _idExpiryDateController.text = date;
                accountFormBloc.changeExpiryDate(date);
              }
            },
            child: AbsorbPointer(
              child: TextField(
                controller: _idExpiryDateController,
                onChanged: accountFormBloc.changeExpiryDate,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'ID Expiry Date',
                  helperText: "* Required",
                  suffixIcon: Icon(Icons.date_range),
                  errorText: snapshot.error,
                ),
              ),
            ));
      },
    );
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
                children: <Widget>[
                  SizedBox(height: 16.0),
                  _idTypeTextField(),
                  SizedBox(height: 30.0),
                  _idIssuerTextField(),
                  SizedBox(height: 30.0),
                  Visibility(visible: others, child: _otherIdIssuerTextField()),
                  SizedBox(height: 30.0),
                  IntrinsicHeight(
                    child: Column(
                      children: [
                        _idNumberTextField(),
                        Container(
                          alignment: Alignment(1.0, 0.0),
                          height: 60.0,
                          child: OutlineButton(
                            child: Text('VERIFY NUMBER'),
                            textColor: ZxplorePrimaryColor,
                            color: Colors.transparent,
                            onPressed: () {
                              var loadingBar = FlushbarHelper.createLoading(
                                  message: "verifying NUMBER PLease wait...",
                                  linearProgressIndicator: null);
                              loadingBar..show(context);
                              accountFormBloc.verifyNumber(_selectedIdFilter);
                              accountFormBloc.driverLicenseVerificationResponse
                                  .listen((response) {
                                loadingBar.dismiss();
                                if (_selectedIdFilter == 0) {
                                  FlushbarHelper.createSuccess(
                                      message:
                                          "Driver Liscence provided is correct.")
                                    ..show(context);
                                } else if (_selectedIdFilter == 1) {
                                  FlushbarHelper.createSuccess(
                                      message:
                                          "Voters Card provided is correct.")
                                    ..show(context);
                                } else if (_selectedIdFilter == 2) {
                                  FlushbarHelper.createSuccess(
                                      message: "Passport provided is correct.")
                                    ..show(context);
                                } else {
                                  FlushbarHelper.createSuccess(
                                      message: "Identity provided is correct.")
                                    ..show(context);
                                }
                              }).onError((error) {
                                loadingBar.dismiss();
                                if (_selectedIdFilter == 0) {
                                  FlushbarHelper.createError(
                                      message:
                                          "Driver Liscence provided could not be verified.")
                                    ..show(context);
                                } else if (_selectedIdFilter == 1) {
                                  FlushbarHelper.createError(
                                      message:
                                          "Voters Card provided could not be verified.")
                                    ..show(context);
                                } else if (_selectedIdFilter == 2) {
                                  FlushbarHelper.createError(
                                      message:
                                          "Passport provided provided could not be verified.")
                                    ..show(context);
                                } else {
                                  FlushbarHelper.createError(
                                      message:
                                          "Identity provided provided could not be verified.")
                                    ..show(context);
                                }
                                loadingBar.dismiss();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  _idPlaceOfIssue(),
                  SizedBox(height: 30.0),
                  _idIssueDateField(),
                  SizedBox(height: 30.0),
                  _idExpiryDateField(),
                  SizedBox(height: 30.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select the E-products available to this account.',
                      style: Theme.of(context).textTheme.caption,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  _scan_to_pay_checkBox(),
                  _z_mobile_checkBox(),
                  _z_prompt_checkBox(),
                  _statement_via_email_CheckBox(),
                  _ussd_checkBox(),
                  _bank_to_wallet_checkBox(),
                ],
              ),
              SizedBox(height: 60.0),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

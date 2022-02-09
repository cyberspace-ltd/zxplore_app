import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:zxplore_app/blocs/account_form_bloc.dart';
import 'package:zxplore_app/blocs/provider.dart';
import 'package:zxplore_app/blocs/states_bloc.dart';
import 'package:zxplore_app/utils/const.dart';
import 'package:zxplore_app/utils/helper_functions.dart';
import 'package:zxplore_app/utils/zxplore_crypto_helper.dart';
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

      final TextEditingController _admissionNoController =
      TextEditingController();




  final TextEditingController _idNumberController = TextEditingController();


  final _idTypes = idTypes;

/*
  final _idTypes = [
    'DRIVER\'S LICENSE',
   // 'INT\'L PASSPORT',
   'INTERNATIONAL PASSPORT',
    'NATIONAL ID CARD',
    'VOTER\'S ID CARD',
    'STUDENT ID',
    'SSNIT CARD',
    'OTHERS'
  ];

  */

  String? otherIssuerDetails;

  List<String> _stateRegion = [
    'Ahafo Region',
    'Ashanti Region',
    'Bono Region',
    'Bono East Region',
    'Central Region',
    'Eastern Region',
    'Greater Accra Region',
    'Northern Region',
    'North East Region',
    'Oti Region',
    'Savannah Region',
    'Upper East Region',
    'Upper West Region',
    'Volta Region',
    'Western Region',
    'Western North Region'
  ];

  final _idIssuer = [
    'ELECTORAL COMMISSION',
   //  'DVLA',
    'DRIVER AND VEHICLE LICENSING AUTHORITY',
    'MINISTRY OF FOREIGN AFFAIRS',
   // 'NIA',
   'NATIONAL IDENTIFICATION AUTHORITY',
   // 'SSNIT',
   'SOCIAL SECURITY AND NATIONAL INSURANCE\nTRUST',
    'OTHERS'
  ];
  String? selectedIdentityType;
   String? selectedIdType;
  String? selectedIdentityIssuer;
  int _selectedIdFilter = 99;
  bool others = false;

  bool showAdmNo = false;

  AccountFormBloc? accountFormBloc;

  late StatesBloc statesBloc;

  WidgetsBinding? buildState;

  // var //idTypeTextFieldStream,idIssuerTextFieldStream,
 // var  idNumberTextFieldStream;
 //,admissionNumberTextFieldStream,
 
var otherIdIssuerTextFieldStream,admissionNumberTextFieldStream;
 
 //otherIdIssuerTextFieldStream,admissionNumberTextFieldStream,
 

  @override
  void initState() {
    super.initState();
    statesBloc = StatesBloc();
    accountFormBloc = BlocProvider.of<AccountFormBloc>(context);
    buildState = WidgetsBinding.instance;
   
   // idTypeTextFieldStream = accountFormBloc!.idType;
  //  idIssuerTextFieldStream = accountFormBloc!.idIssuer;
    otherIdIssuerTextFieldStream = accountFormBloc!.idOthersIssuer;
    admissionNumberTextFieldStream = accountFormBloc!.admissionNo;
  //  idNumberTextFieldStream = accountFormBloc!.idNumber;
//  accountFormBloc!.idOthersIssuer

  //  idPlaceOfIssueStream = accountFormBloc!.idPlaceOfIssue;

 
    
  }
  String? idVal;
  Widget _idTypeTextField() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.idType,
      builder: (context, snapshot) {
        idVal = snapshot.data;
      if(snapshot.hasData){

        if(snapshot.data == STUDENT_ID){
                             showAdmNo =true;
                        others = true;
                    buildState!=null? buildState!.addPostFrameCallback((_) => setState(() {})) : act();
      }

      }
        return FormField<String>(
          autovalidateMode: AutovalidateMode.always,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'ID Type',
                  helperText: "* Required",
                  errorText: snapshot.error as String?),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.data,
                  isDense: true,
                  onChanged: (value) {
                  
                    setState(() {
                      selectedIdentityType = value;
                      if (value == DRIVERS_LICENSE) {
                         showAdmNo =false;
                        _selectedIdFilter = 0;
                      } else if (value == INT_PASSPORT) {
                         showAdmNo =false;
                        _selectedIdFilter = 1;
                      } else if (value == SSNIT_CARD) {
                         showAdmNo =false;
                        _selectedIdFilter = 2;
                      } else if (value == VOTERS_CARD) {
                         showAdmNo =false;
                        _selectedIdFilter = 3;
                      } else if (value == OTHERS) {
                         showAdmNo =false;
                        _selectedIdFilter = 4;
                      } else if (value == NATIONAL_ID) {
                         showAdmNo =false;
                        _selectedIdFilter = 5;
                      } else if (value == STUDENT_ID) {
                     
                        _selectedIdFilter = 6;
                        //      showAdmNo =true;
                      //  others = true;
                       
                      } else {
                        // showAdmNo =false;
                        _selectedIdFilter = 99;
                      }
                    });
                    accountFormBloc!.updateIdentityType(value);
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
    return StreamBuilder<String?>(
      stream: accountFormBloc!.idIssuer,
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          String? value ;
         if((( selectedIdType == STUDENT_ID || 
            selectedIdType == OTHERS) && (snapshot.data == 'OTHERS'))){
                value = 'OTHERS';
                others = true;
             
          }else if(!_idIssuer.contains(snapshot.data) ){
             value = 'OTHERS';
                others = true;
                otherIssuerDetails = snapshot.data;
             
         //     _idIssuerOthersController.text = snapshot.data ?? "";
          }
          else{
            value = snapshot.data;
       
          }

          _idIssuerController.value = TextEditingValue(
              text: value!,
              selection: _idIssuerController.selection);
        }
        return FormField<String>(
          autovalidateMode: AutovalidateMode.always,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                labelText: 'ID Issuer',
                helperText: '* Required',
                errorText: snapshot.error as String?,
              ),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.data==null? null :((selectedIdType == STUDENT_ID || 
                          selectedIdType == OTHERS) && (snapshot.data=='OTHERS'))?
                   'OTHERS' : !_idIssuer.contains(snapshot.data) ? 'OTHERS' : snapshot.data,
                  isDense: true,
                  isExpanded: true,
                  onChanged: (value) {
                      accountFormBloc!.updateIDIssuerType(value);
                    setState(() {
                      selectedIdentityIssuer = value;
                      if (value == OTHERS) {
                        others = true;
                      } else {
                        others = false;
                      }
                    });

                  
                  },
                  items: _idIssuer.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, overflow: TextOverflow.ellipsis),
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

/*
  Widget _otherIdIssuerTextField() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.idOthersIssuer,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
            _idIssuerOthersController.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _idIssuerOthersController.selection);
        }else{
          if(otherIssuerDetails!=null){
             _idIssuerOthersController.value = TextEditingValue(
              text: otherIssuerDetails!,
              selection: _idIssuerOthersController.selection);
          }
        }
        return TextField(
          controller: _idIssuerOthersController,
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc!.changeIdOtherIssuer,
          keyboardType: TextInputType.text,
          maxLength: 40,
          maxLines: null,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          decoration: InputDecoration(
            labelText: selectedIdType == STUDENT_ID ?"Name of Institution": 'ID Other Issuer',
            helperText: '* Required',
            errorText: snapshot.error as String?,
          ),
        );
      },
    );
  }

*/

  
  Widget _otherIdIssuerTextField() {
    return StreamBuilder<String?>(
      stream: otherIdIssuerTextFieldStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          if(_idIssuerOthersController.text != snapshot.data.toString()){

          _idIssuerOthersController.text = snapshot.data.toString();
        _idIssuerOthersController.selection = TextSelection.fromPosition(TextPosition(offset: _idIssuerOthersController.text.length));

          }

          /*
          _idIssuerOthersController.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _idIssuerOthersController.selection);
              */
        }
        return TextField(
          controller: _idIssuerOthersController,
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc!.changeIdOtherIssuer,
          keyboardType: TextInputType.text,
          maxLength: 20,
          maxLines: null,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          decoration: InputDecoration(
          labelText: idVal == STUDENT_ID ?"Name of Institution": 'ID Other Issuer',
            helperText: '* Required',
            errorText: snapshot.error as String?,
          ),
        );
      },
    );
  }

  
  
  Widget _admissionNumberTextField() {
    return StreamBuilder<String?>(
      stream: admissionNumberTextFieldStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if(_admissionNoController.text != snapshot.data.toString()){
          _admissionNoController.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _admissionNoController.selection);
          }
        }
        return Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: TextField(
            controller: _admissionNoController,
            textCapitalization: TextCapitalization.characters,
            onChanged: accountFormBloc!.changeAdmissionNo,
            keyboardType: TextInputType.text,
            maxLength: 40,
            maxLines: null,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            decoration: InputDecoration(
              labelText: 'Admission Number',
              helperText: '* Required',
              errorText: snapshot.error as String?,
            ),
          ),
        );
      },
    );
  }



  Widget _idNumberTextField() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.idNumber,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if(_idNumberController.text != snapshot.data.toString()){
          _idNumberController.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _idNumberController.selection);
          }
        }
        return TextField(
          controller: _idNumberController,
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc!.changeIdNumber,
          keyboardType: TextInputType.text,
          maxLength: 20,
          maxLines: null,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          decoration: InputDecoration(
            labelText: 'ID Number',
            helperText: '* Required',
            errorText: snapshot.error as String?,
          ),
        );
      },
    );
  }


  Widget _idPlaceOfIssue() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.idPlaceOfIssue,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidateMode: AutovalidateMode.always,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'ID Place of Issue',
                  errorText: snapshot.error as String?),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.hasData
                      ? Helper.returnValidStateRegionSelectedItem(
                          snapshot.data!, _stateRegion)
                      : null,
                  isDense: true,
                  onChanged: accountFormBloc!.changePlaceOfIssue,
                  items: _stateRegion.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value.toUpperCase(),
                      child: Text(value.toUpperCase()),
                    );
                  }).toList(),
                ),

//                child: StreamBuilder<List<StateEntity>>(
//                    stream: statesBloc.states,
//                    builder: (BuildContext context,
//                        AsyncSnapshot<List<StateEntity>> shot) {
//                      if (!shot.hasData)
//                        return SizedBox(
//                            height: 24.0,
//                            child: Center(child: CircularProgressIndicator()));
//                      return DropdownButton<String>(
//                        value: snapshot.data,
//                        items: shot.data.map((StateEntity value) {
//                          return DropdownMenuItem<String>(
//                            value: value.stateName,
//                            child: Text(value.stateName),
//                          );
//                        }).toList(),
//                        onChanged: accountFormBloc.changePlaceOfIssue,
//
//                        isDense: true, //value: _currentUser,
//                      );
//                    }),
              ),
            );
          },
        );
      },
    );
  }

  // Widget _scan_to_pay_checkBox() {
  //   return StreamBuilder<bool?>(
  //       stream: accountFormBloc!.isScanToPay,
  //       builder: (context, snapshot) {
  //         return CheckboxListTile(
  //           onChanged: accountFormBloc!.changeIsScanToPay,
  //           title: new Text('Scan To Pay'),
  //           controlAffinity: ListTileControlAffinity.leading,
  //           activeColor: Colors.red,
  //           dense: true,
  //           value: snapshot.hasData ? snapshot.data : false,
  //         );
  //       });
  // }

  // Widget _z_mobile_checkBox() {
  //   return StreamBuilder<bool?>(
  //       stream: accountFormBloc!.isZMobile,
  //       builder: (context, snapshot) {
  //         return CheckboxListTile(
  //           onChanged: accountFormBloc!.changeIsZMobile,
  //           title: new Text('Z - Mobile'),
  //           controlAffinity: ListTileControlAffinity.leading,
  //           activeColor: Colors.red,
  //           dense: true,
  //           value: snapshot.hasData ? snapshot.data : false,
  //         );
  //       });
  // }

  // Widget _z_prompt_checkBox() {
  //   return StreamBuilder<bool?>(
  //       stream: accountFormBloc!.isZPrompt,
  //       builder: (context, snapshot) {
  //         return CheckboxListTile(
  //           onChanged: accountFormBloc!.changeIsZPrompt,
  //           title: new Text('Z - Prompt'),
  //           controlAffinity: ListTileControlAffinity.leading,
  //           activeColor: Colors.red,
  //           dense: true,
  //           value: snapshot.hasData ? snapshot.data : false,
  //         );
  //       });
  // }

  // Widget _statement_via_email_CheckBox() {
  //   return StreamBuilder<bool?>(
  //       stream: accountFormBloc!.isStatementViaEmail,
  //       builder: (context, snapshot) {
  //         return CheckboxListTile(
  //           onChanged: accountFormBloc!.changeIsStatementViaEmail,
  //           title: new Text('Statement Via Email'),
  //           controlAffinity: ListTileControlAffinity.leading,
  //           activeColor: Colors.red,
  //           dense: true,
  //           value: snapshot.hasData ? snapshot.data : false,
  //         );
  //       });
  // }

  // Widget _ussd_checkBox() {
  //   return StreamBuilder<bool?>(
  //       stream: accountFormBloc!.isUssd,
  //       builder: (context, snapshot) {
  //         return CheckboxListTile(
  //           onChanged: accountFormBloc!.changeIsUssd,
  //           title: new Text('USSD'),
  //           controlAffinity: ListTileControlAffinity.leading,
  //           activeColor: Colors.red,
  //           dense: true,
  //           value: snapshot.hasData ? snapshot.data : false,
  //         );
  //       });
  // }

  // Widget _bank_to_wallet_checkBox() {
  //   return StreamBuilder<bool?>(
  //       stream: accountFormBloc!.isBankToWallet,
  //       builder: (context, snapshot) {
  //         return CheckboxListTile(
  //           onChanged: accountFormBloc!.changeIsBankToWallet,
  //           title: new Text('Bank to Wallet'),
  //           controlAffinity: ListTileControlAffinity.leading,
  //           activeColor: Colors.red,
  //           dense: true,
  //           value: snapshot.hasData ? snapshot.data : false,
  //         );
  //       });
  // }

  @override
  void dispose() {
    _idTypeController.dispose();
    _idPlaceOfIssueController.dispose();
    _idIssueDateController.dispose();
    _idExpiryDateController.dispose();
    _idNumberController.dispose();
    _idIssuerController.dispose();
    _admissionNoController.dispose();
    _idIssuerOthersController.dispose();
    statesBloc.dispose();
    super.dispose();
  }

  Widget _idIssueDateField() {
    return Visibility(
      visible: 
             _selectedIdFilter == 2 ||
              _selectedIdFilter == 4 
         //   ||  _selectedIdFilter == 3
          ? false
          : true,
      child: StreamBuilder<String?>(
        stream: accountFormBloc!.idIssueDate,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _idIssueDateController.value = TextEditingValue(
                text: snapshot.data.toString(),
                selection: _idIssueDateController.selection);
          }
          return GestureDetector(
              onTap: () async {
                DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: new DateTime(DateTime.now().year - 25),
                    lastDate: new DateTime.now());

                if (picked != null) {
                  var formatter = new DateFormat('dd-MMM-yy');

                  var date = formatter.format(picked);

                  _idIssueDateController.text = date;
                  accountFormBloc!.changeIssueDate(date);
                }
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: _idIssueDateController,
                  onChanged: accountFormBloc!.changeIssueDate,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'ID Issue Date',
                    helperText: "* Required",
                    suffixIcon: Icon(Icons.date_range),
                    errorText: snapshot.error as String?,
                  ),
                ),
              ));
        },
      ),
    );
  }

  Widget _idExpiryDateField() {
    return Visibility(
      visible: 
            _selectedIdFilter == 2 ||
            //  _selectedIdFilter == 1 ||
              _selectedIdFilter == 4 ||
              _selectedIdFilter == 3
          ? false
          : true,
      child: StreamBuilder<String?>(
        stream: accountFormBloc!.idExpiryDate,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _idExpiryDateController.value = TextEditingValue(
                text: snapshot.data.toString(),
                selection: _idExpiryDateController.selection);
          }
          return GestureDetector(
              onTap: () async {
                DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: new DateTime.now(),
                    lastDate: new DateTime(DateTime.now().year + 25));

                if (picked != null) {
                  var formatter = new DateFormat('dd-MMM-yy');

                  var date = formatter.format(picked);

                  _idExpiryDateController.text = date;
                  accountFormBloc!.changeExpiryDate(date);
                }
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: _idExpiryDateController,
                  onChanged: accountFormBloc!.changeExpiryDate,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'ID Expiry Date',
                    helperText: "* Required",
                    suffixIcon: Icon(Icons.date_range),
                    errorText: snapshot.error as String?,
                  ),
                ),
              ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
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
                    Visibility(visible: others, child: SizedBox(height: 30.0)),
                    Visibility(
                        visible: others, child: _otherIdIssuerTextField()),
                    SizedBox(height: 30.0),
                    IntrinsicHeight(
                      child: Column(
                        children: [
                          _idNumberTextField(),
                          Container(
                            alignment: Alignment(1.0, 0.0),
                            height: 60.0,
                            child: OutlinedButton(
                              child: Text('VERIFY ID NUMBER'),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.red.shade900,
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.white,
                                ),
                                side: MaterialStateProperty.all<BorderSide>(
                                  BorderSide(color: Colors.red.shade900),
                                ),
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(
                                  EdgeInsets.all(16),
                                ),
                              ),
                              onPressed: () {
                                var loadingBar = FlushbarHelper.createLoading(
                                    message: "Verifying ID please wait...",
                                    linearProgressIndicator: null);
                                loadingBar..show(context);
                                accountFormBloc!
                                    .verifyNumber(_selectedIdFilter);
                                accountFormBloc!
                                    .driverLicenseVerificationResponse
                                    .listen((response) {
                                  loadingBar.dismiss();
                                  showSuccessVerificationBottomsheet(
                                    context: context,
                                    image: response.photo,
                                    name: CryptoHelper.decrypt(
                                        response.fullName!),
                                  );
                                }).onError((error) {
                                  loadingBar.dismiss();
                                  if (_selectedIdFilter == 0) {
                                    FlushbarHelper.createError(
                                        message:
                                            "Driver License provided could not be verified.")
                                      ..show(context);
                                  } else if (_selectedIdFilter == 1) {
                                    FlushbarHelper.createError(
                                        message:
                                            "The Passport number provided could not be verified.")
                                      ..show(context);
                                  } else if (_selectedIdFilter == 2) {
                                    FlushbarHelper.createError(
                                        message:
                                            "SSNIT number provided could not be verified.")
                                      ..show(context);
                                  } else if (_selectedIdFilter == 3) {
                                    FlushbarHelper.createError(
                                        message:
                                            "Voters card number provided could not be verified.")
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
              
                   Visibility(
                        visible: showAdmNo
                        , child: _admissionNumberTextField()),
                 
                    SizedBox(height: 30.0),
                    _idPlaceOfIssue(),
                    SizedBox(height: 30.0),
                    _idIssueDateField(),
                    SizedBox(height: 30.0),
                    _idExpiryDateField(),
                    // SizedBox(height: 30.0),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     'Select the E-products available to this account.',
                    //     style: Theme.of(context).textTheme.caption,
                    //     textAlign: TextAlign.start,
                    //   ),
                    // ),
                    // _scan_to_pay_checkBox(),
                    // _z_mobile_checkBox(),
                    // _z_prompt_checkBox(),
                    // _statement_via_email_CheckBox(),
                    // _ussd_checkBox(),
                    // _bank_to_wallet_checkBox(),
                  ],
                ),
                SizedBox(height: 120.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getImagenBase64(String? imagen) {
    var _imageBase64 = imagen;
    const Base64Codec base64 = Base64Codec();
    if (_imageBase64 == null) return new Container();
    var bytes = base64.decode(_imageBase64);
    return Image.memory(
      bytes,
      fit: BoxFit.fitWidth,
    );
  }

  showSuccessVerificationBottomsheet(
      {required BuildContext context,
      required String? image,
      required String name}) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(16.0)),
        ),
        builder: (context) {
          return GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 32,
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 18),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Text(
                      'The ID number provided is valid',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .apply(color: Colors.green, fontWeightDelta: 2),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: LimitedBox(
                    maxHeight: 300,
                    maxWidth: 350,
                    child: Container(
                      color: Colors.transparent,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: getImagenBase64(image))),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "$name",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
              ],
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;

  act() {}
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zxplore_app/blocs/account_form_bloc.dart';
import 'package:zxplore_app/blocs/provider.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/models/card_type_model.dart';
import 'package:zxplore_app/utils/preferences.dart';

class EProductsStep extends StatefulWidget {
  const EProductsStep({Key? key}) : super(key: key);

  @override
  _EProductsStepState createState() => _EProductsStepState();
}

class _EProductsStepState extends State<EProductsStep>
    with AutomaticKeepAliveClientMixin<EProductsStep> {
  AccountFormBloc? accountFormBloc;
  Preference? prefs;
  // List<String> _cardTypes = ["MASTER CARD", "VISA", "VERVE"];
  List<String> _cardTypes = [
    "VISA DEBIT", "VISA PREPAID",
     "VISA CREDIT","MASTERCARD DEBIT",
     "MASTERCARD PREPAID", "MASTERCARD CREDIT",
     "EASYPAY DUAL GH-LINK CARD"
     ];

  TextEditingController? _requestingBranchController;
  TextEditingController? _destinationBranchController;
  TextEditingController? _preferredNameOnCardController;

  var scanToPayCheckBoxStream,zMobileCheckBoxStream,zPromptCheckBoxStream;

   

  @override
  void initState() {
    super.initState();
    prefs = Preference();
    accountFormBloc = BlocProvider.of<AccountFormBloc>(context);
    _requestingBranchController = TextEditingController();
    _destinationBranchController = TextEditingController();
    _preferredNameOnCardController = TextEditingController();

    scanToPayCheckBoxStream = accountFormBloc!.changeIsScanToPay;
    zMobileCheckBoxStream =accountFormBloc!.isZMobile;
    zPromptCheckBoxStream = accountFormBloc!.isZPrompt;


    setCardTypes();
  }

  @override
  void dispose() {
    _requestingBranchController!.dispose();
    _destinationBranchController!.dispose();
    _preferredNameOnCardController!.dispose();

    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  void setCardTypes() async {
    await prefs!.load();
    final json = prefs!.getString("CARDTYPES");
    final newCardTypes = cardTypeFromJson(json).menu;
    if (newCardTypes != null) {
      _cardTypes = newCardTypes;
    }
  }

  Widget _scanToPayCheckBox() {
    return StreamBuilder<bool?>(
      stream: accountFormBloc!.isScanToPay,
      builder: (context, snapshot) {

        return CheckboxListTile(
          onChanged: scanToPayCheckBoxStream,
          title: new Text('Scan To Pay'),
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Colors.red,
          dense: true,
          value: snapshot.hasData ? snapshot.data : false,
        );
      },
    );
  }

  Widget _zMobileCheckBox() {
    return StreamBuilder<bool?>(
      stream: zMobileCheckBoxStream,
      builder: (context, snapshot) {
      
        return CheckboxListTile(
          onChanged: accountFormBloc!.changeIsZMobile,
          title: new Text('Z - Mobile'),
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Colors.red,
          dense: true,
          value:  snapshot.hasData ? snapshot.data : false,
        );
      },
    );
  }

  Widget _zPromptCheckBox() {
    return StreamBuilder<bool?>(
      stream: zPromptCheckBoxStream,
      builder: (context, snapshot) {
        return CheckboxListTile(
          onChanged: accountFormBloc!.changeIsZPrompt,
          title: new Text('Z - Prompt'),
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Colors.red,
          dense: true,
          value: snapshot.hasData ? snapshot.data : false,
        );
      },
    );
  }

  Widget _statementViaEmailCheckBox() {
    return StreamBuilder<bool?>(
      stream: accountFormBloc!.isStatementViaEmail,
      builder: (context, snapshot) {
         if(snapshot.hasData){
              int g=10;
              int sum = g+20;
        }
        return CheckboxListTile(
          onChanged: accountFormBloc!.changeIsStatementViaEmail,
          title: new Text('Statement Via Email'),
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Colors.red,
          dense: true,
          value: snapshot.hasData ? snapshot.data : false,
        );
      },
    );
  }
bool aa =false;
  Widget _ussdCheckBox() {
    return StreamBuilder<bool?>(
      stream: accountFormBloc!.isUssd,
      builder: (context, snapshot) {
        return CheckboxListTile(
          onChanged: accountFormBloc!.changeIsUssd,
          title: new Text('USSD'),
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Colors.red,
          dense: true,
          value: snapshot.hasData ? snapshot.data : false,
        );
      },
    );
  }

  Widget _bankToWalletCheckBox() {
    return StreamBuilder<bool?>(
      stream: accountFormBloc!.isBankToWallet,
      builder: (context, snapshot) {
        return CheckboxListTile(
          onChanged: accountFormBloc!.changeIsBankToWallet,
          title: new Text('Bank to Wallet'),
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Colors.red,
          dense: true,
          value: snapshot.hasData ? snapshot.data : false,
        );
      },
    );
  }

  Widget _cardRequestCheckBox() {
    return StreamBuilder<bool?>(
      stream: accountFormBloc!.isCardRequest,
      builder: (context, snapshot) {
        return CheckboxListTile(
          onChanged: accountFormBloc!.changeIsCardRequest,
          title: new Text('Request For Cards'),
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Colors.red,
          dense: true,
          value: snapshot.hasData ? snapshot.data : false,
        );
      },
    );
  }

  Widget _cardTypeDropdownField() {
    return StreamBuilder<bool?>(
      stream: accountFormBloc!.isCardRequest,
      builder: (context, boolSnapshot) {
        if (boolSnapshot.hasData && boolSnapshot.data!) {
          return StreamBuilder<String?>(
            stream: accountFormBloc!.cardType,
            builder: (context, snapshot) {
              return FormField<String>(
                autovalidateMode: AutovalidateMode.always,
                builder: (FormFieldState<String> state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Card Type',
                        helperText: "* Required",
                        errorText: snapshot.error as String?,
                      ),
                      isEmpty: snapshot.data == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: snapshot.data,
                          isDense: true,
                          onChanged: accountFormBloc!.changeCardType,
                          items: _cardTypes.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
        return SizedBox();
      },
    );
  }

  Widget _requestingBranchTextField() {
    return StreamBuilder<bool?>(
      stream: accountFormBloc!.isCardRequest,
      builder: (context, boolSnapshot) {
        if (boolSnapshot.hasData && boolSnapshot.data!) {
          return StreamBuilder<String?>(
            stream: accountFormBloc!.requestingBranch,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if(_requestingBranchController!.text != snapshot.data.toString()){
                _requestingBranchController!.value = TextEditingValue(
                  text: snapshot.data.toString(),
                  selection: _requestingBranchController!.selection,
                );
                }
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: _requestingBranchController,
                  textCapitalization: TextCapitalization.characters,
                  keyboardType: TextInputType.text,
                  onChanged: accountFormBloc!.changeRequestingBranch,
                  maxLength: 50,
                  maxLines: null,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: InputDecoration(
                    labelText: 'Requesting Branch',
                    helperText: '* Required',
                    errorText: snapshot.error as String?,
                  ),
                ),
              );
            },
          );
        }
        return SizedBox();
      },
    );
  }

  Widget _destinationBranchTextField() {
    return StreamBuilder<bool?>(
      stream: accountFormBloc!.isCardRequest,
      builder: (context, boolSnapshot) {
        if (boolSnapshot.hasData && boolSnapshot.data!) {
          return StreamBuilder<String?>(
            stream: accountFormBloc!.destinationBranch,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if(_destinationBranchController!.text != snapshot.data.toString()){
                _destinationBranchController!.value = TextEditingValue(
                  text: snapshot.data.toString(),
                  selection: _destinationBranchController!.selection,
                );
                }
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: _destinationBranchController,
                  textCapitalization: TextCapitalization.characters,
                  keyboardType: TextInputType.text,
                  onChanged: accountFormBloc!.changeDestinationBranch,
                  maxLength: 50,
                  maxLines: null,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: InputDecoration(
                    labelText: 'Destination Branch',
                    helperText: '* Required',
                    errorText: snapshot.error as String?,
                  ),
                ),
              );
            },
          );
        }
        return SizedBox();
      },
    );
  }

  Widget _preferredNameOnCardTextField() {
    return StreamBuilder<bool?>(
      stream: accountFormBloc!.isCardRequest,
      builder: (context, boolSnapshot) {
        if (boolSnapshot.hasData && boolSnapshot.data!) {
          return StreamBuilder<String?>(
            stream: accountFormBloc!.preferredNameOnCard,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if(_preferredNameOnCardController!.text != snapshot.data.toString()){
                _preferredNameOnCardController!.value = TextEditingValue(
                  text: snapshot.data.toString(),
                  selection: _preferredNameOnCardController!.selection,
                );
                }
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: _preferredNameOnCardController,
                  textCapitalization: TextCapitalization.characters,
                  keyboardType: TextInputType.text,
                  onChanged: accountFormBloc!.changePreferredNameOnCard,
                  maxLength: 50,
                  maxLines: null,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: InputDecoration(
                    labelText: 'Preferred Name On Card',
                    helperText: '* Required',
                    errorText: snapshot.error as String?,
                  ),
                ),
              );
            },
          );
        }
        return SizedBox();
      },
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
            children: [
              SizedBox(height: 16.0),
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select the E-products available to this account.',
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  _scanToPayCheckBox(),
                  _zMobileCheckBox(),
                  _zPromptCheckBox(),
                  _statementViaEmailCheckBox(),
                  _ussdCheckBox(),
                  _bankToWalletCheckBox(),
                  _cardRequestCheckBox(),
                  selectAllButton(),

                  _cardTypeDropdownField(),
                  _requestingBranchTextField(),
                  _destinationBranchTextField(),
                  _preferredNameOnCardTextField(),
                  
                ],
              ),
              SizedBox(height: 120.0),
            ],
          ),
        )),
      ),
    );
  }

  Widget selectAllButton()=> Align(
                      alignment: Alignment.topRight,
                    child: TextButton(  
                  child: Text('Select All', style: TextStyle(fontSize: 14.0, color: ZxplorePrimaryColor),),  
                  style: ButtonStyle(),
                  onPressed: () {
                    accountFormBloc!.changeIsScanToPay(true);
                    accountFormBloc!.changeIsZMobile(true);
                    accountFormBloc!.changeIsZPrompt(true);
                    accountFormBloc!.changeIsStatementViaEmail(true);
                    accountFormBloc!.changeIsUssd(true);
                    accountFormBloc!.changeIsBankToWallet(true);
                    accountFormBloc!.changeIsCardRequest(true);
                    
                                      },  
                ),
  );

}

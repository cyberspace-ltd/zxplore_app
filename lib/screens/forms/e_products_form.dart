import 'package:flutter/material.dart';
import 'package:zxplore_app/blocs/account_form_bloc.dart';
import 'package:zxplore_app/blocs/provider.dart';

class EProductsStep extends StatefulWidget {
  const EProductsStep({Key? key}) : super(key: key);

  @override
  _EProductsStepState createState() => _EProductsStepState();
}

class _EProductsStepState extends State<EProductsStep>
    with AutomaticKeepAliveClientMixin<EProductsStep> {
  AccountFormBloc? accountFormBloc;

  @override
  void initState() {
    super.initState();
    accountFormBloc = BlocProvider.of<AccountFormBloc>(context);
  }

  @override
  bool get wantKeepAlive => true;

  Widget _scan_to_pay_checkBox() {
    return StreamBuilder<bool?>(
        stream: accountFormBloc!.isScanToPay,
        builder: (context, snapshot) {
          return CheckboxListTile(
            onChanged: accountFormBloc!.changeIsScanToPay,
            title: new Text('Scan To Pay'),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.red,
            dense: true,
            value: snapshot.hasData ? snapshot.data : false,
          );
        });
  }

  Widget _z_mobile_checkBox() {
    return StreamBuilder<bool?>(
        stream: accountFormBloc!.isZMobile,
        builder: (context, snapshot) {
          return CheckboxListTile(
            onChanged: accountFormBloc!.changeIsZMobile,
            title: new Text('Z - Mobile'),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.red,
            dense: true,
            value: snapshot.hasData ? snapshot.data : false,
          );
        });
  }

  Widget _z_prompt_checkBox() {
    return StreamBuilder<bool?>(
        stream: accountFormBloc!.isZPrompt,
        builder: (context, snapshot) {
          return CheckboxListTile(
            onChanged: accountFormBloc!.changeIsZPrompt,
            title: new Text('Z - Prompt'),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.red,
            dense: true,
            value: snapshot.hasData ? snapshot.data : false,
          );
        });
  }

  Widget _statement_via_email_CheckBox() {
    return StreamBuilder<bool?>(
        stream: accountFormBloc!.isStatementViaEmail,
        builder: (context, snapshot) {
          return CheckboxListTile(
            onChanged: accountFormBloc!.changeIsStatementViaEmail,
            title: new Text('Statement Via Email'),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.red,
            dense: true,
            value: snapshot.hasData ? snapshot.data : false,
          );
        });
  }

  Widget _ussd_checkBox() {
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
        });
  }

  Widget _bank_to_wallet_checkBox() {
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
        });
  }

  @override
  void dispose() {
    super.dispose();
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
                  _scan_to_pay_checkBox(),
                  _z_mobile_checkBox(),
                  _z_prompt_checkBox(),
                  _statement_via_email_CheckBox(),
                  _ussd_checkBox(),
                  _bank_to_wallet_checkBox(),
                ],
              ),
              SizedBox(height: 120.0),
            ],
          ),
        )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:zxplore_app/blocs/account_class_bloc.dart';
import 'package:zxplore_app/blocs/account_form_bloc.dart';
import 'package:zxplore_app/blocs/occupations_bloc.dart';
import 'package:zxplore_app/blocs/provider.dart';
import 'package:zxplore_app/data/entities/account_class_entity.dart';
import 'package:zxplore_app/models/account_type.dart';

class AccountInformationStep extends StatefulWidget {
  @override
  _AccountInformationState createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformationStep>
    with AutomaticKeepAliveClientMixin<AccountInformationStep> {
  AccountFormBloc accountFormBloc;
  AccountClassBloc _accountClassBloc;

  @override
  bool get wantKeepAlive => true;

  final _accountTypes = [
    'SAVINGS ACCOUNT',
    'CURRENT ACCOUNT',
  ];

  final _accountHolderTypes = [
    'INDIVIDUAL',
  ];

  final _riskRanks = [
    'HIGH',
    'LOW',
    'MEDIUM',
  ];

  @override
  void dispose() {
    _accountClassBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    accountFormBloc = BlocProvider.of<AccountFormBloc>(context);
    _accountClassBloc = AccountClassBloc();
    _accountClassBloc.getAccountClasses();
  }

  Widget accountTypeField() {
    return StreamBuilder(
      stream: accountFormBloc.accountType,
      builder: (context, snapshot) {
        return FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Account Type',
                  helperText: "* Required",
                  errorText: snapshot.error),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.data,
                  isDense: true,
                  items: _accountTypes.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: accountFormBloc.changeAccountType,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget accountHolderTypeField() {
    return StreamBuilder(
      stream: accountFormBloc.accountHolderType,
      builder: (context, snapshot) {
        return FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Account Holder Type',
                  helperText: "* Required",
                  errorText: snapshot.error),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.data,
                  isDense: true,
                  onChanged: accountFormBloc.changeHolderType,
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
    return StreamBuilder(
      stream: accountFormBloc.riskRankType,
      builder: (context, snapshot) {
        return FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Risk Rank',
                  helperText: "* Required",
                  errorText: snapshot.error),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.data,
                  isDense: true,
                  onChanged: accountFormBloc.changeRiskRank,
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
    return StreamBuilder(
      stream: accountFormBloc.accountCategoryType,
      builder: (context, snapshot) {
        return FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Account Category',
                  helperText: "* Required",
                  errorText: snapshot.error),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: StreamBuilder<List<AccountClassEntity>>(
                    stream: _accountClassBloc.accountClasses,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<AccountClassEntity>> shot) {
                      if (!shot.hasData)
                        return SizedBox(
                            height: 24.0,
                            child: Center(child: CircularProgressIndicator()));
                      return DropdownButton<String>(
                        value: snapshot.data,
                        items: shot.data.map((AccountClassEntity value) {
                          return DropdownMenuItem<String>(
                            value: value.id.toString(),
                            child: Text(value.name,style: TextStyle(fontSize: 14.0),),
                          );
                        }).toList(),
                        onChanged: accountFormBloc.changeAccountCategory,
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
                  accountTypeField(),
                  SizedBox(height: 30.0),
                  accountHolderTypeField(),
                  SizedBox(height: 30.0),
                  riskRankField(),
                  SizedBox(height: 30.0),
                  _accountCategoryField()
                ],
              ),
              SizedBox(height: 60.0),
            ],
          ),
        ),
      ),
    );
  }

  static List<AccountType> getAccountTypes() {
    return [
      AccountType(
        description: "SAVINGS ACCOUNT",
        classType: "SA",
      ),
      AccountType(
        description: "CURRENT ACCOUNT",
        classType: "CA",
      )
    ];
  }
}

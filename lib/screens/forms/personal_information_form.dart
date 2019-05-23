import 'package:flutter/material.dart';
import 'package:zxplore_app/blocs/account_form_bloc.dart';
import 'package:zxplore_app/blocs/countries_bloc.dart';
import 'package:zxplore_app/blocs/provider.dart';
import 'package:intl/intl.dart';
import 'package:zxplore_app/blocs/states_bloc.dart';
import 'package:zxplore_app/data/entities/country_entity.dart';
import 'package:zxplore_app/data/entities/state_entity.dart';

import '../../colors.dart';

class PersonalInformationStep extends StatefulWidget {
  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformationStep>
    with AutomaticKeepAliveClientMixin<PersonalInformationStep> {
  final TextEditingController _dateOfBirthController = TextEditingController();

  final _titles = [
    'Miss',
    'Dr.',
    'Prof.',
    'Rev.',
    'Chief',
    'Mr.',
    'Barrister',
    'Pastor',
    'Otunba',
    'Mrs',
    'Engr',
    'Alhaji',
    'Alhaja',
    'Mr & Mrs',
    'Dr. & Mrs.',
    'Hon Just.'
  ];

  AccountFormBloc accountFormBloc;

  CountriesBloc countriesBloc;

  StatesBloc statesBloc;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    countriesBloc = CountriesBloc();
    statesBloc = StatesBloc();
    accountFormBloc = BlocProvider.of<AccountFormBloc>(context);
  }

  @override
  void dispose() {
    statesBloc.dispose();
    countriesBloc.dispose();

    super.dispose();
  }

  Widget titleTextField() {
    return StreamBuilder(
      stream: accountFormBloc.title,
      builder: (context, snapshot) {
        return FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Title',
                  helperText: "* Required",
                  errorText: snapshot.error),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.data,
                  isDense: true,
                  onChanged: accountFormBloc.changeTitle,
                  items: _titles.map((String value) {
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

  Widget _bvnField() {
    return StreamBuilder(
        stream: accountFormBloc.bvn,
        builder: (context, snapshot) {
          return TextField(
            obscureText: true,
            keyboardType: TextInputType.number,
            onChanged: accountFormBloc.changeBvn,
            decoration: InputDecoration(
              labelText: 'BVN',
              helperText: 'Click the verify BVN button to populate account form.',
              errorText: snapshot.error,
            ),
          );
        });
  }

  Widget _surnameField() {
    return StreamBuilder(
      stream: accountFormBloc.surname,
      builder: (context, snapshot) {
        return TextField(
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc.changeSurname,
          keyboardType: TextInputType.text,
          maxLength: 40,
          maxLines: null,
          maxLengthEnforced: true,
          decoration: InputDecoration(
            labelText: 'Surname',
            helperText: '* Required',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget _firstNameField() {
    return StreamBuilder(
      stream: accountFormBloc.firstName,
      builder: (context, snapshot) {
        return TextField(
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc.changeFirstName,
          keyboardType: TextInputType.text,
          maxLength: 40,
          maxLines: null,
          maxLengthEnforced: true,
          decoration: InputDecoration(
            labelText: 'First Name',
            helperText: '* Required',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget _otherNameField() {
    return StreamBuilder(
      builder: (context, snapshot) {
        return TextField(
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc.changeOtherName,
          keyboardType: TextInputType.text,
          maxLength: 40,
          maxLines: null,
          maxLengthEnforced: true,
          decoration: InputDecoration(
            labelText: 'Other Name',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget _mothersMaidenNameField() {
    return StreamBuilder(
      stream: accountFormBloc.mothersMaidenName,
      builder: (context, snapshot) {
        return TextField(
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc.changeMothersMaidenName,
          keyboardType: TextInputType.text,
          maxLength: 40,
          maxLines: null,
          maxLengthEnforced: true,
          decoration: InputDecoration(
            labelText: 'Mother\'s Maiden Name',
            helperText: '* Required',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget _dateOfBirthField() {
    return StreamBuilder(
      stream: accountFormBloc.dateOfBirth,
      builder: (context, snapshot) {
        return GestureDetector(
            onTap: () async {
              DateTime picked = await showDatePicker(
                  context: context,
                  initialDate: new DateTime(DateTime.now().year - 19),
                  firstDate: new DateTime(1900),
                  lastDate: new DateTime(DateTime.now().year - 19));

              if (picked != null) {

                var dob =
                    new DateFormat.yMMMd().format(picked);

                _dateOfBirthController.text = dob;
                accountFormBloc.changeDateOfBirth(dob);
              }
            },
            child: AbsorbPointer(
              child: TextField(
                controller: _dateOfBirthController,
                onChanged: accountFormBloc.changeDateOfBirth,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  helperText: "* Required",
                  suffixIcon: Icon(Icons.date_range),
                  errorText: snapshot.error,
                ),
              ),
            ));
      },
    );
  }

  Widget _stateOfOriginTextField() {
    return StreamBuilder(
      stream: accountFormBloc.stateOfOrigin,
      builder: (context, snapshot) {
        return FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'State of Origin',
                  helperText: "* Required",
                  errorText: snapshot.error),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: StreamBuilder<List<StateEntity>>(
                    stream: statesBloc.states,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<StateEntity>> shot) {
                      if (!shot.hasData) return CircularProgressIndicator();
                      return DropdownButton<String>(
                        value: snapshot.data,
                        items: shot.data.map((StateEntity value) {
                          return DropdownMenuItem<String>(
                            value: value.name,
                            child: Text(value.name),
                          );
                        }).toList(),
                        onChanged: accountFormBloc.changeStateOfOrigin,

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

  Widget _countryOfOriginTextField() {
    return StreamBuilder(
      stream: accountFormBloc.countryOfOrigin,
      builder: (context, snapshot) {
        return FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Country of Origin',
                  helperText: "* Required",
                  errorText: snapshot.error),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: StreamBuilder<List<CountryEntity>>(
                    stream: countriesBloc.countries,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<CountryEntity>> shot) {
                      if (!shot.hasData) return CircularProgressIndicator();
                      return DropdownButton<String>(
                        value: snapshot.data,
                        items: shot.data.map((CountryEntity value) {
                          return DropdownMenuItem<String>(
                            value: value.name,
                            child: Text(value.name),
                          );
                        }).toList(),
                        onChanged: accountFormBloc.changeCountryOfOrigin,

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
                  IntrinsicHeight(
                    child: Column(
                      children: <Widget>[
                        _bvnField(),
                        Container(
                          alignment: Alignment(1.0, 0.0),
                          height: 60.0,
                          child: OutlineButton(
                            child: Text('VERIFY BVN'),
                            textColor: ZxplorePrimaryColor,
                            color: Colors.transparent,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  titleTextField(),
                  SizedBox(height: 30.0),
                  _surnameField(),
                  SizedBox(height: 30.0),
                  _firstNameField(),
                  SizedBox(height: 30.0),
                  _otherNameField(),
                  SizedBox(height: 30.0),
                  _mothersMaidenNameField(),
                  SizedBox(height: 30.0),
                  _dateOfBirthField(),
                  SizedBox(height: 30.0),
                  _stateOfOriginTextField(),
                  SizedBox(height: 30.0),
                  _countryOfOriginTextField(),
                ],
              ),
              SizedBox(height: 60.0),
            ],
          ),
        ),
      ),
    );
  }
}

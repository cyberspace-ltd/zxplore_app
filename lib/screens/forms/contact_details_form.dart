import 'package:flutter/material.dart';
import 'package:zxplore_app/blocs/account_form_bloc.dart';
import 'package:zxplore_app/blocs/cities_bloc.dart';
import 'package:zxplore_app/blocs/countries_bloc.dart';
import 'package:zxplore_app/blocs/occupations_bloc.dart';
import 'package:zxplore_app/blocs/provider.dart';
import 'package:zxplore_app/blocs/states_bloc.dart';
import 'package:zxplore_app/data/entities/city_entity.dart';
import 'package:zxplore_app/data/entities/country_entity.dart';
import 'package:zxplore_app/data/entities/occupation_entity.dart';
import 'package:zxplore_app/data/entities/state_entity.dart';

class ContactDetailsStep extends StatefulWidget {
  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetailsStep>
    with AutomaticKeepAliveClientMixin<ContactDetailsStep> {
  AccountFormBloc accountFormBloc;
  OccupationsBloc _occupationsBloc;
  CountriesBloc _countriesBloc;
  StatesBloc statesBloc;
  CitiesBloc _citiesBloc;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _countriesBloc = CountriesBloc();
    _occupationsBloc = OccupationsBloc();
    statesBloc = StatesBloc();
    _citiesBloc = CitiesBloc();
    accountFormBloc = BlocProvider.of<AccountFormBloc>(context);
    _occupationsBloc.getOccupations();
  }

  @override
  void dispose() {
    statesBloc.dispose();
    _countriesBloc.dispose();
    _occupationsBloc.dispose();
    _citiesBloc.dispose();
    super.dispose();
  }

  final TextEditingController _countryOfResidenceController =
      TextEditingController();
  final TextEditingController _stateOfResidenceController =
      TextEditingController();
  final TextEditingController _cityOfResidenceController =
      TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  final TextEditingController _occupationController = TextEditingController();

  final TextEditingController _maritalStatusController =
      TextEditingController();


  final _genders = ['MALE', 'FEMALE'];

  final _maritalStatus = ['SINGLE', 'MARRIED', 'SEPERATED', 'DIVORCED'];


  Widget _emailTextField() {
    return StreamBuilder(
        stream: accountFormBloc.email,
        builder: (context, snapshot) {
          return TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: accountFormBloc.changeEmail,
            maxLength: 40,
            maxLines: null,
            maxLengthEnforced: true,
            decoration: InputDecoration(
              labelText: 'Email',
              errorText: snapshot.error,
            ),
          );
        });
  }

  Widget _phoneTextField() {
    return StreamBuilder(
        stream: accountFormBloc.phoneNumber,
        builder: (context, snapshot) {
          return TextField(
            keyboardType: TextInputType.phone,
            onChanged: accountFormBloc.changePhone,
            decoration: InputDecoration(
              labelText: 'Phone',
              prefixText: '+234',
              helperText: "* Required",
              errorText: snapshot.error,
            ),
          );
        });
  }

  Widget _nextOfKinTextField() {
    return StreamBuilder(
        stream: accountFormBloc.nextOfKin,
        builder: (context, snapshot) {
          return TextField(
            textCapitalization: TextCapitalization.characters,
            keyboardType: TextInputType.text,
            onChanged: accountFormBloc.changeNextOfKin,
            maxLength: 50,
            maxLines: null,
            maxLengthEnforced: true,
            decoration: InputDecoration(
              labelText: 'Next of Kin',
              helperText: '* Required',
              errorText: snapshot.error,
            ),
          );
        });
  }

  Widget _address1TextField() {
    return StreamBuilder(
        stream: accountFormBloc.address1,
        builder: (context, snapshot) {
          return TextField(
            textCapitalization: TextCapitalization.characters,
            keyboardType: TextInputType.multiline,
            onChanged: accountFormBloc.changeAddress1,
            maxLength: 40,
            maxLines: null,
            maxLengthEnforced: true,
            decoration: InputDecoration(
              labelText: 'Address 1',
              helperText: '* Required',
              errorText: snapshot.error,
            ),
          );
        });
  }

  Widget _address2TextField() {
    return StreamBuilder(builder: (context, snapshot) {
      return TextField(
        textCapitalization: TextCapitalization.characters,
        keyboardType: TextInputType.multiline,
        onChanged: accountFormBloc.changeAddress2,
        maxLength: 40,
        maxLengthEnforced: true,
        decoration: InputDecoration(
          labelText: 'Address 2',
          errorText: snapshot.error,
        ),
      );
    });
  }

  Widget _countryOfResidenceTextField() {
    return StreamBuilder(
      stream: accountFormBloc.countryOfResidence,
      builder: (context, snapshot) {
        return FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Country Of Residence',
                  helperText: "* Required",
                  errorText: snapshot.error),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: StreamBuilder<List<CountryEntity>>(
                    stream: _countriesBloc.countries,
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
                        onChanged: accountFormBloc.changeCountryOfResidence,

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

  Widget _stateOfResidenceTextField() {
    return StreamBuilder(
      stream: accountFormBloc.stateOfResidence,
      builder: (context, snapshot) {
        return FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'State Of Residence',
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
                        onChanged: accountFormBloc.changeStateOfResidence,

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

  Widget _cityOfResidenceTextField() {
    return StreamBuilder(
      stream: accountFormBloc.cityOfResidence,
      builder: (context, snapshot) {
        return FormField<String>(
          builder: (FormFieldState<String> city) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'City Of Residence',
                  helperText: "* Required",
                  errorText: snapshot.error),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: StreamBuilder<List<CityEntity>>(
                    stream: _citiesBloc.cities,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<CityEntity>> shot) {
                      if (!shot.hasData) return CircularProgressIndicator();
                      return DropdownButton<String>(
                        value: snapshot.data,
                        items: shot.data.map((CityEntity value) {
                          return DropdownMenuItem<String>(
                            value: value.name,
                            child: Text(value.name),
                          );
                        }).toList(),
                        onChanged: accountFormBloc.changeCityOfResidence,

                        isDense: true,
                      );
                    }),
              ),
            );
          },
        );
      },
    );
  }




  Widget _genderTextField() {
    return StreamBuilder(
      stream: accountFormBloc.gender,
      builder: (context, snapshot) {
        return FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Gender',
                  helperText: "* Required",
                  errorText: snapshot.error),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.data,
                  isDense: true,
                  onChanged: accountFormBloc.changeGender,
                  items: _genders.map((String value) {
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

  Widget _occupationField() {
    return StreamBuilder(
      stream: accountFormBloc.occupation,
      builder: (context, snapshot) {
        return FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Occupation',
                  helperText: "* Required",
                  errorText: snapshot.error),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: StreamBuilder<List<OccupationEntity>>(
                    stream: _occupationsBloc.occupations,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<OccupationEntity>> shot) {
                      if (!shot.hasData) return CircularProgressIndicator();
                      return DropdownButton<String>(
                        value: snapshot.data,
                        items: shot.data.map((OccupationEntity value) {
                          return DropdownMenuItem<String>(
                            value: value.name,
                            child: Text(value.name),
                          );
                        }).toList(),
                        onChanged: accountFormBloc.changeOccupation,

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

  Widget _maritalStatusField() {
    return StreamBuilder(
      stream: accountFormBloc.maritalStatus,
      builder: (context, snapshot) {
        return FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Marital Status',
                  helperText: "* Required",
                  errorText: snapshot.error),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.data,
                  isDense: true,
                  onChanged: accountFormBloc.changeMaritalStatus,
                  items: _maritalStatus.map((String value) {
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
                  _emailTextField(),
                  SizedBox(height: 30.0),
                  _phoneTextField(),
                  SizedBox(height: 30.0),
                  _nextOfKinTextField(),
                  SizedBox(height: 30.0),
                  _address1TextField(),
                  SizedBox(height: 30.0),
                  _address2TextField(),
                  SizedBox(height: 30.0),
                  _countryOfResidenceTextField(),
                  SizedBox(height: 30.0),
                  _stateOfResidenceTextField(),
                  SizedBox(height: 30.0),
                  _cityOfResidenceTextField(),
                  SizedBox(height: 30.0),
                  _genderTextField(),
                  SizedBox(height: 30.0),
                  _occupationField(),
                  SizedBox(height: 30.0),
                  _maritalStatusField(),
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

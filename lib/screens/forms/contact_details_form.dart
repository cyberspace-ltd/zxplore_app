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
import 'package:zxplore_app/generated/i18n.dart';
import 'package:zxplore_app/utils/helper_functions.dart';
import 'package:flushbar/flushbar.dart';

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
  String _selectedAccFilter = "";

  @override
  bool get wantKeepAlive => true;

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

  final _maritalStatus = ['SINGLE', 'MARRIED', 'SEPARATED', 'DIVORCED'];

  List<String> _stateRegion = ['Ahafo Region','Ashanti Region','Bono Region','Bono East Region', 'Central Region', 'Eastern Region','Greater Accra Region','Northern Region',
  'North East Region','Oti Region','Savannah Region','Upper East Region','Upper West Region','Volta Region','Western Region','Western North Region'];
  TextEditingController _emailController;
  TextEditingController _phoneController;
  TextEditingController _nextOfKinController;
  TextEditingController _address1Controller;
  TextEditingController _address2Controller;

  @override
  void initState() {
    super.initState();
    _countriesBloc = CountriesBloc();
    _occupationsBloc = OccupationsBloc();
    statesBloc = StatesBloc();
    statesBloc.getStates();
    _citiesBloc = CitiesBloc();
    accountFormBloc = BlocProvider.of<AccountFormBloc>(context);
    _occupationsBloc.getOccupations();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _nextOfKinController = TextEditingController();
    _address1Controller = TextEditingController();
    _address2Controller = TextEditingController();
  }

  @override
  void dispose() {
    statesBloc.dispose();
    _countriesBloc.dispose();
    _occupationsBloc.dispose();
    _citiesBloc.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nextOfKinController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    super.dispose();
  }

  Widget _emailTextField() {
    return StreamBuilder(
        stream: accountFormBloc.email,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _emailController.value = TextEditingValue(
                text: snapshot.data.toString(),
                selection: _emailController.selection);
          }

          return TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: accountFormBloc.changeEmail,
            maxLength: 40,
//            enabled: accountFormBloc.bvnEmail,
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
          if (snapshot.hasData) {
            _phoneController.value = TextEditingValue(
                text: snapshot.data.toString(),
                selection: _phoneController.selection);
          }
          return TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            onChanged: accountFormBloc.changePhone,
            maxLength: 11,
//            enabled: accountFormBloc.bvnPhone,
            decoration: InputDecoration(
              labelText: 'Phone',
              prefixText: '+233',
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
          if (snapshot.hasData) {
            _nextOfKinController.value = TextEditingValue(
                text: snapshot.data.toString(),
                selection: _nextOfKinController.selection);
          }

          return TextField(
            controller: _nextOfKinController,
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
          if (snapshot.hasData) {
            _address1Controller.value = TextEditingValue(
                text: snapshot.data.toString(),
                selection: _address1Controller.selection);
          }
          return TextField(
            controller: _address1Controller,
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
    return StreamBuilder(
        stream: accountFormBloc.address2,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _address2Controller.value = TextEditingValue(
                text: snapshot.data.toString(),
                selection: _address2Controller.selection);
          }
          return TextField(
            controller: _address2Controller,
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
                      if (!shot.hasData)
                        return SizedBox(
                            height: 24.0,
                            child: Center(child: CircularProgressIndicator()));

                      //TODO: HAND CODED COUNTRY OF RESIDENCE GHANA
                      return DropdownButton<String>(
                        value: shot.data != null
                            ? shot.data?.first?.name
                            : 'GHANA',
                        items: shot.data.map((CountryEntity value) {
                          return DropdownMenuItem<String>(
                            value: value.name != null ? value.name : 'GHANA',
//                            child: Text(
//                                value.name != null ? value.name : 'GHANA'),
                            child: Text('GHANA'),
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

  Widget _buildStateOfResidence() {
    return StreamBuilder(
        stream: accountFormBloc.bvnStateOfResidences,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return _stateOfResidenceTextField();
          }
          if (snapshot.data) {
            return _stateOfResidenceTextField();
          } else
            return _stateOfResidenceField();
        });
  }

  Widget _stateOfResidenceField() {
    return StreamBuilder(
      stream: accountFormBloc.stateOfResidence,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _stateOfResidenceController.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _stateOfResidenceController.selection);
        }
        return TextField(
          controller: _stateOfResidenceController,
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc.changeStateOfResidence,
          keyboardType: TextInputType.text,
          maxLength: 40,
          enabled: accountFormBloc.bvnStateOfResidence,
          maxLines: null,
          maxLengthEnforced: true,
          decoration: InputDecoration(
            labelText: 'Region of Residence',
            helperText: '* Required',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget _stateOfResidenceTextField() {
    return StreamBuilder(
      stream: accountFormBloc.stateOfResidence,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidate: true,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Region of Residence',
                  helperText: "* Required",
                  errorText: snapshot.error),
//              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.hasData
                      ? Helper.returnValidStateRegionSelectedItem(
                      snapshot.data, _stateRegion)
                      : null,
                  isDense: true,
                  onChanged:(value) {
                    setState(() {
                      if(value == null){
                        _selectedAccFilter = "";
                      }else
                      _selectedAccFilter = value.toUpperCase();
                      print(_selectedAccFilter);

                    });
                    accountFormBloc.updateStateRegion(value);
                    accountFormBloc.updateMMDA(null);
                  },
                  items: _stateRegion.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value.toUpperCase(),
                      child: Text(value.toUpperCase()),
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

  Widget _mMDAFields() {
    return StreamBuilder<List<StateEntity>>(
      stream: statesBloc.states,
      builder: (context, listSnapshot) {
        return StreamBuilder(
            stream: accountFormBloc.mmda,
            builder: (context, itemSnapshot) {
              return FormField<String>(
                autovalidate: true,
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        labelText: 'MMDA',
                        helperText: "* Required",
                        errorText: itemSnapshot.error),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _getAccountTypeValue(itemSnapshot, listSnapshot),
                        isDense: true,
                        items: listSnapshot.hasData
                            ? listSnapshot.data
                            .where((x) =>
                            x.stateName.toUpperCase().startsWith(_selectedAccFilter))
                            .map((StateEntity entity) {
                          return DropdownMenuItem<String>(
                            value: entity.mmda.toUpperCase().toString(),
                            child: Text(entity.mmda.toUpperCase().toString()),
                          );
                        }).toList()
                            : null,
                        onChanged: (value) {
                          accountFormBloc.updateMMDA(value);
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

  String _getAccountTypeValue(AsyncSnapshot itemSnapshot,
      AsyncSnapshot<List<StateEntity>> listSnapshot) {
    var data = (listSnapshot.hasData &&
        listSnapshot.data.length > 0 &&
        listSnapshot.data.firstWhere(
                (x) => x.mmda.toUpperCase() == itemSnapshot.data.toString().toUpperCase(),
            orElse: () => null) !=
            null)
        ? itemSnapshot.data.toString().toUpperCase()
        : null;

    return data;
  }
  Widget _cityOfResidenceTextField() {
    return StreamBuilder(
      stream: accountFormBloc.cityOfResidence,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidate: true,
          builder: (FormFieldState<String> city) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'CITY/TOWN OF RESIDENCE',
                  helperText: "* Required",
                  errorText: snapshot.error),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: StreamBuilder<List<CityEntity>>(
                    stream: _citiesBloc.cities,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<CityEntity>> shot) {
                      if (!shot.hasData)
                        return SizedBox(
                            height: 24.0,
                            child: Center(child: CircularProgressIndicator()));
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

  Widget _buildGender() {
    return StreamBuilder(
        stream: accountFormBloc.bvnGenders,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return _genderTextField();
          }
          if (snapshot.data) {
            return _genderTextField();
          } else {
            return _genderField();
          }
        });
  }

  Widget _genderField() {
    return StreamBuilder(
      stream: accountFormBloc.gender,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _genderController.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _genderController.selection);
        }
        return TextField(
          controller: _genderController,
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc.changeGender,
          keyboardType: TextInputType.text,
          maxLength: 40,
          enabled: accountFormBloc.bvnGender,
          maxLines: null,
          maxLengthEnforced: true,
          decoration: InputDecoration(
            labelText: 'Gender',
            helperText: '* Required',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget _genderTextField() {
    return StreamBuilder(
      stream: accountFormBloc.gender,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidate: true,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Gender',
                  helperText: "* Required",
                  errorText: snapshot.error),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.hasData
                      ? Helper.returnValidGenderSelectedItem(
                          snapshot.data, _genders)
                      : null,
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
          autovalidate: true,
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
                      if (!shot.hasData)
                        return SizedBox(
                            height: 24.0,
                            child: Center(child: CircularProgressIndicator()));
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

  Widget _buildMaritalStatus() {
    return StreamBuilder(
        stream: accountFormBloc.bvnMaritalStatuses,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return _maritalStatusField();
          }
          if (snapshot.data) {
            return _maritalStatusField();
          } else
            return _maritalStatusTextField();
        });
  }

  Widget _maritalStatusTextField() {
    return StreamBuilder(
      stream: accountFormBloc.maritalStatus,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _maritalStatusController.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _maritalStatusController.selection);
        }
        return TextField(
          controller: _maritalStatusController,
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc.changeMaritalStatus,
          keyboardType: TextInputType.text,
          maxLength: 40,
          enabled: accountFormBloc.bvnMaritalStatus,
          maxLines: null,
          maxLengthEnforced: true,
          decoration: InputDecoration(
            labelText: 'Marital Status',
            helperText: '* Required',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget _maritalStatusField() {
    return StreamBuilder(
      stream: accountFormBloc.maritalStatus,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidate: true,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Marital Status',
                  helperText: "* Required",
                  errorText: snapshot.error),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.hasData
                      ? Helper.returnValidMaritalStatusSelectedItem(
                          snapshot.data, _maritalStatus)
                      : null,
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
                  _buildStateOfResidence(),
                  SizedBox(height: 30.0),
                  _mMDAFields(),
                  SizedBox(height: 30.0),
                  _cityOfResidenceTextField(),
                  SizedBox(height: 30.0),
                  _buildGender(),
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

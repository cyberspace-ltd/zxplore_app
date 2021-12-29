import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zxplore_app/blocs/account_form_bloc.dart';
import 'package:zxplore_app/blocs/cities_bloc.dart';
import 'package:zxplore_app/blocs/countries_bloc.dart';
import 'package:zxplore_app/blocs/occupations_bloc.dart';
import 'package:zxplore_app/blocs/provider.dart';
import 'package:zxplore_app/blocs/states_bloc.dart';
import 'package:zxplore_app/data/entities/occupation_entity.dart';
import 'package:zxplore_app/data/entities/state_entity.dart';
import 'package:zxplore_app/utils/const.dart';
import 'package:zxplore_app/utils/helper_functions.dart';

class ContactDetailsStep extends StatefulWidget {
  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetailsStep>
    with AutomaticKeepAliveClientMixin<ContactDetailsStep> {
  AccountFormBloc? accountFormBloc;
  late OccupationsBloc _occupationsBloc;
  late CountriesBloc _countriesBloc;
  late StatesBloc statesBloc;
  late CitiesBloc _citiesBloc;
  String _selectedAccFilter = "";

  final TextEditingController _othersOccupationController =
      TextEditingController();

  bool others = false;

  String _selectedOccupationGroup = '';
  @override
  bool get wantKeepAlive => true;

  // final TextEditingController _countryOfResidenceController =
  //     TextEditingController();
  final TextEditingController _stateOfResidenceController =
      TextEditingController();

  final TextEditingController _genderController = TextEditingController();

  // final TextEditingController _occupationController = TextEditingController();

  // final TextEditingController _maritalStatusController =
  //     TextEditingController();

  final _genders = ['MALE', 'FEMALE'];

  final _maritalStatus = ['SINGLE', 'MARRIED', 'SEPARATED', 'DIVORCED'];

  final _country = [
    "GHANA",
  ];

  List<String> _stateRegion = [
    'Ahafo',
    'Ashanti',
    'Bono ',
    'Bono East ',
    'Central ',
    'Eastern ',
    'Greater Accra ',
    'Northern ',
    'North East ',
    'Oti ',
    'Savannah ',
    'Upper East ',
    'Upper West ',
    'Volta ',
    'Western ',
    'Western North '
  ];
  TextEditingController? _emailController;
  TextEditingController? _phoneController;
  TextEditingController? _nextOfKinController;
  TextEditingController? _address1Controller;
  TextEditingController? _address2Controller;
  TextEditingController? _cityOfResidenceController;
  late TextEditingController _occupationCategoryController;
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
    _cityOfResidenceController = TextEditingController();
    _occupationCategoryController = TextEditingController();
  }

  @override
  void dispose() {
    statesBloc.dispose();
    _countriesBloc.dispose();
    _occupationsBloc.dispose();
    _citiesBloc.dispose();
    _emailController!.dispose();
    _phoneController!.dispose();
    _nextOfKinController!.dispose();
    _address1Controller!.dispose();
    _address2Controller!.dispose();
    _cityOfResidenceController!.dispose();
    _occupationCategoryController.dispose();

    super.dispose();
  }

  Widget _emailTextField() {
    return StreamBuilder<String?>(
        stream: accountFormBloc!.email,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _emailController!.value = TextEditingValue(
                text: snapshot.data.toString(),
                selection: _emailController!.selection);
          }

          return TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: accountFormBloc!.changeEmail,
            maxLength: 40,
//            enabled: accountFormBloc.bvnEmail,
            maxLines: null,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            decoration: InputDecoration(
              labelText: 'Email',
              errorText: snapshot.error as String?,
            ),
          );
        });
  }

  Widget _phoneTextField() {
    return StreamBuilder<String?>(
        stream: accountFormBloc!.phoneNumber,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _phoneController!.value = TextEditingValue(
                text: snapshot.data.toString(),
                selection: _phoneController!.selection);
          }
          return TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            onChanged: accountFormBloc!.changePhone,
            maxLength: 11,
//            enabled: accountFormBloc.bvnPhone,
            decoration: InputDecoration(
              labelText: 'Phone',
              prefixText: '+233',
              helperText: "* Required",
              errorText: snapshot.error as String?,
            ),
          );
        });
  }

  Widget _nextOfKinTextField() {
    return StreamBuilder<String?>(
        stream: accountFormBloc!.nextOfKin,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _nextOfKinController!.value = TextEditingValue(
                text: snapshot.data.toString(),
                selection: _nextOfKinController!.selection);
          }

          return TextField(
            controller: _nextOfKinController,
            textCapitalization: TextCapitalization.characters,
            keyboardType: TextInputType.text,
            onChanged: accountFormBloc!.changeNextOfKin,
            maxLength: 50,
            maxLines: null,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            decoration: InputDecoration(
              labelText: 'Next of Kin',
              helperText: '* Required',
              errorText: snapshot.error as String?,
            ),
          );
        });
  }

  Widget _address1TextField() {
    return StreamBuilder<String?>(
        stream: accountFormBloc!.address1,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _address1Controller!.value = TextEditingValue(
                text: snapshot.data.toString(),
                selection: _address1Controller!.selection);
          }
          return TextField(
            controller: _address1Controller,
            textCapitalization: TextCapitalization.characters,
            keyboardType: TextInputType.multiline,
            onChanged: accountFormBloc!.changeAddress1,
            maxLength: 40,
            maxLines: null,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            decoration: InputDecoration(
              labelText: 'Address 1',
              helperText: '* Required',
              errorText: snapshot.error as String?,
            ),
          );
        });
  }

  Widget _address2TextField() {
    return StreamBuilder<String?>(
        stream: accountFormBloc!.address2,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _address2Controller!.value = TextEditingValue(
                text: snapshot.data.toString(),
                selection: _address2Controller!.selection);
          }
          return TextField(
            controller: _address2Controller,
            textCapitalization: TextCapitalization.characters,
            keyboardType: TextInputType.multiline,
            onChanged: accountFormBloc!.changeAddress2,
            maxLength: 40,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            decoration: InputDecoration(
              labelText: 'Address 2',
              errorText: snapshot.error as String?,
            ),
          );
        });
  }

  Widget _countryOfResidenceTextField() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.countryOfResidence,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidateMode: AutovalidateMode.always,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Country Of Residence',
                  helperText: "* Required",
                  errorText: snapshot.error as String?),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                value: snapshot.data,
                isDense: true,
                onChanged: accountFormBloc!.changeCountryOfResidence,
                items: _country.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
            );
          },
        );
      },
    );
  }

  Widget _buildStateOfResidence() {
    return StreamBuilder<bool>(
        stream: accountFormBloc!.bvnStateOfResidences,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return _stateOfResidenceTextField();
          }
          if (snapshot.data!) {
            return _stateOfResidenceTextField();
          } else
            return _stateOfResidenceField();
        });
  }

  Widget _stateOfResidenceField() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.stateOfResidence,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _stateOfResidenceController.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _stateOfResidenceController.selection);
        }
        return TextField(
          controller: _stateOfResidenceController,
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc!.changeStateOfResidence,
          keyboardType: TextInputType.text,
          maxLength: 40,
          enabled: accountFormBloc!.bvnStateOfResidence,
          maxLines: null,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          decoration: InputDecoration(
            labelText: 'Region of Residence',
            helperText: '* Required',
            errorText: snapshot.error as String?,
          ),
        );
      },
    );
  }

  Widget _stateOfResidenceTextField() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.stateOfResidence,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidateMode: AutovalidateMode.always,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Region of Residence',
                  helperText: "* Required",
                  errorText: snapshot.error as String?),
//              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.hasData
                      ? Helper.returnValidStateRegionSelectedItem(
                          snapshot.data!, _stateRegion)
                      : null,
                  isDense: true,
                  onChanged: (value) {
                    setState(() {
                      if (value == null) {
                        _selectedAccFilter = "";
                      } else
                        _selectedAccFilter = value.toUpperCase();
                      print(_selectedAccFilter);
                    });
                    accountFormBloc!.updateStateRegion(value);
                    accountFormBloc!.updateMMDA(null);
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
            stream: accountFormBloc!.mmda,
            builder: (context, itemSnapshot) {
              return FormField<String>(
                autovalidateMode: AutovalidateMode.always,
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        labelText: 'MMDA',
                        helperText: "* Required",
                        errorText: itemSnapshot.error as String?),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _getAccountTypeValue(itemSnapshot, listSnapshot),
                        isExpanded: true,
                        isDense: true,
                        items: listSnapshot.hasData
                            ? listSnapshot.data!
                                .where((x) => x.stateName!
                                    .toUpperCase()
                                    .startsWith(_selectedAccFilter))
                                .map((StateEntity entity) {
                                return DropdownMenuItem<String>(
                                  value: entity.mmda!.toUpperCase().toString(),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      entity.mmda!.toUpperCase().toString(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                );
                              }).toList()
                            : null,
                        onChanged: (value) {
                          accountFormBloc!.updateMMDA(value);
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

  String? _getAccountTypeValue(AsyncSnapshot itemSnapshot,
      AsyncSnapshot<List<StateEntity>> listSnapshot) {
    var data = (listSnapshot.hasData &&
            listSnapshot.data!.length > 0 &&
            listSnapshot.data!.firstWhereOrNull((x) =>
                    x.mmda!.toUpperCase() ==
                    itemSnapshot.data.toString().toUpperCase()) !=
                null)
        ? itemSnapshot.data.toString().toUpperCase()
        : null;

    return data;
  }

  String? _getOccupationValue(AsyncSnapshot itemSnapshot,
      AsyncSnapshot<List<OccupationEntity>> listSnapshot) {
    var data = (listSnapshot.hasData &&
            listSnapshot.data!.length > 0 &&
            listSnapshot.data!.firstWhereOrNull((x) =>
                    x.occupationName!.toUpperCase() ==
                    itemSnapshot.data.toString().toUpperCase()) !=
                null)
        ? itemSnapshot.data.toString().toUpperCase()
        : null;

    return data;
  }

  Widget _cityOfResidenceTextField() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.cityOfResidence,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _cityOfResidenceController!.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _cityOfResidenceController!.selection);
        }
        return TextField(
          controller: _cityOfResidenceController,
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc!.changeCityOfResidence,
          keyboardType: TextInputType.text,
          maxLength: 40,
          maxLines: null,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          decoration: InputDecoration(
            labelText: 'CITY/TOWN OF RESIDENCE',
            helperText: '* Required',
            errorText: snapshot.error as String?,
          ),
        );
      },
    );
  }

  Widget _buildGender() {
    return StreamBuilder<bool>(
        stream: accountFormBloc!.bvnGenders,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return _genderTextField();
          }
          if (snapshot.data!) {
            return _genderTextField();
          } else {
            return _genderField();
          }
        });
  }

  Widget _genderField() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.gender,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _genderController.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _genderController.selection);
        }
        return TextField(
          controller: _genderController,
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc!.changeGender,
          keyboardType: TextInputType.text,
          maxLength: 40,
          enabled: accountFormBloc!.bvnGender,
          maxLines: null,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          decoration: InputDecoration(
            labelText: 'Gender',
            helperText: '* Required',
            errorText: snapshot.error as String?,
          ),
        );
      },
    );
  }

  Widget _genderTextField() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.gender,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidateMode: AutovalidateMode.always,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Gender',
                  helperText: "* Required",
                  errorText: snapshot.error as String?),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.hasData
                      ? Helper.returnValidGenderSelectedItem(
                          snapshot.data!, _genders)
                      : null,
                  isDense: true,
                  onChanged: accountFormBloc!.changeGender,
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

  // ignore: non_constant_identifier_names
  Widget _other_occupationField() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.otherOccupation,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _othersOccupationController.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _othersOccupationController.selection);
        }
        return TextField(
          controller: _othersOccupationController,
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc!.changeOtherOccupation,
          keyboardType: TextInputType.text,
          maxLength: 40,
          maxLines: null,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          decoration: InputDecoration(
            labelText: 'Other Occupation',
            helperText: '* Required',
            errorText: snapshot.error as String?,
          ),
        );
      },
    );
  }

  Widget _occupationCategoryField() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.occupationCategory,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidateMode: AutovalidateMode.always,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Occupation Group',
                  helperText: "* Required",
                  errorText: snapshot.error as String?),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: StreamBuilder<List<OccupationEntity>>(
                    stream: _occupationsBloc.occupationCategories,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<OccupationEntity>> shot) {
                      if (!shot.hasData)
                        return SizedBox(
                            height: 24.0,
                            child: Center(child: CircularProgressIndicator()));
                      return FittedBox(
                        fit: BoxFit.scaleDown,
                        child: DropdownButton<String>(
                          value: snapshot.data,
                          items:
                              shot.data!.toSet().map((OccupationEntity value) {
                            return DropdownMenuItem<String>(
                              value: value.sironCode,
                              child: Text(value.groupName!.toUpperCase(),
                                  overflow: TextOverflow.ellipsis),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value == null) {
                              _selectedOccupationGroup = "";
                              accountFormBloc!.updateOccupationCategory(null);
                            } else {
                              setState(() {
                                _selectedOccupationGroup = value.toUpperCase();
                                print(_selectedOccupationGroup);
                              });
                              accountFormBloc!.updateOccupationCategory(value);
                              accountFormBloc!.updateOccupation(null);
                            }
                          },

                          isDense: true, //value: _currentUser,
                        ),
                      );
                    }),
              ),
            );
          },
        );
      },
    );
  }

  Widget _occupationField() {
    return StreamBuilder<List<OccupationEntity>>(
        stream: _occupationsBloc.occupations,
        builder: (context, listSnapshot) {
          return StreamBuilder(
            stream: accountFormBloc!.occupation,
            builder: (context, itemSnapshot) {
              return FormField<String>(
                autovalidateMode: AutovalidateMode.always,
                builder: (FormFieldState<String> occupations) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        labelText: 'Occupation',
                        helperText: "* Required",
                        errorText: itemSnapshot.error as String?),
                    isEmpty: itemSnapshot.data == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _getOccupationValue(itemSnapshot, listSnapshot),
                        isExpanded: true,
                        isDense: true,
                        items: listSnapshot.hasData
                            ? listSnapshot.data!
                                .where((x) => x.sironCode!
                                    .toUpperCase()
                                    .startsWith(_selectedOccupationGroup))
                                .map((OccupationEntity entity) {
                                return DropdownMenuItem<String>(
                                  value: entity.occupationName!
                                      .toUpperCase()
                                      .toString(),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                        entity.occupationName!
                                            .toUpperCase()
                                            .toString(),
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                );
                              }).toList()
                            : null,
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            if (value != null) {
                              if (value
                                  .replaceAll(' ', '')
                                  .toUpperCase()
                                  .trim()
                                  .contains(PLEASE_SPECIFY
                                      .replaceAll(' ', '')
                                      .toUpperCase()
                                      .trim())) {
                                others = true;
                              } else {
                                others = false;
                              }
                            }
                          });
                          accountFormBloc!.updateOccupation(value);
                        },
                      ),
                    ),
                  );
                },
              );
            },
          );
        });
  }

  // Widget _buildMaritalStatus() {
  //   return StreamBuilder(
  //       stream: accountFormBloc.bvnMaritalStatuses,
  //       builder: (context, snapshot) {
  //         if (!snapshot.hasData) {
  //           return _maritalStatusField();
  //         }
  //         if (snapshot.data) {
  //           return _maritalStatusField();
  //         } else
  //           return _maritalStatusTextField();
  //       });
  // }

  // Widget _maritalStatusTextField() {
  //   return StreamBuilder(
  //     stream: accountFormBloc.maritalStatus,
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         _maritalStatusController.value = TextEditingValue(
  //             text: snapshot.data.toString(),
  //             selection: _maritalStatusController.selection);
  //       }
  //       return TextField(
  //         controller: _maritalStatusController,
  //         textCapitalization: TextCapitalization.characters,
  //         onChanged: accountFormBloc.changeMaritalStatus,
  //         keyboardType: TextInputType.text,
  //         maxLength: 40,
  //         enabled: accountFormBloc.bvnMaritalStatus,
  //         maxLines: null,
  //         maxLengthEnforced: true,
  //         decoration: InputDecoration(
  //           labelText: 'Marital Status',
  //           helperText: '* Required',
  //           errorText: snapshot.error,
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _maritalStatusField() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.maritalStatus,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidateMode: AutovalidateMode.always,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Marital Status',
                  helperText: "* Required",
                  errorText: snapshot.error as String?),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.hasData
                      ? Helper.returnValidMaritalStatusSelectedItem(
                          snapshot.data!, _maritalStatus)
                      : null,
                  isDense: true,
                  onChanged: accountFormBloc!.changeMaritalStatus,
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
                    _occupationCategoryField(),
                    SizedBox(height: 30.0),
                    _occupationField(),
                    Visibility(visible: others, child: SizedBox(height: 30.0)),
                    Visibility(
                        visible: others, child: _other_occupationField()),
                    SizedBox(height: 30.0),
                    _maritalStatusField(),
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
}

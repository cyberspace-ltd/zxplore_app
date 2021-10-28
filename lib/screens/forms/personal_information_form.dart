import 'package:flutter/material.dart';
import 'package:zxplore_app/blocs/account_form_bloc.dart';
import 'package:zxplore_app/blocs/countries_bloc.dart';
import 'package:zxplore_app/blocs/provider.dart';
import 'package:intl/intl.dart';
import 'package:zxplore_app/blocs/states_bloc.dart';
import 'package:zxplore_app/utils/const.dart';

class PersonalInformationStep extends StatefulWidget {
  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformationStep>
    with AutomaticKeepAliveClientMixin<PersonalInformationStep> {
  final _titles = [
    'Miss',
    'Ms.',
    'Dr.',
    'Prof.',
    'Rev.',
    'Mr.',
    'Mrs',
    'Alhaji',
    'Mr & Mrs',
    'Dr. & Mrs.',
    'Hon.',
    'Nana'
  ];

  AccountFormBloc? accountFormBloc;

  late CountriesBloc countriesBloc;

  late StatesBloc statesBloc;

  TextEditingController? _bvnController;
  TextEditingController? _firstNameController;
  late TextEditingController _titleController;
  TextEditingController? _surnameController;
  TextEditingController? _otherNameController;
  TextEditingController? _mothersMaidenNameController;
  TextEditingController? _dateOfBirthController;
  TextEditingController? _placeOfBirthController;
  late TextEditingController _countryOfOriginController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    countriesBloc = CountriesBloc();
    statesBloc = StatesBloc();
    accountFormBloc = BlocProvider.of<AccountFormBloc>(context);
    _bvnController = TextEditingController();
    _firstNameController = TextEditingController();
    _titleController = TextEditingController();
    _surnameController = TextEditingController();
    _otherNameController = TextEditingController();
    _mothersMaidenNameController = TextEditingController();
    _dateOfBirthController = TextEditingController();
    _placeOfBirthController = TextEditingController();
    _countryOfOriginController = TextEditingController();
  }

  @override
  void dispose() {
    statesBloc.dispose();
    countriesBloc.dispose();
    _firstNameController!.dispose();
    _bvnController!.dispose();
    _titleController.dispose();
    _surnameController!.dispose();
    _otherNameController!.dispose();
    _mothersMaidenNameController!.dispose();
    _dateOfBirthController!.dispose();
    _placeOfBirthController!.dispose();
    _countryOfOriginController.dispose();

    super.dispose();
  }

  Widget titleTextField() {
    return StreamBuilder<String>(
      stream: accountFormBloc!.title,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidate: true,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Title',
                  helperText: "* Required",
                  errorText: snapshot.error as String?),
              isEmpty: snapshot.data == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.data,
                  isDense: true,
                  onChanged: accountFormBloc!.changeTitle,
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

  Widget _tinField() {
    return StreamBuilder(
        stream: accountFormBloc!.tin,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _bvnController!.value = TextEditingValue(
                text: snapshot.data.toString(),
                selection: _bvnController!.selection);
          }
          return TextField(
            controller: _bvnController,
            obscureText: false,
            keyboardType: TextInputType.text,
            onChanged: accountFormBloc!.changeTin,
            decoration: InputDecoration(
              labelText: 'Ghana Card',
              // helperText:
              //     'Click the verify TIN button to populate account form.',
              errorText: snapshot.error as String?,
            ),
          );
        });
  }

  Widget _surnameField() {
    return StreamBuilder(
      stream: accountFormBloc!.surname,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _surnameController!.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _surnameController!.selection);
        }
        return TextField(
          controller: _surnameController,
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc!.changeSurname,
          keyboardType: TextInputType.text,
          maxLength: 40,
//          enabled: accountFormBloc.bvnlastNameValue,
          maxLines: null,
          maxLengthEnforced: true,
          decoration: InputDecoration(
            labelText: 'Surname',
            helperText: '* Required',
            errorText: snapshot.error as String?,
          ),
        );
      },
    );
  }

  //Workaround for this issue on text TextFields: https://github.com/flutter/flutter/issues/11416

  Widget _firstNameField() {
    return StreamBuilder(
      stream: accountFormBloc!.firstName,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _firstNameController!.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _firstNameController!.selection);
        }
        return TextField(
          controller: _firstNameController,
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc!.changeFirstName,
          keyboardType: TextInputType.text,
          maxLength: 40,
          enabled: accountFormBloc!.bvnFirstName,
          maxLines: null,
          maxLengthEnforced: true,
          decoration: InputDecoration(
            labelText: 'First Name',
            helperText: '* Required',
            errorText: snapshot.error as String?,
          ),
        );
      },
    );
  }

  Widget _otherNameField() {
    return StreamBuilder(
      stream: accountFormBloc!.otherName,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _otherNameController!.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _otherNameController!.selection);
        }
        return TextField(
          controller: _otherNameController,
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc!.changeOtherName,
          keyboardType: TextInputType.text,
          maxLength: 40,
          enabled: accountFormBloc!.bvnOtherName,
          maxLines: null,
          maxLengthEnforced: true,
          decoration: InputDecoration(
            labelText: 'Other Name',
            errorText: snapshot.error as String?,
          ),
        );
      },
    );
  }

  Widget _mothersMaidenNameField() {
    return StreamBuilder(
      stream: accountFormBloc!.mothersMaidenName,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _mothersMaidenNameController!.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _mothersMaidenNameController!.selection);
        }
        return TextField(
          controller: _mothersMaidenNameController,
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc!.changeMothersMaidenName,
          keyboardType: TextInputType.text,
          maxLength: 40,
          maxLines: null,
          maxLengthEnforced: true,
          decoration: InputDecoration(
            labelText: 'Mother\'s Maiden Name',
            helperText: '* Required',
            errorText: snapshot.error as String?,
          ),
        );
      },
    );
  }

  Widget _dateOfBirthTextField() {
    return StreamBuilder(
      stream: accountFormBloc!.dateOfBirth,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _dateOfBirthController!.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _dateOfBirthController!.selection);
        }
        return TextField(
          controller: _dateOfBirthController,
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc!.changeDateOfBirth,
          keyboardType: TextInputType.text,
          maxLength: 40,
          enabled: accountFormBloc!.bvnDateOfBirths,
          maxLines: null,
          maxLengthEnforced: true,
          decoration: InputDecoration(
            labelText: 'Date of Birth',
            helperText: '* Required',
            errorText: snapshot.error as String?,
          ),
        );
      },
    );
  }

  Widget _dateOfBirthField() {
    return StreamBuilder(
      stream: accountFormBloc!.dateOfBirth,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _dateOfBirthController!.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _dateOfBirthController!.selection);
        }
        return GestureDetector(
            onTap: () async {
              FocusScope.of(context).unfocus();
              DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: new DateTime(DateTime.now().year - 13),
                  firstDate: new DateTime(1900),
                  lastDate: new DateTime(DateTime.now().year - 13));

              if (picked != null) {
                var formatter = new DateFormat('dd-MMM-yy');
                var dob = formatter.format(picked);

                _dateOfBirthController!.text = dob;
                accountFormBloc!.changeDateOfBirth(dob);
              }
            },
            child: AbsorbPointer(
              child: TextField(
                controller: _dateOfBirthController,
                onChanged: accountFormBloc!.changeDateOfBirth,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  helperText: "* Required",
                  suffixIcon: Icon(Icons.date_range),
                  errorText: snapshot.error as String?,
                ),
              ),
            ));
      },
    );
  }

  Widget _stateOfOriginTextField() {
    return StreamBuilder(
      stream: accountFormBloc!.placeOfBirth,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _placeOfBirthController!.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _placeOfBirthController!.selection);
        }
        return TextField(
          controller: _placeOfBirthController,
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc!.changePlaceOfBirth,
          keyboardType: TextInputType.text,
          maxLength: 40,
          maxLines: null,
          maxLengthEnforced: true,
          decoration: InputDecoration(
              labelText: 'Place of Birth',
              helperText: "* Required",
              errorText: snapshot.error as String?),
        );
      },
    );
  }

  Widget _countryOfOriginTextField() {
    return StreamBuilder<String>(
      stream: accountFormBloc!.countryOfOrigin,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidate: true,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Country of Origin',
                  helperText: "* Required",
                  errorText: snapshot.error as String?),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                value: snapshot.data,
                isDense: true,
                onChanged: accountFormBloc!.changeCountryOfOrigin,
                items: COUNTRY_LIST.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.toUpperCase()),
                  );
                }).toList(),
              )),
            );
          },
        );
      },
    );
  }

  Widget _buildDateOfBirth() {
    return StreamBuilder<bool>(
        stream: accountFormBloc!.bvnDateOfBirth,
        builder: (context, snapShot) {
          if (!snapShot.hasData) {
            return _dateOfBirthField();
          }
          if (snapShot.data!) {
            return _dateOfBirthField();
          } else
            return _dateOfBirthTextField();
        });
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
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 16.0),
            SizedBox(height: 16.0),
            _tinField(),
            SizedBox(height: 30.0),
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
            _buildDateOfBirth(),
            SizedBox(height: 30.0),
            _stateOfOriginTextField(),
            SizedBox(height: 30.0),
            _countryOfOriginTextField(),
            SizedBox(height: 120.0),
          ],
        ),
      ),
    );
  }
}

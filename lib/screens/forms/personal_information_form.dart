import 'dart:convert';
import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zxplore_app/models/card_type_model.dart';
import 'package:zxplore_app/utils/const.dart';
import 'package:zxplore_app/blocs/provider.dart';
import 'package:zxplore_app/blocs/states_bloc.dart';
import 'package:zxplore_app/blocs/countries_bloc.dart';
import 'package:zxplore_app/blocs/account_form_bloc.dart';
import 'package:zxplore_app/utils/preferences.dart';

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
    TextEditingController? _otherSourceController;
  TextEditingController? _placeOfBirthController;
   TextEditingController? _homeTownController;
  late TextEditingController _countryOfOriginController;

  Preference? prefs;
 // List<String>? employmentTypeList;
  //List<String>? monthlyIncomeList;
  // List<String>? sourceOfFundList;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

     prefs = Preference();
  //   getDetails();

    countriesBloc = CountriesBloc();
    statesBloc = StatesBloc();
    accountFormBloc = BlocProvider.of<AccountFormBloc>(context);
    _bvnController = TextEditingController();
    _homeTownController = TextEditingController();
    _firstNameController = TextEditingController();
    _titleController = TextEditingController();
    _otherSourceController = TextEditingController();
    _surnameController = TextEditingController();
    _otherNameController = TextEditingController();
    _mothersMaidenNameController = TextEditingController();
    _dateOfBirthController = TextEditingController();
    _placeOfBirthController = TextEditingController();
    _countryOfOriginController = TextEditingController();
  }

/*
  void getDetails() async {
    await prefs!.load();
    final employmentTypesJson = prefs!.getString("EmploymentTypes");
    final monthlyIncomeJson = prefs!.getString("MonthlyAllowance");
     final sourceOfFundJson = prefs!.getString("SourceOfFund");

  final employmentTypesJ = cardTypeFromJson(employmentTypesJson).menu;
  if (employmentTypesJ != null) {
  //  employmentTypeList = employmentTypesJ;
    accountFormBloc!.setEmploymentType(employmentTypesJ);
  }
  final monthlyIncome = cardTypeFromJson(monthlyIncomeJson).menu;
  if (monthlyIncome != null) {
   // monthlyIncomeList = monthlyIncome;
    accountFormBloc!.setMonthlyIncome(monthlyIncome);
  }
  final sourceOfFund = cardTypeFromJson(sourceOfFundJson).menu;
  if (sourceOfFund != null) {
  //  sourceOfFundList = sourceOfFund;
     accountFormBloc!.setSourceOfFund(sourceOfFund);
  }

  }
  */

  @override
  void dispose() {
    statesBloc.dispose();
    countriesBloc.dispose();
    _firstNameController!.dispose();
    _bvnController!.dispose();
    _otherSourceController!.dispose();
    _titleController.dispose();
    _surnameController!.dispose();
    _otherNameController!.dispose();
    _homeTownController!.dispose();
    _mothersMaidenNameController!.dispose();
    _dateOfBirthController!.dispose();
    _placeOfBirthController!.dispose();
    _countryOfOriginController.dispose();

    super.dispose();
  }

  Widget titleTextField() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.title,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidateMode: AutovalidateMode.always,
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

/*
    Widget sourceOfFundTextField() {
    return StreamBuilder<List<String>>(
      stream: accountFormBloc!.sourceOfFund,
      builder: (context, snapshot) {
        if(snapshot.hasData){
        return FormField<String>(
          autovalidateMode: AutovalidateMode.always,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Source of Fund',
                  helperText: "* Required",
                  errorText: snapshot.error as String?),
              isEmpty: snapshot.data == null,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.data!.first,
                  isDense: true,
                  onChanged: accountFormBloc!.changeTitle,
                  items: snapshot.data!.map((String value) {
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
      }else{
       return SizedBox.shrink();
      }
      },
    );
  }

*/


  Widget _tinField() {
    return StreamBuilder<String?>(
        stream: accountFormBloc!.tin,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            
               if(_bvnController!.text != snapshot.data.toString()){
            _bvnController!.value = TextEditingValue(
                text: snapshot.data.toString(),
                selection: _bvnController!.selection);
               }
          }
          return TextField(
            controller: _bvnController,
            obscureText: false,
            keyboardType: TextInputType.text,
            onChanged: accountFormBloc!.changeTin,
            decoration: InputDecoration(
              labelText: 'Ghana Card Number',
              // helperText:
              //     'Click the verify TIN button to populate account form.',
              errorText: snapshot.error as String?,
            ),
          );
        });
 
  }

  Widget _surnameField() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.surname,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
             if(_surnameController!.text != snapshot.data.toString()){
          _surnameController!.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _surnameController!.selection);
             }
        }
        return TextField(
          controller: _surnameController,
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc!.changeSurname,
          keyboardType: TextInputType.text,
          maxLength: 40,
//          enabled: accountFormBloc.bvnlastNameValue,
          maxLines: null,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
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
    return StreamBuilder<String?>(
      stream: accountFormBloc!.firstName,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
             if(_firstNameController!.text != snapshot.data.toString()){
          _firstNameController!.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _firstNameController!.selection);
             }
        }
        return TextField(
          controller: _firstNameController,
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc!.changeFirstName,
          keyboardType: TextInputType.text,
          maxLength: 40,
          enabled: accountFormBloc!.bvnFirstName,
          maxLines: null,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
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
    return StreamBuilder<String?>(
      stream: accountFormBloc!.otherName,
      builder: (context, snapshot) {
        if (snapshot.hasData) {

             if(_otherNameController!.text != snapshot.data.toString()){

          _otherNameController!.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _otherNameController!.selection);
             }
        }
        return TextField(
          controller: _otherNameController,
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc!.changeOtherName,
          keyboardType: TextInputType.text,
          maxLength: 40,
          enabled: accountFormBloc!.bvnOtherName,
          maxLines: null,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          decoration: InputDecoration(
            labelText: 'Other Name',
            errorText: snapshot.error as String?,
          ),
        );
      },
    );
  }

  Widget _mothersMaidenNameField() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.mothersMaidenName,
      builder: (context, snapshot) {
        if (snapshot.hasData) {

             if(_mothersMaidenNameController!.text != snapshot.data.toString()){

          _mothersMaidenNameController!.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _mothersMaidenNameController!.selection);
             }
        }
        return TextField(
          controller: _mothersMaidenNameController,
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc!.changeMothersMaidenName,
          keyboardType: TextInputType.text,
          maxLength: 40,
          maxLines: null,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
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
    return StreamBuilder<String?>(
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
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
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
    return StreamBuilder<String?>(
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
                  initialDate: new DateTime(DateTime.now().year - 17,1,0),
                  firstDate: new DateTime(1900),
                  lastDate: new DateTime(DateTime.now().year - 17,1,0));

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
    return StreamBuilder<String?>(
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
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          decoration: InputDecoration(
              labelText: 'Place of Birth',
              helperText: "* Required",
              errorText: snapshot.error as String?),
        );
      },
    );
  }


  Widget _homeTownTextField() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.homeTown,
      builder: (context, snapshot) {
        if (snapshot.hasData) {

             if(_homeTownController!.text != snapshot.data.toString()){

          _homeTownController!.value = TextEditingValue(
              text: snapshot.data.toString(),
              selection: _homeTownController!.selection);
             }
        }
        return TextField(
          controller: _homeTownController,
          textCapitalization: TextCapitalization.characters,
          onChanged: accountFormBloc!.changeHomeTown,
          keyboardType: TextInputType.text,
          maxLength: 40,
          maxLines: null,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          decoration: InputDecoration(
              labelText: 'Hometown',
              helperText: "* Required",
              errorText: snapshot.error as String?),
        );
      },
    );
  }


  Widget _countryOfOriginTextField() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.countryOfOrigin,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidateMode: AutovalidateMode.always,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Country of Origin',
                  helperText: "* Required",
                  errorText: snapshot.error as String?),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                value: snapshot.data,
                isExpanded: true,  
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


  Widget employmentTypeTextField() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.employmentType,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidateMode: AutovalidateMode.always,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Employment Type',
                  helperText: "* Required",
                  errorText: snapshot.error as String?),
          //    isEmpty: snapshot.data == null,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value:  snapshot.data,
                   isExpanded: true,  
                  isDense: true,
                  onChanged: (value){
                    if(value !=null){
                    accountFormBloc!.setEmploymentType(value);
                  }
                    },
                  items: employmentTypeList.map((String value) {
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

  Widget monthlyIncomeTextField() {
    return StreamBuilder<String?>(
      stream: accountFormBloc!.monthlyIncome,
      builder: (context, snapshot) {
        return FormField<String>(
          autovalidateMode: AutovalidateMode.always,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Monthly Income',
                  helperText: "* Required",
                  errorText: snapshot.error as String?),
           //   isEmpty: snapshot.data == null,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: snapshot.data,
                  isDense: true,
                  onChanged: (value){
                    if(value != null){
                      accountFormBloc!.setMonthlyIncome(value);
                    }
                  },
                  items: monthlyIncomeList.map((String value) {
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
      }
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
            _homeTownTextField(),
            SizedBox(height: 30.0),
            _countryOfOriginTextField(),
            SizedBox(height: 30.0),
            employmentTypeTextField(),
              SizedBox(height: 30.0),
            monthlyIncomeTextField(),
           //    SizedBox(height: 30.0),
           // sourceOfFundTextField(),

                  SizedBox(height: 10.0),
                    Divider(),
                  SizedBox(height: 10.0),
                  Text("Source of Funds"),
                   SizedBox(height: 10.0),
                  sourceOfAccountList(),
                    SizedBox(height: 15.0),
                  _otherSource(),
            SizedBox(height: 120.0),
          ],
        ),
      ),
    );
  }


  Widget _otherSource() {
    return StreamBuilder<bool?>(
        stream: accountFormBloc!.otherSource,
        builder: (context, snapshot) {
          return Visibility(
            visible: snapshot.hasData? snapshot.data! : false,
            child: StreamBuilder<String?>(
        stream: accountFormBloc!.enteredOtherSource,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

              if(_otherSourceController!.text != snapshot.data.toString()){
                
            _otherSourceController!.value = TextEditingValue(
                text: snapshot.data.toString(),
                selection: _otherSourceController!.selection);
              }
          }
          return TextField(
            controller: _otherSourceController,
            obscureText: false,
            keyboardType: TextInputType.text,
            onChanged: accountFormBloc!.changeEnterOtherSource,
            decoration: InputDecoration(
             labelText: 'Enter source',
              errorText: snapshot.error as String?,
            ),
          );
        })

          );
        
        });
  }



    Widget sourceOfAccountList()=>Column(
      children: [

        StreamBuilder<bool?>(
          stream: accountFormBloc!.salary,
          builder: (context, snapshot) {
            return CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("Salary"),
               activeColor: Colors.red,
              value: snapshot.hasData ? snapshot.data : false,
              onChanged: accountFormBloc!.changeSalary, 
              
              );
          }
        ),


       StreamBuilder<bool?>(
         stream: accountFormBloc!.rentalIncome,
         builder: (context, snapshot) {
           return CheckboxListTile(
             contentPadding: EdgeInsets.zero,
             title: Text("Rental Income"),
              activeColor: Colors.red,
             value: snapshot.hasData ? snapshot.data : false,
             onChanged: accountFormBloc!.changeRentalIncome );
         }
       ),

       StreamBuilder<bool?>(
         stream: accountFormBloc!.personalSaving,
         builder: (context, snapshot) {
           return CheckboxListTile(
             contentPadding: EdgeInsets.zero,
             title: Text("Personal Savings"),
              activeColor: Colors.red,
             value: snapshot.hasData ? snapshot.data : false,
             onChanged: accountFormBloc!.changePersonalSaving );
         }
       ),

       StreamBuilder<bool?>(
         stream: accountFormBloc!.familyFriend,
         builder: (context, snapshot) {
           return CheckboxListTile(
             contentPadding: EdgeInsets.zero,
             title: Text("Family & Friends"),
              activeColor: Colors.red,
             value: snapshot.hasData ? snapshot.data : false,
             onChanged: accountFormBloc!.changeFamilyFriend );
         }
       ),

       StreamBuilder<bool?>(
         stream: accountFormBloc!.dividends,
         builder: (context, snapshot) {
           return CheckboxListTile(
             contentPadding: EdgeInsets.zero,
             title: Text("Dividends"),
              activeColor: Colors.red,
             value: snapshot.hasData ? snapshot.data : false,
             onChanged: accountFormBloc!.changeDividends );
         }
       ),

       StreamBuilder<bool?>(
         stream: accountFormBloc!.commission,
         builder: (context, snapshot) {
           return CheckboxListTile(
             contentPadding: EdgeInsets.zero,
             title: Text("Commissions"),
              activeColor: Colors.red,
             value: snapshot.hasData ? snapshot.data : false,
             onChanged: accountFormBloc!.changeCommission );
         }
       ),

       StreamBuilder<bool?>(
         stream: accountFormBloc!.businessProceed,
         builder: (context, snapshot) {
           return CheckboxListTile(
             contentPadding: EdgeInsets.zero,
             title: Text("Business Proceeds"),
              activeColor: Colors.red,
             value: snapshot.hasData ? snapshot.data : false,
             onChanged: accountFormBloc!.changeBusinessProceed );
         }
       ),

       StreamBuilder<bool?>(
         stream: accountFormBloc!.otherSource,
         builder: (context, snapshot) {
           return CheckboxListTile(
             contentPadding: EdgeInsets.zero,
             title: Text("Other"),
              activeColor: Colors.red,
             value: snapshot.hasData ? snapshot.data : false,
             onChanged: accountFormBloc!.changeOtherSource );
         }
       ),

      ],
    );





}

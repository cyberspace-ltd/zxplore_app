import 'dart:async';

import 'package:zxplore_app/category.dart';

class Validators {
  final validateAccountType =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Account type is required');
    }
  });

  final validateAccountHolderType =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Account holder type is required');
    }
  });

  final validateRiskRank =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Risk rank is required');
    }
  });

  final validateAccountCategory =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.isNotEmpty && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Account Category is required');
    }
  });

  final validateBvn =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.isNotEmpty ) {
      sink.add(arg);
    } else {
      sink.addError('A valid Ghana card mumber is required');
    }
  });

  final validateTitle =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.isNotEmpty && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Title is required');
    }
  });

  final validateSurname =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    Pattern pattern = r'[!$₦/@#<>?":_`~;[\]\\|=+)(*&^%0-9]';
    RegExp regex = new RegExp(pattern as String);
    if (arg != null &&
        arg.isNotEmpty &&
        arg.length > 2 &&
        !regex.hasMatch(arg)) {
      sink.add(arg);
    } else if (arg != null && arg.isEmpty) {
      sink.addError('Surname is required');
    } else {
      sink.addError('Enter a valid surname');
    }
  });

  final validateFirstName =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    Pattern pattern = r'[!$₦/@#<>?":_`~;[\]\\|=+)(*&^%0-9]';
    RegExp regex = new RegExp(pattern as String);
    if (arg != null &&
        arg.isNotEmpty &&
        arg.length > 2 &&
        !regex.hasMatch(arg)) {
      sink.add(arg);
    } else if (arg != null && arg.isEmpty) {
      sink.addError('First name is required');
    } else {
      sink.addError('Enter a valid first name ');
    }
  });

  final validateOtherName =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    Pattern pattern = r'[!$₦/@#<>?":_`~;[\]\\|=+)(*&^%0-9]';
    RegExp regex = new RegExp(pattern as String);
    if (arg != null && !regex.hasMatch(arg)) {
      sink.add(arg);
    } else {
      sink.addError('Enter a valid Othername');
    }
  });

  final validateMothersMaidenName =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    Pattern pattern = r'[!$₦/@#<>?":_`~;[\]\\|=+)(*&^%0-9]';
    RegExp regex = new RegExp(pattern as String);
    if (arg != null &&
        arg.isNotEmpty &&
        arg.length > 2 &&
        !regex.hasMatch(arg)) {
      sink.add(arg);
    } else if (arg != null && arg.isEmpty) {
      sink.addError('Mother\'s maiden name is required');
    } else {
      sink.addError('Enter a valid mother\'s maiden name');
    }
  });

  final validateDateOfBirth =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.isNotEmpty && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Date of birth is required');
    }
  });

  final validateStateOfOrigin =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.isNotEmpty && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Region of Residence is required');
    }
  });
  final validatePlaceOfBirth =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.isNotEmpty && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Place of Birth is required');
    }
  });

  final validateCountryOfOrigin =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.isNotEmpty && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Country of origin is required');
    }
  });

  final validateCurrentFormCategory =
      StreamTransformer<Category, Category>.fromHandlers(
          handleData: (arg, sink) {
    sink.add(arg);
  });

  final validateEmail = StreamTransformer<String?, String>.fromHandlers(
      handleData: (email, sink) {
    if (email != null && email.isNotEmpty && email.length < 1) {
      sink.add(
          email); //unique to this application, as email field isn't compulsory
    } else if (email != null &&
        RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Enter a valid email');
    }
  });

  final validateUsername = StreamTransformer<String?, String>.fromHandlers(
      handleData: (username, sink) {
    if (username != null) {
      sink.add(username);
    } else {
      sink.addError('Ensure your username is valid & not empty');
    }
  });

  final validatePhoneNumber =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    print(arg);
    if (arg != null && arg.length > 8 && arg.length < 11) {
      sink.add(arg);
    } else {
      sink.addError('Mobile Number must be a valid phone number');
    }
  });

  final validateNextOfKin =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    Pattern pattern = r'[!$₦/@#<>?":_`~;[\]\\|=+)(*&^%0-9]';
    RegExp regex = new RegExp(pattern as String);
    if (arg != null &&
        arg.isNotEmpty &&
        arg.length > 2 &&
        !regex.hasMatch(arg)) {
      sink.add(arg);
    } else if (arg != null && arg.isEmpty) {
      sink.addError('Next of kin is required');
    } else {
      sink.addError('Enter a valid Next of kin name');
    }
  });

  final validateAddress1 =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Address is required');
    }
  });

  final validateCountryOfResidence =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Country of residence is required');
    }
  });

  final validateStateOfResidence =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Region of Residence is required');
    }
  });

  final validateMMDA =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('MMDA is required');
    }
  });

  final validateCityOfResidence =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('City of residence is required');
    }
  });

  final validateGender =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Gender is required');
    }
  });

  final validateOccupation =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Occupation is required');
    }
  });

  final validateMaritalStatus =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Marital status is required');
    }
  });

  final validateIdType =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('ID type is required');
    }
  });

  final validateIdIssuer =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('ID issuer is required');
    }
  });

  final validateIdNumber =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('ID number is required');
    }
  });

  final validateIdPlaceOfIssue =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('ID place of issue is required');
    }
  });

  final validateIdIssueDate =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('ID issue date is required');
    }
  });

  final validateIdExpiryDate =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('ID expiry date is required');
    }
  });

  final validatePassword = StreamTransformer<String?, String>.fromHandlers(
      handleData: (password, sink) {
    if (password != null && password.length > 3) {
      sink.add(password);
    } else {
      sink.addError('Invalid password, please enter more than 3 characters');
    }
  });

  final validateCardType =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.isNotEmpty && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Card Type is required');
    }
  });

  final validateRequestingBranch =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Requesting branch is required');
    }
  });

  final validateDestinationBranch =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Destination branch is required');
    }
  });

  final validatePreferredNameOnCard =
      StreamTransformer<String?, String>.fromHandlers(handleData: (arg, sink) {
    if (arg != null && arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Destination branch is required');
    }
  });
}

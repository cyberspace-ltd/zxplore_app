import 'dart:async';

class Validators {
  final validateAccountType =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Account type is required');
    }
  });

  final validateAccountHolderType =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Account holder type is required');
    }
  });

  final validateRiskRank =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Risk rank is required');
    }
  });

  final validateAccountCategory =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Account Category is required');
    }
  });

  final validateBvn =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length >= 11) {
      sink.add(arg);
    } else {
      sink.addError('A valid BVN is required');
    }
  });

  final validateTitle =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Title is required');
    }
  });

  final validateSurname =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Surname is required');
    }
  });

  final validateFirstName =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('First name is required');
    }
  });

  final validateMothersMaidenName =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Mother\'s maiden name is required');
    }
  });

  final validateDateOfBirth =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Date of birth is required');
    }
  });

  final validateStateOfOrigin =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('State of origin is required');
    }
  });

  final validateCountryOfOrigin =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Country of origin is required');
    }
  });

  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@')) {
      sink.add(email);
    } else {
      sink.addError('Enter a valid email');
    }
  });

  final validateUsername = StreamTransformer<String, String>.fromHandlers(
      handleData: (username, sink) {
    if (username.contains('@')) {
      sink.addError(
          'Ensure your username is in the format of firstname.lastname');
    } else if (!username.contains('.')) {
      sink.addError(
          'Ensure your username is in the format of firstname.lastname');
    } else {
      sink.add(username);
    }
  });

  final validatePhoneNumber =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length == 10) {
      sink.add(arg);
    } else {
      sink.addError('Mobile Number must be of 10 digit');
    }
  });

  final validateNextOfKin =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Next of kin is required');
    }
  });

  final validateAddress1 =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Address is required');
    }
  });

  final validateCountryOfResidence =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Country of residence is required');
    }
  });

  final validateStateOfResidence =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('State of residence is required');
    }
  });

  final validateCityOfResidence =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('City of residence is required');
    }
  });

  final validateGender =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Gender is required');
    }
  });

  final validateOccupation =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Occupation is required');
    }
  });

  final validateMaritalStatus =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('Marital status is required');
    }
  });

  final validateIdType =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('ID type is required');
    }
  });

  final validateIdIssuer =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('ID issuer is required');
    }
  });

  final validateIdNumber =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('ID number is required');
    }
  });

  final validateIdPlaceOfIssue =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('ID place of issue is required');
    }
  });

  final validateIdIssueDate =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('ID issue date is required');
    }
  });

  final validateIdExpiryDate =
      StreamTransformer<String, String>.fromHandlers(handleData: (arg, sink) {
    if (arg.length > 2) {
      sink.add(arg);
    } else {
      sink.addError('ID expiry date is required');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 3) {
      sink.add(password);
    } else {
      sink.addError('Invalid password, please enter more than 3 characters');
    }
  });
}

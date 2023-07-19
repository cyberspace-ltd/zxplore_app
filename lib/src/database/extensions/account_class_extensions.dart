import 'package:drift/drift.dart';
import 'package:zxplore_app/src/api/models/account_class_response.dart';
import 'package:zxplore_app/src/database/database.dart';

extension AccountClassCodeToEntityCompanion on AccountClassCode {
  AccountClassEntityCompanion toEntityCompanion() {
    return AccountClassEntityCompanion(
      id: Value(classCode!),
      name: Value(description),
      type: Value(classType),
    );
  }
}

extension AccountClassToDBModel on AccountClassCode {
  AccountClass toDBModel() {
    return AccountClass(
      id: classCode!,
      name: description,
      type: classType,
    );
  }
}

extension AccountClassToModel on AccountClass {
  AccountClassCode toDomainModel() {
    return AccountClassCode(
      classCode: id,
      description: name,
      classType: type,
    );
  }
}

import 'package:drift/drift.dart';

@DataClassName('AccountClass')
class AccountClassEntity extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  TextColumn get type => text().nullable()();
}

@DataClassName('City')
class CityEntity extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
}

@DataClassName('Country')
class CountryEntity extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
}

@DataClassName('Occupation')
class OccupationEntity extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
}

@DataClassName('State')
class StateEntity extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
}

@DataClassName('OfflineAccount')
class OfflineAccountEntity extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get referenceId => text().nullable()();
  TextColumn get accountType => text().nullable()();
  TextColumn get accountHolderType => text().nullable()();
  TextColumn get riskRank => text().nullable()();
  TextColumn get accountCategory => text().nullable()();
  TextColumn get bvn => text().nullable()();
  TextColumn get title => text().nullable()();
  TextColumn get surname => text().nullable()();
  TextColumn get firstName => text().nullable()();
  TextColumn get otherName => text().nullable()();
  TextColumn get mothersMaidenName => text().nullable()();
  TextColumn get dateOfBirth => text().nullable()();
  TextColumn get stateOfOrigin => text().nullable()();
  TextColumn get countryOfOrigin => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get nextOfKin => text().nullable()();
  TextColumn get address1 => text().nullable()();
  TextColumn get address2 => text().nullable()();
  TextColumn get countryOfResidence => text().nullable()();
  TextColumn get stateOfResidence => text().nullable()();
  TextColumn get cityOfResidence => text().nullable()();
  TextColumn get gender => text().nullable()();
  TextColumn get occupation => text().nullable()();
  TextColumn get maritalStatus => text().nullable()();
  TextColumn get idType => text().nullable()();
  TextColumn get idIssuer => text().nullable()();
  TextColumn get idNumber => text().nullable()();
  TextColumn get idPlaceOfIssue => text().nullable()();
  TextColumn get idIssueDate => text().nullable()();
  TextColumn get idExpiryDate => text().nullable()();
  BoolColumn get isSendEmail => boolean().nullable()();
  BoolColumn get isReceiveAlert => boolean().nullable()();
  BoolColumn get isRequestHardwareToken => boolean().nullable()();
  BoolColumn get isRequestInternetBanking => boolean().nullable()();
  TextColumn get idCard => text().nullable()();
  TextColumn get passport => text().nullable()();
  TextColumn get utility => text().nullable()();
  TextColumn get signature => text().nullable()();
}

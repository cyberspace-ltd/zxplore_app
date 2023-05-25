import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:zxplore_app/src/database/tables.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    AccountClassEntity,
    CityEntity,
    CountryEntity,
    OccupationEntity,
    StateEntity,
    OfflineAccountEntity,
  ],
)
class AppDatabase extends _$AppDatabase {
  // we tell the database where to store the data with this constructor
  AppDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 2;

  static final StateProvider<AppDatabase> provider = StateProvider((ref) {
    final database = AppDatabase();
    ref.onDispose(database.close);

    return database;
  });

  // returns the generated id
  Future<int> insertOfflineAccountEntity(OfflineAccountEntityCompanion entry) =>
      into(offlineAccountEntity).insert(entry);

  Future<List<OfflineAccount>> getOfflineAccounts() =>
      select(offlineAccountEntity).get();

  // get single offline account
  Future<OfflineAccount?> getOfflineAccount(int id) =>
      (select(offlineAccountEntity)..where((tbl) => tbl.id.equals(id)))
          .getSingleOrNull();

  // update offline account
  Future<bool> updateOfflineAccountEntity(OfflineAccount entry) =>
      update(offlineAccountEntity).replace(entry);

  // delete offline account
  Future<bool> deleteOfflineAccountEntity(int id) =>
      (delete(offlineAccountEntity)..where((tbl) => tbl.id.equals(id)))
          .go()
          .then((value) => value > 0);

  // insert list of occupations
  Future<void> insertOccupations(List<OccupationEntityCompanion> entries) =>
      batch((batch) {
        batch.insertAll(occupationEntity, entries);
      });

  // get list of occupations
  Future<List<Occupation>> getOccupations() => select(occupationEntity).get();

  // insert list of countries
  Future<void> insertCountries(List<CountryEntityCompanion> entries) =>
      batch((batch) {
        batch.insertAll(countryEntity, entries);
      });

  // get list of countries
  Future<List<Country>> getCountries() => select(countryEntity).get();

  // insert list of states
  Future<void> insertStates(List<StateEntityCompanion> entries) =>
      batch((batch) {
        batch.insertAll(stateEntity, entries);
      });

  // get list of states
  Future<List<State>> getStates() => select(stateEntity).get();

  // insert list of cities
  Future<void> insertCities(List<CityEntityCompanion> entries) =>
      batch((batch) {
        batch.insertAll(cityEntity, entries);
      });

  // get list of cities
  Future<List<City>> getCities() => select(cityEntity).get();

  // insert list of account classes
  Future<void> insertAccountClasses(
          List<AccountClassEntityCompanion> entries) =>
      batch((batch) {
        batch.insertAll(accountClassEntity, entries);
      });

  // get list of account classes
  Future<List<AccountClass>> getAccountClasses() =>
      select(accountClassEntity).get();
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

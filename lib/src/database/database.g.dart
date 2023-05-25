// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AccountClassEntityTable extends AccountClassEntity
    with TableInfo<$AccountClassEntityTable, AccountClass> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountClassEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name, type];
  @override
  String get aliasedName => _alias ?? 'account_class_entity';
  @override
  String get actualTableName => 'account_class_entity';
  @override
  VerificationContext validateIntegrity(Insertable<AccountClass> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountClass map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountClass(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type']),
    );
  }

  @override
  $AccountClassEntityTable createAlias(String alias) {
    return $AccountClassEntityTable(attachedDatabase, alias);
  }
}

class AccountClass extends DataClass implements Insertable<AccountClass> {
  final int id;
  final String? name;
  final String? type;
  const AccountClass({required this.id, this.name, this.type});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    return map;
  }

  AccountClassEntityCompanion toCompanion(bool nullToAbsent) {
    return AccountClassEntityCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
    );
  }

  factory AccountClass.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountClass(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      type: serializer.fromJson<String?>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
      'type': serializer.toJson<String?>(type),
    };
  }

  AccountClass copyWith(
          {int? id,
          Value<String?> name = const Value.absent(),
          Value<String?> type = const Value.absent()}) =>
      AccountClass(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        type: type.present ? type.value : this.type,
      );
  @override
  String toString() {
    return (StringBuffer('AccountClass(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountClass &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type);
}

class AccountClassEntityCompanion extends UpdateCompanion<AccountClass> {
  final Value<int> id;
  final Value<String?> name;
  final Value<String?> type;
  const AccountClassEntityCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
  });
  AccountClassEntityCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
  });
  static Insertable<AccountClass> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
    });
  }

  AccountClassEntityCompanion copyWith(
      {Value<int>? id, Value<String?>? name, Value<String?>? type}) {
    return AccountClassEntityCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountClassEntityCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $CityEntityTable extends CityEntity
    with TableInfo<$CityEntityTable, City> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CityEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? 'city_entity';
  @override
  String get actualTableName => 'city_entity';
  @override
  VerificationContext validateIntegrity(Insertable<City> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  City map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return City(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
    );
  }

  @override
  $CityEntityTable createAlias(String alias) {
    return $CityEntityTable(attachedDatabase, alias);
  }
}

class City extends DataClass implements Insertable<City> {
  final int id;
  final String? name;
  const City({required this.id, this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    return map;
  }

  CityEntityCompanion toCompanion(bool nullToAbsent) {
    return CityEntityCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  factory City.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return City(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
    };
  }

  City copyWith({int? id, Value<String?> name = const Value.absent()}) => City(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
      );
  @override
  String toString() {
    return (StringBuffer('City(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is City && other.id == this.id && other.name == this.name);
}

class CityEntityCompanion extends UpdateCompanion<City> {
  final Value<int> id;
  final Value<String?> name;
  const CityEntityCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  CityEntityCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  static Insertable<City> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  CityEntityCompanion copyWith({Value<int>? id, Value<String?>? name}) {
    return CityEntityCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CityEntityCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $CountryEntityTable extends CountryEntity
    with TableInfo<$CountryEntityTable, Country> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CountryEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? 'country_entity';
  @override
  String get actualTableName => 'country_entity';
  @override
  VerificationContext validateIntegrity(Insertable<Country> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Country map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Country(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
    );
  }

  @override
  $CountryEntityTable createAlias(String alias) {
    return $CountryEntityTable(attachedDatabase, alias);
  }
}

class Country extends DataClass implements Insertable<Country> {
  final int id;
  final String? name;
  const Country({required this.id, this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    return map;
  }

  CountryEntityCompanion toCompanion(bool nullToAbsent) {
    return CountryEntityCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  factory Country.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Country(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
    };
  }

  Country copyWith({int? id, Value<String?> name = const Value.absent()}) =>
      Country(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Country(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Country && other.id == this.id && other.name == this.name);
}

class CountryEntityCompanion extends UpdateCompanion<Country> {
  final Value<int> id;
  final Value<String?> name;
  const CountryEntityCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  CountryEntityCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  static Insertable<Country> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  CountryEntityCompanion copyWith({Value<int>? id, Value<String?>? name}) {
    return CountryEntityCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CountryEntityCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $OccupationEntityTable extends OccupationEntity
    with TableInfo<$OccupationEntityTable, Occupation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OccupationEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? 'occupation_entity';
  @override
  String get actualTableName => 'occupation_entity';
  @override
  VerificationContext validateIntegrity(Insertable<Occupation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Occupation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Occupation(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
    );
  }

  @override
  $OccupationEntityTable createAlias(String alias) {
    return $OccupationEntityTable(attachedDatabase, alias);
  }
}

class Occupation extends DataClass implements Insertable<Occupation> {
  final int id;
  final String? name;
  const Occupation({required this.id, this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    return map;
  }

  OccupationEntityCompanion toCompanion(bool nullToAbsent) {
    return OccupationEntityCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  factory Occupation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Occupation(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
    };
  }

  Occupation copyWith({int? id, Value<String?> name = const Value.absent()}) =>
      Occupation(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Occupation(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Occupation && other.id == this.id && other.name == this.name);
}

class OccupationEntityCompanion extends UpdateCompanion<Occupation> {
  final Value<int> id;
  final Value<String?> name;
  const OccupationEntityCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  OccupationEntityCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  static Insertable<Occupation> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  OccupationEntityCompanion copyWith({Value<int>? id, Value<String?>? name}) {
    return OccupationEntityCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OccupationEntityCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $StateEntityTable extends StateEntity
    with TableInfo<$StateEntityTable, State> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StateEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? 'state_entity';
  @override
  String get actualTableName => 'state_entity';
  @override
  VerificationContext validateIntegrity(Insertable<State> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  State map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return State(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
    );
  }

  @override
  $StateEntityTable createAlias(String alias) {
    return $StateEntityTable(attachedDatabase, alias);
  }
}

class State extends DataClass implements Insertable<State> {
  final int id;
  final String? name;
  const State({required this.id, this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    return map;
  }

  StateEntityCompanion toCompanion(bool nullToAbsent) {
    return StateEntityCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  factory State.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return State(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
    };
  }

  State copyWith({int? id, Value<String?> name = const Value.absent()}) =>
      State(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
      );
  @override
  String toString() {
    return (StringBuffer('State(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is State && other.id == this.id && other.name == this.name);
}

class StateEntityCompanion extends UpdateCompanion<State> {
  final Value<int> id;
  final Value<String?> name;
  const StateEntityCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  StateEntityCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  static Insertable<State> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  StateEntityCompanion copyWith({Value<int>? id, Value<String?>? name}) {
    return StateEntityCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StateEntityCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $OfflineAccountEntityTable extends OfflineAccountEntity
    with TableInfo<$OfflineAccountEntityTable, OfflineAccount> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OfflineAccountEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _referenceIdMeta =
      const VerificationMeta('referenceId');
  @override
  late final GeneratedColumn<String> referenceId = GeneratedColumn<String>(
      'reference_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _accountTypeMeta =
      const VerificationMeta('accountType');
  @override
  late final GeneratedColumn<String> accountType = GeneratedColumn<String>(
      'account_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _accountHolderTypeMeta =
      const VerificationMeta('accountHolderType');
  @override
  late final GeneratedColumn<String> accountHolderType =
      GeneratedColumn<String>('account_holder_type', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _riskRankMeta =
      const VerificationMeta('riskRank');
  @override
  late final GeneratedColumn<String> riskRank = GeneratedColumn<String>(
      'risk_rank', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _accountCategoryMeta =
      const VerificationMeta('accountCategory');
  @override
  late final GeneratedColumn<String> accountCategory = GeneratedColumn<String>(
      'account_category', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _bvnMeta = const VerificationMeta('bvn');
  @override
  late final GeneratedColumn<String> bvn = GeneratedColumn<String>(
      'bvn', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _surnameMeta =
      const VerificationMeta('surname');
  @override
  late final GeneratedColumn<String> surname = GeneratedColumn<String>(
      'surname', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _otherNameMeta =
      const VerificationMeta('otherName');
  @override
  late final GeneratedColumn<String> otherName = GeneratedColumn<String>(
      'other_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _mothersMaidenNameMeta =
      const VerificationMeta('mothersMaidenName');
  @override
  late final GeneratedColumn<String> mothersMaidenName =
      GeneratedColumn<String>('mothers_maiden_name', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dateOfBirthMeta =
      const VerificationMeta('dateOfBirth');
  @override
  late final GeneratedColumn<String> dateOfBirth = GeneratedColumn<String>(
      'date_of_birth', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _stateOfOriginMeta =
      const VerificationMeta('stateOfOrigin');
  @override
  late final GeneratedColumn<String> stateOfOrigin = GeneratedColumn<String>(
      'state_of_origin', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _countryOfOriginMeta =
      const VerificationMeta('countryOfOrigin');
  @override
  late final GeneratedColumn<String> countryOfOrigin = GeneratedColumn<String>(
      'country_of_origin', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nextOfKinMeta =
      const VerificationMeta('nextOfKin');
  @override
  late final GeneratedColumn<String> nextOfKin = GeneratedColumn<String>(
      'next_of_kin', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _address1Meta =
      const VerificationMeta('address1');
  @override
  late final GeneratedColumn<String> address1 = GeneratedColumn<String>(
      'address1', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _address2Meta =
      const VerificationMeta('address2');
  @override
  late final GeneratedColumn<String> address2 = GeneratedColumn<String>(
      'address2', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _countryOfResidenceMeta =
      const VerificationMeta('countryOfResidence');
  @override
  late final GeneratedColumn<String> countryOfResidence =
      GeneratedColumn<String>('country_of_residence', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _stateOfResidenceMeta =
      const VerificationMeta('stateOfResidence');
  @override
  late final GeneratedColumn<String> stateOfResidence = GeneratedColumn<String>(
      'state_of_residence', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cityOfResidenceMeta =
      const VerificationMeta('cityOfResidence');
  @override
  late final GeneratedColumn<String> cityOfResidence = GeneratedColumn<String>(
      'city_of_residence', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _occupationMeta =
      const VerificationMeta('occupation');
  @override
  late final GeneratedColumn<String> occupation = GeneratedColumn<String>(
      'occupation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _maritalStatusMeta =
      const VerificationMeta('maritalStatus');
  @override
  late final GeneratedColumn<String> maritalStatus = GeneratedColumn<String>(
      'marital_status', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _idTypeMeta = const VerificationMeta('idType');
  @override
  late final GeneratedColumn<String> idType = GeneratedColumn<String>(
      'id_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _idIssuerMeta =
      const VerificationMeta('idIssuer');
  @override
  late final GeneratedColumn<String> idIssuer = GeneratedColumn<String>(
      'id_issuer', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _idNumberMeta =
      const VerificationMeta('idNumber');
  @override
  late final GeneratedColumn<String> idNumber = GeneratedColumn<String>(
      'id_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _idPlaceOfIssueMeta =
      const VerificationMeta('idPlaceOfIssue');
  @override
  late final GeneratedColumn<String> idPlaceOfIssue = GeneratedColumn<String>(
      'id_place_of_issue', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _idIssueDateMeta =
      const VerificationMeta('idIssueDate');
  @override
  late final GeneratedColumn<String> idIssueDate = GeneratedColumn<String>(
      'id_issue_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _idExpiryDateMeta =
      const VerificationMeta('idExpiryDate');
  @override
  late final GeneratedColumn<String> idExpiryDate = GeneratedColumn<String>(
      'id_expiry_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isSendEmailMeta =
      const VerificationMeta('isSendEmail');
  @override
  late final GeneratedColumn<bool> isSendEmail =
      GeneratedColumn<bool>('is_send_email', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_send_email" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _isReceiveAlertMeta =
      const VerificationMeta('isReceiveAlert');
  @override
  late final GeneratedColumn<bool> isReceiveAlert =
      GeneratedColumn<bool>('is_receive_alert', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_receive_alert" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _isRequestHardwareTokenMeta =
      const VerificationMeta('isRequestHardwareToken');
  @override
  late final GeneratedColumn<bool> isRequestHardwareToken =
      GeneratedColumn<bool>('is_request_hardware_token', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_request_hardware_token" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _isRequestInternetBankingMeta =
      const VerificationMeta('isRequestInternetBanking');
  @override
  late final GeneratedColumn<bool> isRequestInternetBanking =
      GeneratedColumn<bool>('is_request_internet_banking', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite:
                'CHECK ("is_request_internet_banking" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _idCardMeta = const VerificationMeta('idCard');
  @override
  late final GeneratedColumn<String> idCard = GeneratedColumn<String>(
      'id_card', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _passportMeta =
      const VerificationMeta('passport');
  @override
  late final GeneratedColumn<String> passport = GeneratedColumn<String>(
      'passport', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _utilityMeta =
      const VerificationMeta('utility');
  @override
  late final GeneratedColumn<String> utility = GeneratedColumn<String>(
      'utility', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _signatureMeta =
      const VerificationMeta('signature');
  @override
  late final GeneratedColumn<String> signature = GeneratedColumn<String>(
      'signature', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        referenceId,
        accountType,
        accountHolderType,
        riskRank,
        accountCategory,
        bvn,
        title,
        surname,
        firstName,
        otherName,
        mothersMaidenName,
        dateOfBirth,
        stateOfOrigin,
        countryOfOrigin,
        email,
        phone,
        nextOfKin,
        address1,
        address2,
        countryOfResidence,
        stateOfResidence,
        cityOfResidence,
        gender,
        occupation,
        maritalStatus,
        idType,
        idIssuer,
        idNumber,
        idPlaceOfIssue,
        idIssueDate,
        idExpiryDate,
        isSendEmail,
        isReceiveAlert,
        isRequestHardwareToken,
        isRequestInternetBanking,
        idCard,
        passport,
        utility,
        signature
      ];
  @override
  String get aliasedName => _alias ?? 'offline_account_entity';
  @override
  String get actualTableName => 'offline_account_entity';
  @override
  VerificationContext validateIntegrity(Insertable<OfflineAccount> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('reference_id')) {
      context.handle(
          _referenceIdMeta,
          referenceId.isAcceptableOrUnknown(
              data['reference_id']!, _referenceIdMeta));
    }
    if (data.containsKey('account_type')) {
      context.handle(
          _accountTypeMeta,
          accountType.isAcceptableOrUnknown(
              data['account_type']!, _accountTypeMeta));
    }
    if (data.containsKey('account_holder_type')) {
      context.handle(
          _accountHolderTypeMeta,
          accountHolderType.isAcceptableOrUnknown(
              data['account_holder_type']!, _accountHolderTypeMeta));
    }
    if (data.containsKey('risk_rank')) {
      context.handle(_riskRankMeta,
          riskRank.isAcceptableOrUnknown(data['risk_rank']!, _riskRankMeta));
    }
    if (data.containsKey('account_category')) {
      context.handle(
          _accountCategoryMeta,
          accountCategory.isAcceptableOrUnknown(
              data['account_category']!, _accountCategoryMeta));
    }
    if (data.containsKey('bvn')) {
      context.handle(
          _bvnMeta, bvn.isAcceptableOrUnknown(data['bvn']!, _bvnMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('surname')) {
      context.handle(_surnameMeta,
          surname.isAcceptableOrUnknown(data['surname']!, _surnameMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    }
    if (data.containsKey('other_name')) {
      context.handle(_otherNameMeta,
          otherName.isAcceptableOrUnknown(data['other_name']!, _otherNameMeta));
    }
    if (data.containsKey('mothers_maiden_name')) {
      context.handle(
          _mothersMaidenNameMeta,
          mothersMaidenName.isAcceptableOrUnknown(
              data['mothers_maiden_name']!, _mothersMaidenNameMeta));
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
          _dateOfBirthMeta,
          dateOfBirth.isAcceptableOrUnknown(
              data['date_of_birth']!, _dateOfBirthMeta));
    }
    if (data.containsKey('state_of_origin')) {
      context.handle(
          _stateOfOriginMeta,
          stateOfOrigin.isAcceptableOrUnknown(
              data['state_of_origin']!, _stateOfOriginMeta));
    }
    if (data.containsKey('country_of_origin')) {
      context.handle(
          _countryOfOriginMeta,
          countryOfOrigin.isAcceptableOrUnknown(
              data['country_of_origin']!, _countryOfOriginMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('next_of_kin')) {
      context.handle(
          _nextOfKinMeta,
          nextOfKin.isAcceptableOrUnknown(
              data['next_of_kin']!, _nextOfKinMeta));
    }
    if (data.containsKey('address1')) {
      context.handle(_address1Meta,
          address1.isAcceptableOrUnknown(data['address1']!, _address1Meta));
    }
    if (data.containsKey('address2')) {
      context.handle(_address2Meta,
          address2.isAcceptableOrUnknown(data['address2']!, _address2Meta));
    }
    if (data.containsKey('country_of_residence')) {
      context.handle(
          _countryOfResidenceMeta,
          countryOfResidence.isAcceptableOrUnknown(
              data['country_of_residence']!, _countryOfResidenceMeta));
    }
    if (data.containsKey('state_of_residence')) {
      context.handle(
          _stateOfResidenceMeta,
          stateOfResidence.isAcceptableOrUnknown(
              data['state_of_residence']!, _stateOfResidenceMeta));
    }
    if (data.containsKey('city_of_residence')) {
      context.handle(
          _cityOfResidenceMeta,
          cityOfResidence.isAcceptableOrUnknown(
              data['city_of_residence']!, _cityOfResidenceMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('occupation')) {
      context.handle(
          _occupationMeta,
          occupation.isAcceptableOrUnknown(
              data['occupation']!, _occupationMeta));
    }
    if (data.containsKey('marital_status')) {
      context.handle(
          _maritalStatusMeta,
          maritalStatus.isAcceptableOrUnknown(
              data['marital_status']!, _maritalStatusMeta));
    }
    if (data.containsKey('id_type')) {
      context.handle(_idTypeMeta,
          idType.isAcceptableOrUnknown(data['id_type']!, _idTypeMeta));
    }
    if (data.containsKey('id_issuer')) {
      context.handle(_idIssuerMeta,
          idIssuer.isAcceptableOrUnknown(data['id_issuer']!, _idIssuerMeta));
    }
    if (data.containsKey('id_number')) {
      context.handle(_idNumberMeta,
          idNumber.isAcceptableOrUnknown(data['id_number']!, _idNumberMeta));
    }
    if (data.containsKey('id_place_of_issue')) {
      context.handle(
          _idPlaceOfIssueMeta,
          idPlaceOfIssue.isAcceptableOrUnknown(
              data['id_place_of_issue']!, _idPlaceOfIssueMeta));
    }
    if (data.containsKey('id_issue_date')) {
      context.handle(
          _idIssueDateMeta,
          idIssueDate.isAcceptableOrUnknown(
              data['id_issue_date']!, _idIssueDateMeta));
    }
    if (data.containsKey('id_expiry_date')) {
      context.handle(
          _idExpiryDateMeta,
          idExpiryDate.isAcceptableOrUnknown(
              data['id_expiry_date']!, _idExpiryDateMeta));
    }
    if (data.containsKey('is_send_email')) {
      context.handle(
          _isSendEmailMeta,
          isSendEmail.isAcceptableOrUnknown(
              data['is_send_email']!, _isSendEmailMeta));
    }
    if (data.containsKey('is_receive_alert')) {
      context.handle(
          _isReceiveAlertMeta,
          isReceiveAlert.isAcceptableOrUnknown(
              data['is_receive_alert']!, _isReceiveAlertMeta));
    }
    if (data.containsKey('is_request_hardware_token')) {
      context.handle(
          _isRequestHardwareTokenMeta,
          isRequestHardwareToken.isAcceptableOrUnknown(
              data['is_request_hardware_token']!, _isRequestHardwareTokenMeta));
    }
    if (data.containsKey('is_request_internet_banking')) {
      context.handle(
          _isRequestInternetBankingMeta,
          isRequestInternetBanking.isAcceptableOrUnknown(
              data['is_request_internet_banking']!,
              _isRequestInternetBankingMeta));
    }
    if (data.containsKey('id_card')) {
      context.handle(_idCardMeta,
          idCard.isAcceptableOrUnknown(data['id_card']!, _idCardMeta));
    }
    if (data.containsKey('passport')) {
      context.handle(_passportMeta,
          passport.isAcceptableOrUnknown(data['passport']!, _passportMeta));
    }
    if (data.containsKey('utility')) {
      context.handle(_utilityMeta,
          utility.isAcceptableOrUnknown(data['utility']!, _utilityMeta));
    }
    if (data.containsKey('signature')) {
      context.handle(_signatureMeta,
          signature.isAcceptableOrUnknown(data['signature']!, _signatureMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OfflineAccount map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OfflineAccount(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      referenceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference_id']),
      accountType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account_type']),
      accountHolderType: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}account_holder_type']),
      riskRank: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}risk_rank']),
      accountCategory: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}account_category']),
      bvn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bvn']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      surname: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}surname']),
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name']),
      otherName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}other_name']),
      mothersMaidenName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}mothers_maiden_name']),
      dateOfBirth: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date_of_birth']),
      stateOfOrigin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}state_of_origin']),
      countryOfOrigin: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}country_of_origin']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      nextOfKin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}next_of_kin']),
      address1: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address1']),
      address2: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address2']),
      countryOfResidence: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}country_of_residence']),
      stateOfResidence: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}state_of_residence']),
      cityOfResidence: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}city_of_residence']),
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender']),
      occupation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}occupation']),
      maritalStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}marital_status']),
      idType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id_type']),
      idIssuer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id_issuer']),
      idNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id_number']),
      idPlaceOfIssue: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}id_place_of_issue']),
      idIssueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id_issue_date']),
      idExpiryDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id_expiry_date']),
      isSendEmail: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_send_email']),
      isReceiveAlert: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_receive_alert']),
      isRequestHardwareToken: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}is_request_hardware_token']),
      isRequestInternetBanking: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}is_request_internet_banking']),
      idCard: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id_card']),
      passport: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}passport']),
      utility: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}utility']),
      signature: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}signature']),
    );
  }

  @override
  $OfflineAccountEntityTable createAlias(String alias) {
    return $OfflineAccountEntityTable(attachedDatabase, alias);
  }
}

class OfflineAccount extends DataClass implements Insertable<OfflineAccount> {
  final int id;
  final String? referenceId;
  final String? accountType;
  final String? accountHolderType;
  final String? riskRank;
  final String? accountCategory;
  final String? bvn;
  final String? title;
  final String? surname;
  final String? firstName;
  final String? otherName;
  final String? mothersMaidenName;
  final String? dateOfBirth;
  final String? stateOfOrigin;
  final String? countryOfOrigin;
  final String? email;
  final String? phone;
  final String? nextOfKin;
  final String? address1;
  final String? address2;
  final String? countryOfResidence;
  final String? stateOfResidence;
  final String? cityOfResidence;
  final String? gender;
  final String? occupation;
  final String? maritalStatus;
  final String? idType;
  final String? idIssuer;
  final String? idNumber;
  final String? idPlaceOfIssue;
  final String? idIssueDate;
  final String? idExpiryDate;
  final bool? isSendEmail;
  final bool? isReceiveAlert;
  final bool? isRequestHardwareToken;
  final bool? isRequestInternetBanking;
  final String? idCard;
  final String? passport;
  final String? utility;
  final String? signature;
  const OfflineAccount(
      {required this.id,
      this.referenceId,
      this.accountType,
      this.accountHolderType,
      this.riskRank,
      this.accountCategory,
      this.bvn,
      this.title,
      this.surname,
      this.firstName,
      this.otherName,
      this.mothersMaidenName,
      this.dateOfBirth,
      this.stateOfOrigin,
      this.countryOfOrigin,
      this.email,
      this.phone,
      this.nextOfKin,
      this.address1,
      this.address2,
      this.countryOfResidence,
      this.stateOfResidence,
      this.cityOfResidence,
      this.gender,
      this.occupation,
      this.maritalStatus,
      this.idType,
      this.idIssuer,
      this.idNumber,
      this.idPlaceOfIssue,
      this.idIssueDate,
      this.idExpiryDate,
      this.isSendEmail,
      this.isReceiveAlert,
      this.isRequestHardwareToken,
      this.isRequestInternetBanking,
      this.idCard,
      this.passport,
      this.utility,
      this.signature});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || referenceId != null) {
      map['reference_id'] = Variable<String>(referenceId);
    }
    if (!nullToAbsent || accountType != null) {
      map['account_type'] = Variable<String>(accountType);
    }
    if (!nullToAbsent || accountHolderType != null) {
      map['account_holder_type'] = Variable<String>(accountHolderType);
    }
    if (!nullToAbsent || riskRank != null) {
      map['risk_rank'] = Variable<String>(riskRank);
    }
    if (!nullToAbsent || accountCategory != null) {
      map['account_category'] = Variable<String>(accountCategory);
    }
    if (!nullToAbsent || bvn != null) {
      map['bvn'] = Variable<String>(bvn);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || surname != null) {
      map['surname'] = Variable<String>(surname);
    }
    if (!nullToAbsent || firstName != null) {
      map['first_name'] = Variable<String>(firstName);
    }
    if (!nullToAbsent || otherName != null) {
      map['other_name'] = Variable<String>(otherName);
    }
    if (!nullToAbsent || mothersMaidenName != null) {
      map['mothers_maiden_name'] = Variable<String>(mothersMaidenName);
    }
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<String>(dateOfBirth);
    }
    if (!nullToAbsent || stateOfOrigin != null) {
      map['state_of_origin'] = Variable<String>(stateOfOrigin);
    }
    if (!nullToAbsent || countryOfOrigin != null) {
      map['country_of_origin'] = Variable<String>(countryOfOrigin);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || nextOfKin != null) {
      map['next_of_kin'] = Variable<String>(nextOfKin);
    }
    if (!nullToAbsent || address1 != null) {
      map['address1'] = Variable<String>(address1);
    }
    if (!nullToAbsent || address2 != null) {
      map['address2'] = Variable<String>(address2);
    }
    if (!nullToAbsent || countryOfResidence != null) {
      map['country_of_residence'] = Variable<String>(countryOfResidence);
    }
    if (!nullToAbsent || stateOfResidence != null) {
      map['state_of_residence'] = Variable<String>(stateOfResidence);
    }
    if (!nullToAbsent || cityOfResidence != null) {
      map['city_of_residence'] = Variable<String>(cityOfResidence);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || occupation != null) {
      map['occupation'] = Variable<String>(occupation);
    }
    if (!nullToAbsent || maritalStatus != null) {
      map['marital_status'] = Variable<String>(maritalStatus);
    }
    if (!nullToAbsent || idType != null) {
      map['id_type'] = Variable<String>(idType);
    }
    if (!nullToAbsent || idIssuer != null) {
      map['id_issuer'] = Variable<String>(idIssuer);
    }
    if (!nullToAbsent || idNumber != null) {
      map['id_number'] = Variable<String>(idNumber);
    }
    if (!nullToAbsent || idPlaceOfIssue != null) {
      map['id_place_of_issue'] = Variable<String>(idPlaceOfIssue);
    }
    if (!nullToAbsent || idIssueDate != null) {
      map['id_issue_date'] = Variable<String>(idIssueDate);
    }
    if (!nullToAbsent || idExpiryDate != null) {
      map['id_expiry_date'] = Variable<String>(idExpiryDate);
    }
    if (!nullToAbsent || isSendEmail != null) {
      map['is_send_email'] = Variable<bool>(isSendEmail);
    }
    if (!nullToAbsent || isReceiveAlert != null) {
      map['is_receive_alert'] = Variable<bool>(isReceiveAlert);
    }
    if (!nullToAbsent || isRequestHardwareToken != null) {
      map['is_request_hardware_token'] = Variable<bool>(isRequestHardwareToken);
    }
    if (!nullToAbsent || isRequestInternetBanking != null) {
      map['is_request_internet_banking'] =
          Variable<bool>(isRequestInternetBanking);
    }
    if (!nullToAbsent || idCard != null) {
      map['id_card'] = Variable<String>(idCard);
    }
    if (!nullToAbsent || passport != null) {
      map['passport'] = Variable<String>(passport);
    }
    if (!nullToAbsent || utility != null) {
      map['utility'] = Variable<String>(utility);
    }
    if (!nullToAbsent || signature != null) {
      map['signature'] = Variable<String>(signature);
    }
    return map;
  }

  OfflineAccountEntityCompanion toCompanion(bool nullToAbsent) {
    return OfflineAccountEntityCompanion(
      id: Value(id),
      referenceId: referenceId == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceId),
      accountType: accountType == null && nullToAbsent
          ? const Value.absent()
          : Value(accountType),
      accountHolderType: accountHolderType == null && nullToAbsent
          ? const Value.absent()
          : Value(accountHolderType),
      riskRank: riskRank == null && nullToAbsent
          ? const Value.absent()
          : Value(riskRank),
      accountCategory: accountCategory == null && nullToAbsent
          ? const Value.absent()
          : Value(accountCategory),
      bvn: bvn == null && nullToAbsent ? const Value.absent() : Value(bvn),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      surname: surname == null && nullToAbsent
          ? const Value.absent()
          : Value(surname),
      firstName: firstName == null && nullToAbsent
          ? const Value.absent()
          : Value(firstName),
      otherName: otherName == null && nullToAbsent
          ? const Value.absent()
          : Value(otherName),
      mothersMaidenName: mothersMaidenName == null && nullToAbsent
          ? const Value.absent()
          : Value(mothersMaidenName),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
      stateOfOrigin: stateOfOrigin == null && nullToAbsent
          ? const Value.absent()
          : Value(stateOfOrigin),
      countryOfOrigin: countryOfOrigin == null && nullToAbsent
          ? const Value.absent()
          : Value(countryOfOrigin),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      nextOfKin: nextOfKin == null && nullToAbsent
          ? const Value.absent()
          : Value(nextOfKin),
      address1: address1 == null && nullToAbsent
          ? const Value.absent()
          : Value(address1),
      address2: address2 == null && nullToAbsent
          ? const Value.absent()
          : Value(address2),
      countryOfResidence: countryOfResidence == null && nullToAbsent
          ? const Value.absent()
          : Value(countryOfResidence),
      stateOfResidence: stateOfResidence == null && nullToAbsent
          ? const Value.absent()
          : Value(stateOfResidence),
      cityOfResidence: cityOfResidence == null && nullToAbsent
          ? const Value.absent()
          : Value(cityOfResidence),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      occupation: occupation == null && nullToAbsent
          ? const Value.absent()
          : Value(occupation),
      maritalStatus: maritalStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(maritalStatus),
      idType:
          idType == null && nullToAbsent ? const Value.absent() : Value(idType),
      idIssuer: idIssuer == null && nullToAbsent
          ? const Value.absent()
          : Value(idIssuer),
      idNumber: idNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(idNumber),
      idPlaceOfIssue: idPlaceOfIssue == null && nullToAbsent
          ? const Value.absent()
          : Value(idPlaceOfIssue),
      idIssueDate: idIssueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(idIssueDate),
      idExpiryDate: idExpiryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(idExpiryDate),
      isSendEmail: isSendEmail == null && nullToAbsent
          ? const Value.absent()
          : Value(isSendEmail),
      isReceiveAlert: isReceiveAlert == null && nullToAbsent
          ? const Value.absent()
          : Value(isReceiveAlert),
      isRequestHardwareToken: isRequestHardwareToken == null && nullToAbsent
          ? const Value.absent()
          : Value(isRequestHardwareToken),
      isRequestInternetBanking: isRequestInternetBanking == null && nullToAbsent
          ? const Value.absent()
          : Value(isRequestInternetBanking),
      idCard:
          idCard == null && nullToAbsent ? const Value.absent() : Value(idCard),
      passport: passport == null && nullToAbsent
          ? const Value.absent()
          : Value(passport),
      utility: utility == null && nullToAbsent
          ? const Value.absent()
          : Value(utility),
      signature: signature == null && nullToAbsent
          ? const Value.absent()
          : Value(signature),
    );
  }

  factory OfflineAccount.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OfflineAccount(
      id: serializer.fromJson<int>(json['id']),
      referenceId: serializer.fromJson<String?>(json['referenceId']),
      accountType: serializer.fromJson<String?>(json['accountType']),
      accountHolderType:
          serializer.fromJson<String?>(json['accountHolderType']),
      riskRank: serializer.fromJson<String?>(json['riskRank']),
      accountCategory: serializer.fromJson<String?>(json['accountCategory']),
      bvn: serializer.fromJson<String?>(json['bvn']),
      title: serializer.fromJson<String?>(json['title']),
      surname: serializer.fromJson<String?>(json['surname']),
      firstName: serializer.fromJson<String?>(json['firstName']),
      otherName: serializer.fromJson<String?>(json['otherName']),
      mothersMaidenName:
          serializer.fromJson<String?>(json['mothersMaidenName']),
      dateOfBirth: serializer.fromJson<String?>(json['dateOfBirth']),
      stateOfOrigin: serializer.fromJson<String?>(json['stateOfOrigin']),
      countryOfOrigin: serializer.fromJson<String?>(json['countryOfOrigin']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      nextOfKin: serializer.fromJson<String?>(json['nextOfKin']),
      address1: serializer.fromJson<String?>(json['address1']),
      address2: serializer.fromJson<String?>(json['address2']),
      countryOfResidence:
          serializer.fromJson<String?>(json['countryOfResidence']),
      stateOfResidence: serializer.fromJson<String?>(json['stateOfResidence']),
      cityOfResidence: serializer.fromJson<String?>(json['cityOfResidence']),
      gender: serializer.fromJson<String?>(json['gender']),
      occupation: serializer.fromJson<String?>(json['occupation']),
      maritalStatus: serializer.fromJson<String?>(json['maritalStatus']),
      idType: serializer.fromJson<String?>(json['idType']),
      idIssuer: serializer.fromJson<String?>(json['idIssuer']),
      idNumber: serializer.fromJson<String?>(json['idNumber']),
      idPlaceOfIssue: serializer.fromJson<String?>(json['idPlaceOfIssue']),
      idIssueDate: serializer.fromJson<String?>(json['idIssueDate']),
      idExpiryDate: serializer.fromJson<String?>(json['idExpiryDate']),
      isSendEmail: serializer.fromJson<bool?>(json['isSendEmail']),
      isReceiveAlert: serializer.fromJson<bool?>(json['isReceiveAlert']),
      isRequestHardwareToken:
          serializer.fromJson<bool?>(json['isRequestHardwareToken']),
      isRequestInternetBanking:
          serializer.fromJson<bool?>(json['isRequestInternetBanking']),
      idCard: serializer.fromJson<String?>(json['idCard']),
      passport: serializer.fromJson<String?>(json['passport']),
      utility: serializer.fromJson<String?>(json['utility']),
      signature: serializer.fromJson<String?>(json['signature']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'referenceId': serializer.toJson<String?>(referenceId),
      'accountType': serializer.toJson<String?>(accountType),
      'accountHolderType': serializer.toJson<String?>(accountHolderType),
      'riskRank': serializer.toJson<String?>(riskRank),
      'accountCategory': serializer.toJson<String?>(accountCategory),
      'bvn': serializer.toJson<String?>(bvn),
      'title': serializer.toJson<String?>(title),
      'surname': serializer.toJson<String?>(surname),
      'firstName': serializer.toJson<String?>(firstName),
      'otherName': serializer.toJson<String?>(otherName),
      'mothersMaidenName': serializer.toJson<String?>(mothersMaidenName),
      'dateOfBirth': serializer.toJson<String?>(dateOfBirth),
      'stateOfOrigin': serializer.toJson<String?>(stateOfOrigin),
      'countryOfOrigin': serializer.toJson<String?>(countryOfOrigin),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'nextOfKin': serializer.toJson<String?>(nextOfKin),
      'address1': serializer.toJson<String?>(address1),
      'address2': serializer.toJson<String?>(address2),
      'countryOfResidence': serializer.toJson<String?>(countryOfResidence),
      'stateOfResidence': serializer.toJson<String?>(stateOfResidence),
      'cityOfResidence': serializer.toJson<String?>(cityOfResidence),
      'gender': serializer.toJson<String?>(gender),
      'occupation': serializer.toJson<String?>(occupation),
      'maritalStatus': serializer.toJson<String?>(maritalStatus),
      'idType': serializer.toJson<String?>(idType),
      'idIssuer': serializer.toJson<String?>(idIssuer),
      'idNumber': serializer.toJson<String?>(idNumber),
      'idPlaceOfIssue': serializer.toJson<String?>(idPlaceOfIssue),
      'idIssueDate': serializer.toJson<String?>(idIssueDate),
      'idExpiryDate': serializer.toJson<String?>(idExpiryDate),
      'isSendEmail': serializer.toJson<bool?>(isSendEmail),
      'isReceiveAlert': serializer.toJson<bool?>(isReceiveAlert),
      'isRequestHardwareToken':
          serializer.toJson<bool?>(isRequestHardwareToken),
      'isRequestInternetBanking':
          serializer.toJson<bool?>(isRequestInternetBanking),
      'idCard': serializer.toJson<String?>(idCard),
      'passport': serializer.toJson<String?>(passport),
      'utility': serializer.toJson<String?>(utility),
      'signature': serializer.toJson<String?>(signature),
    };
  }

  OfflineAccount copyWith(
          {int? id,
          Value<String?> referenceId = const Value.absent(),
          Value<String?> accountType = const Value.absent(),
          Value<String?> accountHolderType = const Value.absent(),
          Value<String?> riskRank = const Value.absent(),
          Value<String?> accountCategory = const Value.absent(),
          Value<String?> bvn = const Value.absent(),
          Value<String?> title = const Value.absent(),
          Value<String?> surname = const Value.absent(),
          Value<String?> firstName = const Value.absent(),
          Value<String?> otherName = const Value.absent(),
          Value<String?> mothersMaidenName = const Value.absent(),
          Value<String?> dateOfBirth = const Value.absent(),
          Value<String?> stateOfOrigin = const Value.absent(),
          Value<String?> countryOfOrigin = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> nextOfKin = const Value.absent(),
          Value<String?> address1 = const Value.absent(),
          Value<String?> address2 = const Value.absent(),
          Value<String?> countryOfResidence = const Value.absent(),
          Value<String?> stateOfResidence = const Value.absent(),
          Value<String?> cityOfResidence = const Value.absent(),
          Value<String?> gender = const Value.absent(),
          Value<String?> occupation = const Value.absent(),
          Value<String?> maritalStatus = const Value.absent(),
          Value<String?> idType = const Value.absent(),
          Value<String?> idIssuer = const Value.absent(),
          Value<String?> idNumber = const Value.absent(),
          Value<String?> idPlaceOfIssue = const Value.absent(),
          Value<String?> idIssueDate = const Value.absent(),
          Value<String?> idExpiryDate = const Value.absent(),
          Value<bool?> isSendEmail = const Value.absent(),
          Value<bool?> isReceiveAlert = const Value.absent(),
          Value<bool?> isRequestHardwareToken = const Value.absent(),
          Value<bool?> isRequestInternetBanking = const Value.absent(),
          Value<String?> idCard = const Value.absent(),
          Value<String?> passport = const Value.absent(),
          Value<String?> utility = const Value.absent(),
          Value<String?> signature = const Value.absent()}) =>
      OfflineAccount(
        id: id ?? this.id,
        referenceId: referenceId.present ? referenceId.value : this.referenceId,
        accountType: accountType.present ? accountType.value : this.accountType,
        accountHolderType: accountHolderType.present
            ? accountHolderType.value
            : this.accountHolderType,
        riskRank: riskRank.present ? riskRank.value : this.riskRank,
        accountCategory: accountCategory.present
            ? accountCategory.value
            : this.accountCategory,
        bvn: bvn.present ? bvn.value : this.bvn,
        title: title.present ? title.value : this.title,
        surname: surname.present ? surname.value : this.surname,
        firstName: firstName.present ? firstName.value : this.firstName,
        otherName: otherName.present ? otherName.value : this.otherName,
        mothersMaidenName: mothersMaidenName.present
            ? mothersMaidenName.value
            : this.mothersMaidenName,
        dateOfBirth: dateOfBirth.present ? dateOfBirth.value : this.dateOfBirth,
        stateOfOrigin:
            stateOfOrigin.present ? stateOfOrigin.value : this.stateOfOrigin,
        countryOfOrigin: countryOfOrigin.present
            ? countryOfOrigin.value
            : this.countryOfOrigin,
        email: email.present ? email.value : this.email,
        phone: phone.present ? phone.value : this.phone,
        nextOfKin: nextOfKin.present ? nextOfKin.value : this.nextOfKin,
        address1: address1.present ? address1.value : this.address1,
        address2: address2.present ? address2.value : this.address2,
        countryOfResidence: countryOfResidence.present
            ? countryOfResidence.value
            : this.countryOfResidence,
        stateOfResidence: stateOfResidence.present
            ? stateOfResidence.value
            : this.stateOfResidence,
        cityOfResidence: cityOfResidence.present
            ? cityOfResidence.value
            : this.cityOfResidence,
        gender: gender.present ? gender.value : this.gender,
        occupation: occupation.present ? occupation.value : this.occupation,
        maritalStatus:
            maritalStatus.present ? maritalStatus.value : this.maritalStatus,
        idType: idType.present ? idType.value : this.idType,
        idIssuer: idIssuer.present ? idIssuer.value : this.idIssuer,
        idNumber: idNumber.present ? idNumber.value : this.idNumber,
        idPlaceOfIssue:
            idPlaceOfIssue.present ? idPlaceOfIssue.value : this.idPlaceOfIssue,
        idIssueDate: idIssueDate.present ? idIssueDate.value : this.idIssueDate,
        idExpiryDate:
            idExpiryDate.present ? idExpiryDate.value : this.idExpiryDate,
        isSendEmail: isSendEmail.present ? isSendEmail.value : this.isSendEmail,
        isReceiveAlert:
            isReceiveAlert.present ? isReceiveAlert.value : this.isReceiveAlert,
        isRequestHardwareToken: isRequestHardwareToken.present
            ? isRequestHardwareToken.value
            : this.isRequestHardwareToken,
        isRequestInternetBanking: isRequestInternetBanking.present
            ? isRequestInternetBanking.value
            : this.isRequestInternetBanking,
        idCard: idCard.present ? idCard.value : this.idCard,
        passport: passport.present ? passport.value : this.passport,
        utility: utility.present ? utility.value : this.utility,
        signature: signature.present ? signature.value : this.signature,
      );
  @override
  String toString() {
    return (StringBuffer('OfflineAccount(')
          ..write('id: $id, ')
          ..write('referenceId: $referenceId, ')
          ..write('accountType: $accountType, ')
          ..write('accountHolderType: $accountHolderType, ')
          ..write('riskRank: $riskRank, ')
          ..write('accountCategory: $accountCategory, ')
          ..write('bvn: $bvn, ')
          ..write('title: $title, ')
          ..write('surname: $surname, ')
          ..write('firstName: $firstName, ')
          ..write('otherName: $otherName, ')
          ..write('mothersMaidenName: $mothersMaidenName, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('stateOfOrigin: $stateOfOrigin, ')
          ..write('countryOfOrigin: $countryOfOrigin, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('nextOfKin: $nextOfKin, ')
          ..write('address1: $address1, ')
          ..write('address2: $address2, ')
          ..write('countryOfResidence: $countryOfResidence, ')
          ..write('stateOfResidence: $stateOfResidence, ')
          ..write('cityOfResidence: $cityOfResidence, ')
          ..write('gender: $gender, ')
          ..write('occupation: $occupation, ')
          ..write('maritalStatus: $maritalStatus, ')
          ..write('idType: $idType, ')
          ..write('idIssuer: $idIssuer, ')
          ..write('idNumber: $idNumber, ')
          ..write('idPlaceOfIssue: $idPlaceOfIssue, ')
          ..write('idIssueDate: $idIssueDate, ')
          ..write('idExpiryDate: $idExpiryDate, ')
          ..write('isSendEmail: $isSendEmail, ')
          ..write('isReceiveAlert: $isReceiveAlert, ')
          ..write('isRequestHardwareToken: $isRequestHardwareToken, ')
          ..write('isRequestInternetBanking: $isRequestInternetBanking, ')
          ..write('idCard: $idCard, ')
          ..write('passport: $passport, ')
          ..write('utility: $utility, ')
          ..write('signature: $signature')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        referenceId,
        accountType,
        accountHolderType,
        riskRank,
        accountCategory,
        bvn,
        title,
        surname,
        firstName,
        otherName,
        mothersMaidenName,
        dateOfBirth,
        stateOfOrigin,
        countryOfOrigin,
        email,
        phone,
        nextOfKin,
        address1,
        address2,
        countryOfResidence,
        stateOfResidence,
        cityOfResidence,
        gender,
        occupation,
        maritalStatus,
        idType,
        idIssuer,
        idNumber,
        idPlaceOfIssue,
        idIssueDate,
        idExpiryDate,
        isSendEmail,
        isReceiveAlert,
        isRequestHardwareToken,
        isRequestInternetBanking,
        idCard,
        passport,
        utility,
        signature
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OfflineAccount &&
          other.id == this.id &&
          other.referenceId == this.referenceId &&
          other.accountType == this.accountType &&
          other.accountHolderType == this.accountHolderType &&
          other.riskRank == this.riskRank &&
          other.accountCategory == this.accountCategory &&
          other.bvn == this.bvn &&
          other.title == this.title &&
          other.surname == this.surname &&
          other.firstName == this.firstName &&
          other.otherName == this.otherName &&
          other.mothersMaidenName == this.mothersMaidenName &&
          other.dateOfBirth == this.dateOfBirth &&
          other.stateOfOrigin == this.stateOfOrigin &&
          other.countryOfOrigin == this.countryOfOrigin &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.nextOfKin == this.nextOfKin &&
          other.address1 == this.address1 &&
          other.address2 == this.address2 &&
          other.countryOfResidence == this.countryOfResidence &&
          other.stateOfResidence == this.stateOfResidence &&
          other.cityOfResidence == this.cityOfResidence &&
          other.gender == this.gender &&
          other.occupation == this.occupation &&
          other.maritalStatus == this.maritalStatus &&
          other.idType == this.idType &&
          other.idIssuer == this.idIssuer &&
          other.idNumber == this.idNumber &&
          other.idPlaceOfIssue == this.idPlaceOfIssue &&
          other.idIssueDate == this.idIssueDate &&
          other.idExpiryDate == this.idExpiryDate &&
          other.isSendEmail == this.isSendEmail &&
          other.isReceiveAlert == this.isReceiveAlert &&
          other.isRequestHardwareToken == this.isRequestHardwareToken &&
          other.isRequestInternetBanking == this.isRequestInternetBanking &&
          other.idCard == this.idCard &&
          other.passport == this.passport &&
          other.utility == this.utility &&
          other.signature == this.signature);
}

class OfflineAccountEntityCompanion extends UpdateCompanion<OfflineAccount> {
  final Value<int> id;
  final Value<String?> referenceId;
  final Value<String?> accountType;
  final Value<String?> accountHolderType;
  final Value<String?> riskRank;
  final Value<String?> accountCategory;
  final Value<String?> bvn;
  final Value<String?> title;
  final Value<String?> surname;
  final Value<String?> firstName;
  final Value<String?> otherName;
  final Value<String?> mothersMaidenName;
  final Value<String?> dateOfBirth;
  final Value<String?> stateOfOrigin;
  final Value<String?> countryOfOrigin;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> nextOfKin;
  final Value<String?> address1;
  final Value<String?> address2;
  final Value<String?> countryOfResidence;
  final Value<String?> stateOfResidence;
  final Value<String?> cityOfResidence;
  final Value<String?> gender;
  final Value<String?> occupation;
  final Value<String?> maritalStatus;
  final Value<String?> idType;
  final Value<String?> idIssuer;
  final Value<String?> idNumber;
  final Value<String?> idPlaceOfIssue;
  final Value<String?> idIssueDate;
  final Value<String?> idExpiryDate;
  final Value<bool?> isSendEmail;
  final Value<bool?> isReceiveAlert;
  final Value<bool?> isRequestHardwareToken;
  final Value<bool?> isRequestInternetBanking;
  final Value<String?> idCard;
  final Value<String?> passport;
  final Value<String?> utility;
  final Value<String?> signature;
  const OfflineAccountEntityCompanion({
    this.id = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.accountType = const Value.absent(),
    this.accountHolderType = const Value.absent(),
    this.riskRank = const Value.absent(),
    this.accountCategory = const Value.absent(),
    this.bvn = const Value.absent(),
    this.title = const Value.absent(),
    this.surname = const Value.absent(),
    this.firstName = const Value.absent(),
    this.otherName = const Value.absent(),
    this.mothersMaidenName = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.stateOfOrigin = const Value.absent(),
    this.countryOfOrigin = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.nextOfKin = const Value.absent(),
    this.address1 = const Value.absent(),
    this.address2 = const Value.absent(),
    this.countryOfResidence = const Value.absent(),
    this.stateOfResidence = const Value.absent(),
    this.cityOfResidence = const Value.absent(),
    this.gender = const Value.absent(),
    this.occupation = const Value.absent(),
    this.maritalStatus = const Value.absent(),
    this.idType = const Value.absent(),
    this.idIssuer = const Value.absent(),
    this.idNumber = const Value.absent(),
    this.idPlaceOfIssue = const Value.absent(),
    this.idIssueDate = const Value.absent(),
    this.idExpiryDate = const Value.absent(),
    this.isSendEmail = const Value.absent(),
    this.isReceiveAlert = const Value.absent(),
    this.isRequestHardwareToken = const Value.absent(),
    this.isRequestInternetBanking = const Value.absent(),
    this.idCard = const Value.absent(),
    this.passport = const Value.absent(),
    this.utility = const Value.absent(),
    this.signature = const Value.absent(),
  });
  OfflineAccountEntityCompanion.insert({
    this.id = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.accountType = const Value.absent(),
    this.accountHolderType = const Value.absent(),
    this.riskRank = const Value.absent(),
    this.accountCategory = const Value.absent(),
    this.bvn = const Value.absent(),
    this.title = const Value.absent(),
    this.surname = const Value.absent(),
    this.firstName = const Value.absent(),
    this.otherName = const Value.absent(),
    this.mothersMaidenName = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.stateOfOrigin = const Value.absent(),
    this.countryOfOrigin = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.nextOfKin = const Value.absent(),
    this.address1 = const Value.absent(),
    this.address2 = const Value.absent(),
    this.countryOfResidence = const Value.absent(),
    this.stateOfResidence = const Value.absent(),
    this.cityOfResidence = const Value.absent(),
    this.gender = const Value.absent(),
    this.occupation = const Value.absent(),
    this.maritalStatus = const Value.absent(),
    this.idType = const Value.absent(),
    this.idIssuer = const Value.absent(),
    this.idNumber = const Value.absent(),
    this.idPlaceOfIssue = const Value.absent(),
    this.idIssueDate = const Value.absent(),
    this.idExpiryDate = const Value.absent(),
    this.isSendEmail = const Value.absent(),
    this.isReceiveAlert = const Value.absent(),
    this.isRequestHardwareToken = const Value.absent(),
    this.isRequestInternetBanking = const Value.absent(),
    this.idCard = const Value.absent(),
    this.passport = const Value.absent(),
    this.utility = const Value.absent(),
    this.signature = const Value.absent(),
  });
  static Insertable<OfflineAccount> custom({
    Expression<int>? id,
    Expression<String>? referenceId,
    Expression<String>? accountType,
    Expression<String>? accountHolderType,
    Expression<String>? riskRank,
    Expression<String>? accountCategory,
    Expression<String>? bvn,
    Expression<String>? title,
    Expression<String>? surname,
    Expression<String>? firstName,
    Expression<String>? otherName,
    Expression<String>? mothersMaidenName,
    Expression<String>? dateOfBirth,
    Expression<String>? stateOfOrigin,
    Expression<String>? countryOfOrigin,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? nextOfKin,
    Expression<String>? address1,
    Expression<String>? address2,
    Expression<String>? countryOfResidence,
    Expression<String>? stateOfResidence,
    Expression<String>? cityOfResidence,
    Expression<String>? gender,
    Expression<String>? occupation,
    Expression<String>? maritalStatus,
    Expression<String>? idType,
    Expression<String>? idIssuer,
    Expression<String>? idNumber,
    Expression<String>? idPlaceOfIssue,
    Expression<String>? idIssueDate,
    Expression<String>? idExpiryDate,
    Expression<bool>? isSendEmail,
    Expression<bool>? isReceiveAlert,
    Expression<bool>? isRequestHardwareToken,
    Expression<bool>? isRequestInternetBanking,
    Expression<String>? idCard,
    Expression<String>? passport,
    Expression<String>? utility,
    Expression<String>? signature,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (referenceId != null) 'reference_id': referenceId,
      if (accountType != null) 'account_type': accountType,
      if (accountHolderType != null) 'account_holder_type': accountHolderType,
      if (riskRank != null) 'risk_rank': riskRank,
      if (accountCategory != null) 'account_category': accountCategory,
      if (bvn != null) 'bvn': bvn,
      if (title != null) 'title': title,
      if (surname != null) 'surname': surname,
      if (firstName != null) 'first_name': firstName,
      if (otherName != null) 'other_name': otherName,
      if (mothersMaidenName != null) 'mothers_maiden_name': mothersMaidenName,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (stateOfOrigin != null) 'state_of_origin': stateOfOrigin,
      if (countryOfOrigin != null) 'country_of_origin': countryOfOrigin,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (nextOfKin != null) 'next_of_kin': nextOfKin,
      if (address1 != null) 'address1': address1,
      if (address2 != null) 'address2': address2,
      if (countryOfResidence != null)
        'country_of_residence': countryOfResidence,
      if (stateOfResidence != null) 'state_of_residence': stateOfResidence,
      if (cityOfResidence != null) 'city_of_residence': cityOfResidence,
      if (gender != null) 'gender': gender,
      if (occupation != null) 'occupation': occupation,
      if (maritalStatus != null) 'marital_status': maritalStatus,
      if (idType != null) 'id_type': idType,
      if (idIssuer != null) 'id_issuer': idIssuer,
      if (idNumber != null) 'id_number': idNumber,
      if (idPlaceOfIssue != null) 'id_place_of_issue': idPlaceOfIssue,
      if (idIssueDate != null) 'id_issue_date': idIssueDate,
      if (idExpiryDate != null) 'id_expiry_date': idExpiryDate,
      if (isSendEmail != null) 'is_send_email': isSendEmail,
      if (isReceiveAlert != null) 'is_receive_alert': isReceiveAlert,
      if (isRequestHardwareToken != null)
        'is_request_hardware_token': isRequestHardwareToken,
      if (isRequestInternetBanking != null)
        'is_request_internet_banking': isRequestInternetBanking,
      if (idCard != null) 'id_card': idCard,
      if (passport != null) 'passport': passport,
      if (utility != null) 'utility': utility,
      if (signature != null) 'signature': signature,
    });
  }

  OfflineAccountEntityCompanion copyWith(
      {Value<int>? id,
      Value<String?>? referenceId,
      Value<String?>? accountType,
      Value<String?>? accountHolderType,
      Value<String?>? riskRank,
      Value<String?>? accountCategory,
      Value<String?>? bvn,
      Value<String?>? title,
      Value<String?>? surname,
      Value<String?>? firstName,
      Value<String?>? otherName,
      Value<String?>? mothersMaidenName,
      Value<String?>? dateOfBirth,
      Value<String?>? stateOfOrigin,
      Value<String?>? countryOfOrigin,
      Value<String?>? email,
      Value<String?>? phone,
      Value<String?>? nextOfKin,
      Value<String?>? address1,
      Value<String?>? address2,
      Value<String?>? countryOfResidence,
      Value<String?>? stateOfResidence,
      Value<String?>? cityOfResidence,
      Value<String?>? gender,
      Value<String?>? occupation,
      Value<String?>? maritalStatus,
      Value<String?>? idType,
      Value<String?>? idIssuer,
      Value<String?>? idNumber,
      Value<String?>? idPlaceOfIssue,
      Value<String?>? idIssueDate,
      Value<String?>? idExpiryDate,
      Value<bool?>? isSendEmail,
      Value<bool?>? isReceiveAlert,
      Value<bool?>? isRequestHardwareToken,
      Value<bool?>? isRequestInternetBanking,
      Value<String?>? idCard,
      Value<String?>? passport,
      Value<String?>? utility,
      Value<String?>? signature}) {
    return OfflineAccountEntityCompanion(
      id: id ?? this.id,
      referenceId: referenceId ?? this.referenceId,
      accountType: accountType ?? this.accountType,
      accountHolderType: accountHolderType ?? this.accountHolderType,
      riskRank: riskRank ?? this.riskRank,
      accountCategory: accountCategory ?? this.accountCategory,
      bvn: bvn ?? this.bvn,
      title: title ?? this.title,
      surname: surname ?? this.surname,
      firstName: firstName ?? this.firstName,
      otherName: otherName ?? this.otherName,
      mothersMaidenName: mothersMaidenName ?? this.mothersMaidenName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      stateOfOrigin: stateOfOrigin ?? this.stateOfOrigin,
      countryOfOrigin: countryOfOrigin ?? this.countryOfOrigin,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      nextOfKin: nextOfKin ?? this.nextOfKin,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      countryOfResidence: countryOfResidence ?? this.countryOfResidence,
      stateOfResidence: stateOfResidence ?? this.stateOfResidence,
      cityOfResidence: cityOfResidence ?? this.cityOfResidence,
      gender: gender ?? this.gender,
      occupation: occupation ?? this.occupation,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      idType: idType ?? this.idType,
      idIssuer: idIssuer ?? this.idIssuer,
      idNumber: idNumber ?? this.idNumber,
      idPlaceOfIssue: idPlaceOfIssue ?? this.idPlaceOfIssue,
      idIssueDate: idIssueDate ?? this.idIssueDate,
      idExpiryDate: idExpiryDate ?? this.idExpiryDate,
      isSendEmail: isSendEmail ?? this.isSendEmail,
      isReceiveAlert: isReceiveAlert ?? this.isReceiveAlert,
      isRequestHardwareToken:
          isRequestHardwareToken ?? this.isRequestHardwareToken,
      isRequestInternetBanking:
          isRequestInternetBanking ?? this.isRequestInternetBanking,
      idCard: idCard ?? this.idCard,
      passport: passport ?? this.passport,
      utility: utility ?? this.utility,
      signature: signature ?? this.signature,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (referenceId.present) {
      map['reference_id'] = Variable<String>(referenceId.value);
    }
    if (accountType.present) {
      map['account_type'] = Variable<String>(accountType.value);
    }
    if (accountHolderType.present) {
      map['account_holder_type'] = Variable<String>(accountHolderType.value);
    }
    if (riskRank.present) {
      map['risk_rank'] = Variable<String>(riskRank.value);
    }
    if (accountCategory.present) {
      map['account_category'] = Variable<String>(accountCategory.value);
    }
    if (bvn.present) {
      map['bvn'] = Variable<String>(bvn.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (surname.present) {
      map['surname'] = Variable<String>(surname.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (otherName.present) {
      map['other_name'] = Variable<String>(otherName.value);
    }
    if (mothersMaidenName.present) {
      map['mothers_maiden_name'] = Variable<String>(mothersMaidenName.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<String>(dateOfBirth.value);
    }
    if (stateOfOrigin.present) {
      map['state_of_origin'] = Variable<String>(stateOfOrigin.value);
    }
    if (countryOfOrigin.present) {
      map['country_of_origin'] = Variable<String>(countryOfOrigin.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (nextOfKin.present) {
      map['next_of_kin'] = Variable<String>(nextOfKin.value);
    }
    if (address1.present) {
      map['address1'] = Variable<String>(address1.value);
    }
    if (address2.present) {
      map['address2'] = Variable<String>(address2.value);
    }
    if (countryOfResidence.present) {
      map['country_of_residence'] = Variable<String>(countryOfResidence.value);
    }
    if (stateOfResidence.present) {
      map['state_of_residence'] = Variable<String>(stateOfResidence.value);
    }
    if (cityOfResidence.present) {
      map['city_of_residence'] = Variable<String>(cityOfResidence.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (occupation.present) {
      map['occupation'] = Variable<String>(occupation.value);
    }
    if (maritalStatus.present) {
      map['marital_status'] = Variable<String>(maritalStatus.value);
    }
    if (idType.present) {
      map['id_type'] = Variable<String>(idType.value);
    }
    if (idIssuer.present) {
      map['id_issuer'] = Variable<String>(idIssuer.value);
    }
    if (idNumber.present) {
      map['id_number'] = Variable<String>(idNumber.value);
    }
    if (idPlaceOfIssue.present) {
      map['id_place_of_issue'] = Variable<String>(idPlaceOfIssue.value);
    }
    if (idIssueDate.present) {
      map['id_issue_date'] = Variable<String>(idIssueDate.value);
    }
    if (idExpiryDate.present) {
      map['id_expiry_date'] = Variable<String>(idExpiryDate.value);
    }
    if (isSendEmail.present) {
      map['is_send_email'] = Variable<bool>(isSendEmail.value);
    }
    if (isReceiveAlert.present) {
      map['is_receive_alert'] = Variable<bool>(isReceiveAlert.value);
    }
    if (isRequestHardwareToken.present) {
      map['is_request_hardware_token'] =
          Variable<bool>(isRequestHardwareToken.value);
    }
    if (isRequestInternetBanking.present) {
      map['is_request_internet_banking'] =
          Variable<bool>(isRequestInternetBanking.value);
    }
    if (idCard.present) {
      map['id_card'] = Variable<String>(idCard.value);
    }
    if (passport.present) {
      map['passport'] = Variable<String>(passport.value);
    }
    if (utility.present) {
      map['utility'] = Variable<String>(utility.value);
    }
    if (signature.present) {
      map['signature'] = Variable<String>(signature.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OfflineAccountEntityCompanion(')
          ..write('id: $id, ')
          ..write('referenceId: $referenceId, ')
          ..write('accountType: $accountType, ')
          ..write('accountHolderType: $accountHolderType, ')
          ..write('riskRank: $riskRank, ')
          ..write('accountCategory: $accountCategory, ')
          ..write('bvn: $bvn, ')
          ..write('title: $title, ')
          ..write('surname: $surname, ')
          ..write('firstName: $firstName, ')
          ..write('otherName: $otherName, ')
          ..write('mothersMaidenName: $mothersMaidenName, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('stateOfOrigin: $stateOfOrigin, ')
          ..write('countryOfOrigin: $countryOfOrigin, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('nextOfKin: $nextOfKin, ')
          ..write('address1: $address1, ')
          ..write('address2: $address2, ')
          ..write('countryOfResidence: $countryOfResidence, ')
          ..write('stateOfResidence: $stateOfResidence, ')
          ..write('cityOfResidence: $cityOfResidence, ')
          ..write('gender: $gender, ')
          ..write('occupation: $occupation, ')
          ..write('maritalStatus: $maritalStatus, ')
          ..write('idType: $idType, ')
          ..write('idIssuer: $idIssuer, ')
          ..write('idNumber: $idNumber, ')
          ..write('idPlaceOfIssue: $idPlaceOfIssue, ')
          ..write('idIssueDate: $idIssueDate, ')
          ..write('idExpiryDate: $idExpiryDate, ')
          ..write('isSendEmail: $isSendEmail, ')
          ..write('isReceiveAlert: $isReceiveAlert, ')
          ..write('isRequestHardwareToken: $isRequestHardwareToken, ')
          ..write('isRequestInternetBanking: $isRequestInternetBanking, ')
          ..write('idCard: $idCard, ')
          ..write('passport: $passport, ')
          ..write('utility: $utility, ')
          ..write('signature: $signature')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $AccountClassEntityTable accountClassEntity =
      $AccountClassEntityTable(this);
  late final $CityEntityTable cityEntity = $CityEntityTable(this);
  late final $CountryEntityTable countryEntity = $CountryEntityTable(this);
  late final $OccupationEntityTable occupationEntity =
      $OccupationEntityTable(this);
  late final $StateEntityTable stateEntity = $StateEntityTable(this);
  late final $OfflineAccountEntityTable offlineAccountEntity =
      $OfflineAccountEntityTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        accountClassEntity,
        cityEntity,
        countryEntity,
        occupationEntity,
        stateEntity,
        offlineAccountEntity
      ];
}

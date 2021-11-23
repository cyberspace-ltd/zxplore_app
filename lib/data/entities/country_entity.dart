import 'package:equatable/equatable.dart';

final String tableCountry = 'Country';
final String columnCountryId = 'id';
final String columnCountryName = 'name';

class CountryEntity extends Equatable {
  //database fields
  final String? name;

  CountryEntity({this.name});

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();
    map[columnCountryName] = name;
    return map;
  }

  factory CountryEntity.fromMap(Map<String, dynamic> json) => new CountryEntity(
        name: json[columnCountryName],
      );

  @override
  List<Object?> get props => [name];
}

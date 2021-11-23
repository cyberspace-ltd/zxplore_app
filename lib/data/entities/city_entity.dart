import 'package:equatable/equatable.dart';

final String tableCity = 'City';
final String columnCityId = 'id';
final String columnCityName = 'name';

class CityEntity extends Equatable {
  //database fields
  final String? name;

  CityEntity({this.name});

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();
    map[columnCityName] = name;
    return map;
  }

  factory CityEntity.fromMap(Map<String, dynamic> json) => new CityEntity(
        name: json[columnCityName],
      );

  @override
  List<Object?> get props => [name];
}

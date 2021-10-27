import 'package:equatable/equatable.dart';

final String tableOccupation = 'Occupation';
final String columnOccupationId = 'id';
final String columnOccupationName = 'name';
final String columnSironCode = 'sironCode';
final String columnGroupName = 'groupName';

// ignore: must_be_immutable
class OccupationEntity extends Equatable {
  //database fields
  int? srn;
  String? occupationName;
  String? sironCode;
  String? groupName;

  OccupationEntity({
    this.srn,
    this.occupationName,
    this.sironCode,
    this.groupName,
  });

  @override
  bool operator ==(Object other) {
    return other is OccupationEntity && hashCode == other.hashCode;
  }

  @override
  int get hashCode => sironCode.hashCode;

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();
    map[columnOccupationId] = srn;
    map[columnOccupationName] = occupationName;
    map[columnSironCode] = sironCode;
    map[columnGroupName] = groupName;

    return map;
  }

  factory OccupationEntity.fromMap(Map<String, dynamic> json) =>
      new OccupationEntity(
        srn: json[columnOccupationId],
        occupationName: json[columnOccupationName],
        sironCode: json[columnSironCode],
        groupName: json[columnGroupName],
      );

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

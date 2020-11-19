import 'package:equatable/equatable.dart';

final String tableState = 'State';
final String columnStateId = 'id';
final String columnSateMMDA = 'mmda';
final String columnStateName = 'name';

class StateEntity extends Equatable{
  //database fields
  String stateName;
  String mmda;
  int srn;
  StateEntity({
    this.srn, this.stateName, this.mmda
  });


  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();
    map[columnStateName] = stateName;
    map[columnSateMMDA] = mmda;
    map[columnStateId] = srn;
    return map;
  }


  factory StateEntity.fromMap(Map<String, dynamic> json) => new StateEntity(
    stateName: json[columnStateName],
    mmda: json[columnSateMMDA],
    srn: json[columnStateId]
  );


}

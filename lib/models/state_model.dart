import 'dart:convert';

State stateFromJson(String str) => State.fromJson(json.decode(str));

String stateToJson(State data) => json.encode(data.toJson());


class State {
  State({
    this.responseCode,
    this.responseMessage,
    this.menu,
  });

  String responseCode;
  String responseMessage;
  List<Menu> menu;

  factory State.fromJson(Map<String, dynamic> json) => State(
    responseCode: json["ResponseCode"],
    responseMessage: json["ResponseMessage"],
    menu: List<Menu>.from(json["Menu"].map((x) => Menu.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ResponseCode": responseCode,
    "ResponseMessage": responseMessage,
    "Menu": List<dynamic>.from(menu.map((x) => x.toJson())),
  };
}

class Menu {
  Menu({
    this.srn,
    this.stateName,
    this.mmda,
  });

  int srn;
  String stateName;
  String mmda;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    srn: json["Srn"],
    stateName: json["StateName"],
    mmda: json["MMDA"],
  );

  Map<String, dynamic> toJson() => {
    "Srn": srn,
    "StateName": stateName,
    "MMDA": mmda,
  };
}

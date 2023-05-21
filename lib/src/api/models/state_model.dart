import 'dart:convert';

State stateFromJson(String str) => State.fromJson(json.decode(str));

String stateToJson(State data) => json.encode(data.toJson());

class State {
  String? responseCode;
  String? responseMessage;
  List<String>? menu;

  State({this.responseCode, this.responseMessage, this.menu});

  factory State.fromJson(Map<String, dynamic> json) => State(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        menu: List<String>.from(json["Menu"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "ResponseMessage": responseMessage,
        "Menu": List<dynamic>.from(menu!.map((x) => x)),
      };
}

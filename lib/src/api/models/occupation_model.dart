import 'dart:convert';

Occupation occupationFromJson(String str) =>
    Occupation.fromJson(json.decode(str));

String occupationToJson(Occupation data) => json.encode(data.toJson());

class Occupation {
  String? responseCode;
  String? responseMessage;
  List<String>? menu;

  Occupation({this.responseCode, this.responseMessage, this.menu});

  factory Occupation.fromJson(Map<String, dynamic> json) => Occupation(
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

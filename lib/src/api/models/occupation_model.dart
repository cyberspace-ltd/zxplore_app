import 'dart:convert';

OccupationModel occupationModelFromJson(String str) =>
    OccupationModel.fromJson(json.decode(str));

String occupationModelToJson(OccupationModel data) =>
    json.encode(data.toJson());

class OccupationModel {
  String? responseCode;
  String? responseMessage;
  List<String>? menu;

  OccupationModel({this.responseCode, this.responseMessage, this.menu});

  factory OccupationModel.fromJson(Map<String, dynamic> json) =>
      OccupationModel(
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

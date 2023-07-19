import 'dart:convert';

TitleModel titleModelFromJson(String str) =>
    TitleModel.fromJson(json.decode(str));

String titleModelToJson(TitleModel data) => json.encode(data.toJson());

class TitleModel {
  String? responseCode;
  String? responseMessage;
  List<String>? menu;

  TitleModel({this.responseCode, this.responseMessage, this.menu});

  factory TitleModel.fromJson(Map<String, dynamic> json) => TitleModel(
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

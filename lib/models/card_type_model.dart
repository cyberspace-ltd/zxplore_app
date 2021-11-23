import 'dart:convert';

CardTypes cardTypeFromJson(String str) => CardTypes.fromJson(json.decode(str));

String cardTypeToJson(CardTypes data) => json.encode(data.toJson());

class CardTypes {
  String? responseCode;
  String? responseMessage;
  List<String>? menu;

  CardTypes({this.responseCode, this.responseMessage, this.menu});

  factory CardTypes.fromJson(Map<String, dynamic> json) => new CardTypes(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        menu: new List<String>.from(json["Menu"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "ResponseMessage": responseMessage,
        "Menu": new List<dynamic>.from(menu!.map((x) => x)),
      };
}

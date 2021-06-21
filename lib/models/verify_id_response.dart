// To parse this JSON data, do
//
//     final verifyIdResponse = verifyIdResponseFromJson(jsonString);

import 'dart:convert';

VerifyIdResponse verifyIdResponseFromJson(String str) => VerifyIdResponse.fromJson(json.decode(str));

String verifyIdResponseToJson(VerifyIdResponse data) => json.encode(data.toJson());

class VerifyIdResponse {
    VerifyIdResponse({
        this.responseCode,
        this.message,
        this.id,
        this.fullName,
        this.photo,
    });

    String responseCode;
    String message;
    String id;
    String fullName;
    String photo;

    factory VerifyIdResponse.fromJson(Map<String, dynamic> json) => VerifyIdResponse(
        responseCode: json["ResponseCode"] == null ? null : json["ResponseCode"],
        message: json["Message"] == null ? null : json["Message"],
        id: json["Id"] == null ? null : json["Id"],
        fullName: json["FullName"] == null ? null : json["FullName"],
        photo: json["Photo"] == null ? null : json["Photo"],
    );

    Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode == null ? null : responseCode,
        "Message": message == null ? null : message,
        "Id": id == null ? null : id,
        "FullName": fullName == null ? null : fullName,
        "Photo": photo == null ? null : photo,
    };
}

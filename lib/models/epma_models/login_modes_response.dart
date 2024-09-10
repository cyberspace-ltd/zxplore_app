 
 // To parse this JSON data, do
//
//     final loginModesResponse = loginModesResponseFromJson(jsonString);

import 'dart:convert';

LoginModesResponse loginModesResponseFromJson(String str) => LoginModesResponse.fromJson(json.decode(str));

String loginModesResponseToJson(LoginModesResponse data) => json.encode(data.toJson());

class LoginModesResponse {
    int code;
    bool status;
    String? message;
    List<LoginModesData>? data;

    LoginModesResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory LoginModesResponse.fromJson(Map<String, dynamic> json) => LoginModesResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<LoginModesData>.from(json["data"].map((x) => LoginModesData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class LoginModesData {
    String? loginModeValue;
    String? loginModeName;

    LoginModesData({
        required this.loginModeValue,
        required this.loginModeName,
    });

    factory LoginModesData.fromJson(Map<String, dynamic> json) => LoginModesData(
        loginModeValue: json["loginModeValue"],
        loginModeName: json["loginModeName"],
    );

    Map<String, dynamic> toJson() => {
        "loginModeValue": loginModeValue,
        "loginModeName": loginModeName,
    };
}

 
 //LoginModesData
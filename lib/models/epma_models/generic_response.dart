// To parse this JSON data, do
//
//     final genericResponse = genericResponseFromMap(jsonString);

import 'dart:convert';

GenericResponse genericResponseFromMap(String str) => GenericResponse.fromMap(json.decode(str));

String genericResponseToMap(GenericResponse data) => json.encode(data.toMap());

class GenericResponse {
    int? code;
    bool? status;
    String? message;
    dynamic data;

    GenericResponse({
        this.code,
        this.status,
        this.message,
        this.data,
    });

    factory GenericResponse.fromMap(Map<String, dynamic> json) => GenericResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: json["data"],
    );

    Map<String, dynamic> toMap() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data,
    };
}

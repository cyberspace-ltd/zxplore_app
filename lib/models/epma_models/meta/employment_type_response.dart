// To parse this JSON data, do
//
//     final employmentTypeResponse = employmentTypeResponseFromJson(jsonString);

import 'dart:convert';

EmploymentTypeResponse employmentTypeResponseFromJson(String str) => EmploymentTypeResponse.fromJson(json.decode(str));

String employmentTypeResponseToJson(EmploymentTypeResponse data) => json.encode(data.toJson());

class EmploymentTypeResponse {
    int code;
    bool status;
    String message;
    List<EmploymentTypeDatum> data;

    EmploymentTypeResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory EmploymentTypeResponse.fromJson(Map<String, dynamic> json) => EmploymentTypeResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<EmploymentTypeDatum>.from(json["data"].map((x) => EmploymentTypeDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class EmploymentTypeDatum {
    String? employmentTypeCode;
    String? employmentTypeName;

    EmploymentTypeDatum({
          this.employmentTypeCode,
          this.employmentTypeName,
    });

    factory EmploymentTypeDatum.fromJson(Map<String, dynamic> json) => EmploymentTypeDatum(
        employmentTypeCode: json["employmentTypeCode"],
        employmentTypeName: json["employmentTypeName"],
    );

    Map<String, dynamic> toJson() => {
        "employmentTypeCode": employmentTypeCode,
        "employmentTypeName": employmentTypeName,
    };
}

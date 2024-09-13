// To parse this JSON data, do
//
//     final customerClassificationResponse = customerClassificationResponseFromJson(jsonString);

import 'dart:convert';

CustomerClassificationResponse customerClassificationResponseFromJson(String str) => CustomerClassificationResponse.fromJson(json.decode(str));

String customerClassificationResponseToJson(CustomerClassificationResponse data) => json.encode(data.toJson());

class CustomerClassificationResponse {
    int code;
    bool status;
    String message;
    List<CustomerClassificationDatum> data;

    CustomerClassificationResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory CustomerClassificationResponse.fromJson(Map<String, dynamic> json) => CustomerClassificationResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<CustomerClassificationDatum>.from(json["data"].map((x) => CustomerClassificationDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class CustomerClassificationDatum {
    String? customerClassificationId;
    String? description;

    CustomerClassificationDatum({
          this.customerClassificationId,
          this.description,
    });

    factory CustomerClassificationDatum.fromJson(Map<String, dynamic> json) => CustomerClassificationDatum(
        customerClassificationId: json["customerClassificationId"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "customerClassificationId": customerClassificationId,
        "description": description,
    };
}

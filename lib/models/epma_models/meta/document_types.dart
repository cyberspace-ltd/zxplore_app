// To parse this JSON data, do
//
//     final documentTypesResponse = documentTypesResponseFromJson(jsonString);

import 'dart:convert';

DocumentTypesResponse documentTypesResponseFromJson(String str) => DocumentTypesResponse.fromJson(json.decode(str));

String documentTypesResponseToJson(DocumentTypesResponse data) => json.encode(data.toJson());

class DocumentTypesResponse {
    int code;
    bool status;
    String message;
    List<DocumentTypessDatum> data;

    DocumentTypesResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory DocumentTypesResponse.fromJson(Map<String, dynamic> json) => DocumentTypesResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<DocumentTypessDatum>.from(json["data"].map((x) => DocumentTypessDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class DocumentTypessDatum {
    String documentTypeCode;
    String documentTypeName;

    DocumentTypessDatum({
        required this.documentTypeCode,
        required this.documentTypeName,
    });

    factory DocumentTypessDatum.fromJson(Map<String, dynamic> json) => DocumentTypessDatum(
        documentTypeCode: json["documentTypeCode"],
        documentTypeName: json["documentTypeName"],
    );

    Map<String, dynamic> toJson() => {
        "documentTypeCode": documentTypeCode,
        "documentTypeName": documentTypeName,
    };
}

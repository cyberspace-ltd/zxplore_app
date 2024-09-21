// To parse this JSON data, do
//
//     final deleteAssignedAccountToEditResponse = deleteAssignedAccountToEditResponsefromJson(jsonString);

import 'dart:convert';

DeleteAssignedAccountToEditResponse deleteAssignedAccountToEditResponsefromJson(String str) => DeleteAssignedAccountToEditResponse.fromJson(json.decode(str));

String deleteAssignedAccountToEditResponseToMap(DeleteAssignedAccountToEditResponse data) => json.encode(data.toMap());

class DeleteAssignedAccountToEditResponse {
    int? code;
    bool? status;
    String? message;
    String? data;

    DeleteAssignedAccountToEditResponse({
        this.code,
        this.status,
        this.message,
        this.data,
    });

    factory DeleteAssignedAccountToEditResponse.fromJson(Map<String, dynamic> json) => DeleteAssignedAccountToEditResponse(
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

// To parse this JSON data, do
//
//     final getDocumentAttachedToEditResponse = getDocumentAttachedToEditResponsefromJson(jsonString);

import 'dart:convert';

import 'package:zxplore_app/models/epma_models/view_account_request.dart';

GetDocumentAttachedToEditResponse getDocumentAttachedToEditResponsefromJson(String str) => GetDocumentAttachedToEditResponse.fromJson(json.decode(str));

String getDocumentAttachedToEditResponsetoJson(GetDocumentAttachedToEditResponse data) => json.encode(data.toJson());

class GetDocumentAttachedToEditResponse {
    int? code;
    bool? status;
    String? message;
    DocumentAttached? data;

    GetDocumentAttachedToEditResponse({
        this.code,
        this.status,
        this.message,
        this.data,
    });

    factory GetDocumentAttachedToEditResponse.fromJson(Map<String, dynamic> json) => GetDocumentAttachedToEditResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : DocumentAttached.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class DocumentAttached {
    int? documentsAttachedId;
    String? reqId;
    String? fileName;
    String? fileImage;
    String? fileExtension;
    int? documentTypeId;
    String? createDate;
    int? rowVersion;
    int? empId;
    String? empFullName;
    DocumentType? documentType;

    DocumentAttached({
        this.documentsAttachedId,
        this.reqId,
        this.fileName,
        this.fileImage,
        this.fileExtension,
        this.documentTypeId,
        this.createDate,
        this.rowVersion,
        this.empId,
        this.empFullName,
        this.documentType,
    });

    factory DocumentAttached.fromJson(Map<String, dynamic> json) => DocumentAttached(
        documentsAttachedId: json["documentsAttachedId"],
        reqId: json["reqId"],
        fileName: json["fileName"],
        fileImage: json["fileImage"],
        fileExtension: json["fileExtension"],
        documentTypeId: json["documentTypeId"],
        createDate: json["createDate"],
        rowVersion: json["rowVersion"],
        empId: json["empId"],
        empFullName: json["empFullName"],
        documentType: json["documentType"] == null ? null : DocumentType.fromMap(json["documentType"]),
    );

    Map<String, dynamic> toJson() => {
        "documentsAttachedId": documentsAttachedId,
        "reqId": reqId,
        "fileName": fileName,
        "fileImage": fileImage,
        "fileExtension": fileExtension,
        "documentTypeId": documentTypeId,
        "createDate": createDate,
        "rowVersion": rowVersion,
        "empId": empId,
        "empFullName": empFullName,
        "documentType": documentType?.toMap(),
    };
}

 

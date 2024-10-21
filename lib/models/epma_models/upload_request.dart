// To parse this JSON data, do
//
//     final uploadRequest = uploadRequestFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

UploadRequest uploadRequestFromJson(String str) => UploadRequest.fromJson(json.decode(str));

String uploadRequestToJson(UploadRequest data) => json.encode(data.toJson());

class UploadRequest {
    String requestId;
    String documentType;
    File files;

    UploadRequest({
        required this.requestId,
        required this.documentType,
        required this.files,
    });

    factory UploadRequest.fromJson(Map<String, dynamic> json) => UploadRequest(
        requestId: json["RequestId"],
        documentType: json["DocumentType"],
        files: json["Files"],
    );

    Map<String, dynamic> toJson() => {
        "RequestId": requestId,
        "DocumentType": documentType,
        "Files": files,
    };
}

// To parse this JSON data, do
//
//     final deleteDocument = deleteDocumentFromMap(jsonString);

import 'dart:convert';

DeleteDocument deleteDocumentFromMap(String str) => DeleteDocument.fromMap(json.decode(str));

String deleteDocumentToMap(DeleteDocument data) => json.encode(data.toMap());

class DeleteDocument {
    int? documentsAttachedId;
    String? requestId;
    int? rowVersion;

    DeleteDocument({
        this.documentsAttachedId,
        this.requestId,
        this.rowVersion,
    });

    factory DeleteDocument.fromMap(Map<String, dynamic> json) => DeleteDocument(
        documentsAttachedId: json["documentsAttachedId"],
        requestId: json["requestId"],
        rowVersion: json["rowVersion"],
    );

    Map<String, dynamic> toMap() => {
        "documentsAttachedId": documentsAttachedId,
        "requestId": requestId,
        "rowVersion": rowVersion,
    };
}

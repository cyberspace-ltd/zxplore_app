	
// To parse this JSON data, do
//
//     final deleteChild = deleteChildFromJson(jsonString);

import 'dart:convert';

DeleteChild deleteChildFromJson(String str) => DeleteChild.fromJson(json.decode(str));

String deleteChildToJson(DeleteChild data) => json.encode(data.toJson());

class DeleteChild {
    int? childId;
    String? requestId;
    int? rowVersion;

    DeleteChild({
        required this.childId,
        required this.requestId,
        required this.rowVersion,
    });

    factory DeleteChild.fromJson(Map<String, dynamic> json) => DeleteChild(
        childId: json["childId"],
        requestId: json["requestId"],
        rowVersion: json["rowVersion"],
    );

    Map<String, dynamic> toJson() => {
        "childId": childId,
        "requestId": requestId,
        "rowVersion": rowVersion,
    };
}

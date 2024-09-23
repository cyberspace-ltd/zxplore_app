// To parse this JSON data, do
//
//     final deleteNextOfKin = deleteNextOfKinFromJson(jsonString);

import 'dart:convert';

DeleteNextOfKin deleteNextOfKinFromJson(String str) => DeleteNextOfKin.fromJson(json.decode(str));

String deleteNextOfKinToJson(DeleteNextOfKin data) => json.encode(data.toJson());

class DeleteNextOfKin {
    int? nextOfKinId;
    String? requestId;
    int? rowVersion;

    DeleteNextOfKin({
          this.nextOfKinId,
          this.requestId,
          this.rowVersion,
    });

    factory DeleteNextOfKin.fromJson(Map<String, dynamic> json) => DeleteNextOfKin(
        nextOfKinId: json["nextOfKinId"],
        requestId: json["requestId"],
        rowVersion: json["rowVersion"],
    );

    Map<String, dynamic> toJson() => {
        "nextOfKinId": nextOfKinId,
        "requestId": requestId,
        "rowVersion": rowVersion,
    };
}
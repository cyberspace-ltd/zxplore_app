// To parse this JSON data, do
//
//     final deleteStakeHolder = deleteStakeHolderFromJson(jsonString);

import 'dart:convert';

DeleteStakeHolder deleteStakeHolderFromJson(String str) => DeleteStakeHolder.fromJson(json.decode(str));

String deleteStakeHolderToJson(DeleteStakeHolder data) => json.encode(data.toJson());

class DeleteStakeHolder {
    int? stakeHolderId;
    String? requestId;
    int? rowVersion;

    DeleteStakeHolder({
        required this.stakeHolderId,
        required this.requestId,
        required this.rowVersion,
    });

    factory DeleteStakeHolder.fromJson(Map<String, dynamic> json) => DeleteStakeHolder(
        stakeHolderId: json["stakeHolderId"],
        requestId: json["requestId"],
        rowVersion: json["rowVersion"],
    );

    Map<String, dynamic> toJson() => {
        "stakeHolderId": stakeHolderId,
        "requestId": requestId,
        "rowVersion": rowVersion,
    };
}
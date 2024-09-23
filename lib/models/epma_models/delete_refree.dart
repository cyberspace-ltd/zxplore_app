// To parse this JSON data, do
//
//     final deleteReferee = deleteRefereeFromJson(jsonString);

import 'dart:convert';

DeleteReferee deleteRefereeFromJson(String str) => DeleteReferee.fromJson(json.decode(str));

String deleteRefereeToJson(DeleteReferee data) => json.encode(data.toJson());

class DeleteReferee {
    int? refereeId;
    String? requestId;
    int? rowVersion;

    DeleteReferee({
        required this.refereeId,
        required this.requestId,
        required this.rowVersion,
    });

    factory DeleteReferee.fromJson(Map<String, dynamic> json) => DeleteReferee(
        refereeId: json["refereeId"],
        requestId: json["requestId"],
        rowVersion: json["rowVersion"],
    );

    Map<String, dynamic> toJson() => {
        "refereeId": refereeId,
        "requestId": requestId,
        "rowVersion": rowVersion,
    };
}
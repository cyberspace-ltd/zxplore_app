// To parse this JSON data, do
//
//     final votersResponse = votersResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

VotersResponse votersResponseFromJson(String str) => VotersResponse.fromJson(json.decode(str));

String votersResponseToJson(VotersResponse data) => json.encode(data.toJson());

class VotersResponse {
  VotersResponse({
    required this.responseCode,
    required this.pollingStation,
    required this.voterId,
    required this.age,
    required this.sex,
    required this.regDate,
    required this.fullname,
    required this.picture,
  });

  final String? responseCode;
  final String? pollingStation;
  final String? voterId;
  final String? age;
  final String? sex;
  final String? regDate;
  final String? fullname;
  final String? picture;

  factory VotersResponse.fromJson(Map<String, dynamic> json) => VotersResponse(
    responseCode: json["ResponseCode"] == null ? null : json["ResponseCode"],
    pollingStation: json["PollingStation"] == null ? null : json["PollingStation"],
    voterId: json["VoterID"] == null ? null : json["VoterID"],
    age: json["Age"] == null ? null : json["Age"],
    sex: json["Sex"] == null ? null : json["Sex"],
    regDate: json["RegDate"] == null ? null : json["RegDate"],
    fullname: json["Fullname"] == null ? null : json["Fullname"],
    picture: json["Picture"] == null ? null : json["Picture"],
  );

  Map<String, dynamic> toJson() => {
    "ResponseCode": responseCode == null ? null : responseCode,
    "PollingStation": pollingStation == null ? null : pollingStation,
    "VoterID": voterId == null ? null : voterId,
    "Age": age == null ? null : age,
    "Sex": sex == null ? null : sex,
    "RegDate": regDate == null ? null : regDate,
    "Fullname": fullname == null ? null : fullname,
    "Picture": picture == null ? null : picture,
  };
}

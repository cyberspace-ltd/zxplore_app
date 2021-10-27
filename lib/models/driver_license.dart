// To parse this JSON data, do
//
//     final driverLicenseResponse = driverLicenseResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DriverLicenseResponse driverLicenseResponseFromJson(String str) => DriverLicenseResponse.fromJson(json.decode(str));

String driverLicenseResponseToJson(DriverLicenseResponse data) => json.encode(data.toJson());

class DriverLicenseResponse {
  DriverLicenseResponse({
    required this.responseCode,
    required this.name,
    required this.dateOfBirth,
    required this.processingCenter,
    required this.classOfLicence,
    required this.nationality,
    required this.dateOfIssue,
    required this.expiryDate,
    required this.certificateDate,
    required this.certificateOfCompetence,
    required this.driverImage,
    required this.pin,
    required this.pollingStation,
    required this.voterId,
    required this.age,
    required this.sex,
    required this.regDate,
    required this.fullname,
    required this.picture,
  });

  final String? responseCode;
  final String? name;
  final String? dateOfBirth;
  final String? processingCenter;
  final String? classOfLicence;
  final String? nationality;
  final String? dateOfIssue;
  final String? expiryDate;
  final String? certificateDate;
  final String? certificateOfCompetence;
  final String? driverImage;
  final String? pin;
  final String? pollingStation;
  final String? voterId;
  final String? age;
  final String? sex;
  final String? regDate;
  final String? fullname;
  final String? picture;


  factory DriverLicenseResponse.fromJson(Map<String, dynamic> json) => DriverLicenseResponse(
    responseCode: json["ResponseCode"] == null ? null : json["ResponseCode"],
    name: json["Name"] == null ? null : json["Name"],
    dateOfBirth: json["DateOfBirth"] == null ? null : json["DateOfBirth"],
    processingCenter: json["ProcessingCenter"] == null ? null : json["ProcessingCenter"],
    classOfLicence: json["ClassOfLicence"] == null ? null : json["ClassOfLicence"],
    nationality: json["Nationality"] == null ? null : json["Nationality"],
    dateOfIssue: json["DateOfIssue"] == null ? null : json["DateOfIssue"],
    expiryDate: json["ExpiryDate"] == null ? null : json["ExpiryDate"],
    certificateDate: json["CertificateDate"] == null ? null : json["CertificateDate"],
    certificateOfCompetence: json["CertificateOfCompetence"] == null ? null : json["CertificateOfCompetence"],
    driverImage: json["DriverImage"] == null ? null : json["DriverImage"],
    pin: json["PIN"] == null ? null : json["PIN"],
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
    "Name": name == null ? null : name,
    "DateOfBirth": dateOfBirth == null ? null : dateOfBirth,
    "ProcessingCenter": processingCenter == null ? null : processingCenter,
    "ClassOfLicence": classOfLicence == null ? null : classOfLicence,
    "Nationality": nationality == null ? null : nationality,
    "DateOfIssue": dateOfIssue == null ? null : dateOfIssue,
    "ExpiryDate": expiryDate == null ? null : expiryDate,
    "CertificateDate": certificateDate == null ? null : certificateDate,
    "CertificateOfCompetence": certificateOfCompetence == null ? null : certificateOfCompetence,
    "DriverImage": driverImage == null ? null : driverImage,
    "PIN": pin == null ? null : pin,
    "PollingStation": pollingStation == null ? null : pollingStation,
    "VoterID": voterId == null ? null : voterId,
    "Age": age == null ? null : age,
    "Sex": sex == null ? null : sex,
    "RegDate": regDate == null ? null : regDate,
    "Fullname": fullname == null ? null : fullname,
    "Picture": picture == null ? null : picture,
  };
}

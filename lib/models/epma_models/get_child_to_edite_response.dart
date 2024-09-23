


// To parse this JSON data, do
//
//     final GetChildToEditResponse = GetChildToEditResponseFromJson(jsonString);

import 'dart:convert';

GetChildToEditResponse GetChildToEditResponseFromJson(String str) => GetChildToEditResponse.fromJson(json.decode(str));

String GetChildToEditResponseToJson(GetChildToEditResponse data) => json.encode(data.toJson());

class GetChildToEditResponse {
    int? code;
    bool? status;
    String? message;
    ChildData? data;

    GetChildToEditResponse({
         this.code,
         this.status,
         this.message,
         this.data,
    });

    factory GetChildToEditResponse.fromJson(Map<String, dynamic> json) => GetChildToEditResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: ChildData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class ChildData {
  int? chidId;
String? reqId;
int? rowVersion;
String? itemStage;
String? surname;
String? otherNames;
DateTime? birthDate;
String? nationalityCode;
String? genderCode;
String? countryOrigCode;
int? age;
String? school;
String? motherName;
int? maturityAge;
String? actionFlag;

    ChildData({
         this.chidId,
         this.reqId,
         this.rowVersion,
         this.itemStage,
         this.surname,
         this.otherNames,
         this.birthDate,
         this.nationalityCode,
         this.genderCode,
         this.countryOrigCode,
         this.age,
         this.school,
         this.motherName,
         this.maturityAge,
         this.actionFlag,
    });

    factory ChildData.fromJson(Map<String, dynamic> json) => ChildData(
        chidId: json["chidId"],
        reqId: json["reqId"],
        rowVersion: json["rowVersion"],
        itemStage: json["itemStage"],
        surname: json["surname"],
        otherNames: json["otherNames"],
        birthDate: DateTime.parse(json["birthDate"]),
        nationalityCode: json["nationalityCode"],
        genderCode: json["genderCode"],
        countryOrigCode: json["countryOrigCode"],
        age: json["age"],
        school: json["school"],
        motherName: json["motherName"],
        maturityAge: json["maturityAge"],
        actionFlag: json["actionFlag"],
    );

    Map<String, dynamic> toJson() => {
        "chidId": chidId,
        "reqId": reqId,
        "rowVersion": rowVersion,
        "itemStage": itemStage,
        "surname": surname,
        "otherNames": otherNames,
        "birthDate": birthDate?.toIso8601String(),
        "nationalityCode": nationalityCode,
        "genderCode": genderCode,
        "countryOrigCode": countryOrigCode,
        "age": age,
        "school": school,
        "motherName": motherName,
        "maturityAge": maturityAge,
        "actionFlag": actionFlag,
    };
}


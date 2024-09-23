


// To parse this JSON data, do
//
//     final getChildToEdit = getChildToEditFromJson(jsonString);

import 'dart:convert';

GetChildToEdit getChildToEditFromJson(String str) => GetChildToEdit.fromJson(json.decode(str));

String getChildToEditToJson(GetChildToEdit data) => json.encode(data.toJson());

class GetChildToEdit {
    int? code;
    bool? status;
    String? message;
    ChildData? data;

    GetChildToEdit({
         this.code,
         this.status,
         this.message,
         this.data,
    });

    factory GetChildToEdit.fromJson(Map<String, dynamic> json) => GetChildToEdit(
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


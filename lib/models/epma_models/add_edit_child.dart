
// To parse this JSON data, do
//
//     final editChild = editChildFromJson(jsonString);

import 'dart:convert';

EditChild editChildFromJson(String str) => EditChild.fromJson(json.decode(str));

String editChildToJson(EditChild data) => json.encode(data.toJson());

class EditChild {
   int? childId;
String? requestId;
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

    EditChild({
         this.childId,
         this.requestId,
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

    factory EditChild.fromJson(Map<String, dynamic> json) => EditChild(
        childId: json["childId"],
        requestId: json["requestId"],
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
        "childId": childId,
        "requestId": requestId,
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


// To parse this JSON data, do
//
//     final addChild = addChildFromJson(jsonString);

// import 'dart:convert';

AddChild addChildFromJson(String str) => AddChild.fromJson(json.decode(str));

String addChildToJson(AddChild data) => json.encode(data.toJson());

class AddChild {
  int? childId;
String? requestId;
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

    AddChild({
         this.childId,
         this.requestId,
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

    factory AddChild.fromJson(Map<String, dynamic> json) => AddChild(
        childId: json["childId"],
        requestId: json["requestId"],
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
        "childId": childId,
        "requestId": requestId,
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
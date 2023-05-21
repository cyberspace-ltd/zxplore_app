import 'dart:convert';

AccountClass accountClassFromJson(String str) =>
    AccountClass.fromJson(json.decode(str));

String accountClassToJson(AccountClass data) => json.encode(data.toJson());

class AccountClass {
  String? responseCode;
  String? responseMessage;
  List<AccountClassCode>? accountClassCodes;

  AccountClass({
    this.responseCode,
    this.responseMessage,
    this.accountClassCodes,
  });

  factory AccountClass.fromJson(Map<String, dynamic> json) => AccountClass(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        accountClassCodes: List<AccountClassCode>.from(
          json["AccountClassCodes"].map((x) => AccountClassCode.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "ResponseMessage": responseMessage,
        "AccountClassCodes": List<dynamic>.from(
          accountClassCodes!.map((x) => x.toJson()),
        ),
      };
}

class AccountClassCode {
  int? classCode;
  String? description;
  String? classType;

  AccountClassCode({this.classCode, this.description, this.classType});

  factory AccountClassCode.fromJson(Map<String, dynamic> json) =>
      AccountClassCode(
        classCode: int.tryParse(json["ClassCode"]),
        description: json["Description"],
        classType: json["ClassType"],
      );

  Map<String, dynamic> toJson() => {
        "ClassCode": classCode,
        "Description": description,
        "ClassType": classType,
      };
}

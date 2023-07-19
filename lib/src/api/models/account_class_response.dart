import 'dart:convert';

AccountClassResponse accountClassResponseFromJson(String str) =>
    AccountClassResponse.fromJson(json.decode(str));

String accountClassResponseToJson(AccountClassResponse data) =>
    json.encode(data.toJson());

class AccountClassResponse {
  String? responseCode;
  String? responseMessage;
  List<AccountClassCode>? accountClassCodes;

  AccountClassResponse({
    this.responseCode,
    this.responseMessage,
    this.accountClassCodes,
  });

  factory AccountClassResponse.fromJson(Map<String, dynamic> json) =>
      AccountClassResponse(
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

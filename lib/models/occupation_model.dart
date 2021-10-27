// To parse this JSON data, do
//
//     final occupation = occupationFromJson(jsonString);

import 'dart:convert';

Occupation occupationFromJson(String str) => Occupation.fromJson(json.decode(str));

String occupationToJson(Occupation data) => json.encode(data.toJson());

class Occupation {
    Occupation({
        this.responseCode,
        this.responseMessage,
        this.menu,
    });

    String? responseCode;
    String? responseMessage;
    List<OccupationMenu>? menu;

    factory Occupation.fromJson(Map<String, dynamic> json) => Occupation(
        responseCode: json["ResponseCode"] == null ? null : json["ResponseCode"],
        responseMessage: json["ResponseMessage"] == null ? null : json["ResponseMessage"],
        menu: json["Menu"] == null ? null : List<OccupationMenu>.from(json["Menu"].map((x) => OccupationMenu.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode == null ? null : responseCode,
        "ResponseMessage": responseMessage == null ? null : responseMessage,
        "Menu": menu == null ? null : List<dynamic>.from(menu!.map((x) => x.toJson())),
    };
}

class OccupationMenu {
    OccupationMenu({
        this.srn,
        this.occupationName,
        this.sironCode,
        this.groupName,
    });

    int? srn;
    String? occupationName;
    String? sironCode;
    String? groupName;

    factory OccupationMenu.fromJson(Map<String, dynamic> json) => OccupationMenu(
        srn: json["Srn"] == null ? null : json["Srn"],
        occupationName: json["OccupationName"] == null ? null : json["OccupationName"],
        sironCode: json["SironCode"] == null ? null : json["SironCode"],
        groupName: json["GroupName"] == null ? null : json["GroupName"],
    );

    Map<String, dynamic> toJson() => {
        "Srn": srn == null ? null : srn,
        "OccupationName": occupationName == null ? null : occupationName,
        "SironCode": sironCode == null ? null : sironCode,
        "GroupName": groupName == null ? null : groupName,
    };
}

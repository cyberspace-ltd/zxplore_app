// To parse this JSON data, do
//
//     final regionsResponse = regionsResponseFromJson(jsonString);

import 'dart:convert';

RegionsResponse regionsResponseFromJson(String str) => RegionsResponse.fromJson(json.decode(str));

String regionsResponseToJson(RegionsResponse data) => json.encode(data.toJson());

class RegionsResponse {
    int code;
    bool status;
    String message;
    List<RegionDatum> data;

    RegionsResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory RegionsResponse.fromJson(Map<String, dynamic> json) => RegionsResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<RegionDatum>.from(json["data"].map((x) => RegionDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class RegionDatum {
    String? regionCode;
    String? regionName;

    RegionDatum({
          this.regionCode,
          this.regionName,
    });

    factory RegionDatum.fromJson(Map<String, dynamic> json) => RegionDatum(
        regionCode: json["regionCode"],
        regionName: json["regionName"],
    );

    Map<String, dynamic> toJson() => {
        "regionCode": regionCode,
        "regionName": regionName,
    };
}

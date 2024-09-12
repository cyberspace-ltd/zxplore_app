// To parse this JSON data, do
//
//     final reconStatusResponse = reconStatusResponseFromJson(jsonString);

import 'dart:convert';

ReconStatusResponse reconStatusResponseFromJson(String str) => ReconStatusResponse.fromJson(json.decode(str));

String reconStatusResponseToJson(ReconStatusResponse data) => json.encode(data.toJson());

class ReconStatusResponse {
    int code;
    bool status;
    String message;
    List<ReconStatusDatum> data;

    ReconStatusResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory ReconStatusResponse.fromJson(Map<String, dynamic> json) => ReconStatusResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<ReconStatusDatum>.from(json["data"].map((x) => ReconStatusDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class ReconStatusDatum {
    String? reconStatusValue;
    String? reconStatusName;

    ReconStatusDatum({
          this.reconStatusValue,
          this.reconStatusName,
    });

    factory ReconStatusDatum.fromJson(Map<String, dynamic> json) => ReconStatusDatum(
        reconStatusValue: json["reconStatusValue"],
        reconStatusName: json["reconStatusName"],
    );

    Map<String, dynamic> toJson() => {
        "reconStatusValue": reconStatusValue,
        "reconStatusName": reconStatusName,
    };
}

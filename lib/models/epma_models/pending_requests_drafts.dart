import 'package:zxplore_app/models/epma_models/pending_requests_all_response.dart';

class PendingRequestsDraftsResponse {
    int? code;
    bool status;
    String? message;
    List<PendingRequestsDatum>? data;

    PendingRequestsDraftsResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

        factory PendingRequestsDraftsResponse.fromJson(Map<String, dynamic> json) => PendingRequestsDraftsResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<PendingRequestsDatum>.from(json["data"].map((x) => PendingRequestsDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}


 
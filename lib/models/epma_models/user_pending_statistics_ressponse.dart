// To parse this JSON data, do
//
//     final userPendingStatisticsResponse = userPendingStatisticsResponseFromJson(jsonString);

import 'dart:convert';

UserPendingStatisticsResponse userPendingStatisticsResponseFromJson(String str) => UserPendingStatisticsResponse.fromJson(json.decode(str));

String userPendingStatisticsResponseToJson(UserPendingStatisticsResponse data) => json.encode(data.toJson());

class UserPendingStatisticsResponse {
    int code;
    bool status;
    String message;
    StatisticsData data;

    UserPendingStatisticsResponse({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory UserPendingStatisticsResponse.fromJson(Map<String, dynamic> json) => UserPendingStatisticsResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: StatisticsData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class StatisticsData {
      static const List<String> keys = ['Draft', 'Other Stages', 'Pending Postingsr'];


    int draft;
    int otherStages;
    int pendingPostingInstant;

    StatisticsData({
        required this.draft,
        required this.otherStages,
        required this.pendingPostingInstant,
    });

    factory StatisticsData.fromJson(Map<String, dynamic> json) => StatisticsData(
        draft: json["draft"],
        otherStages: json["otherStages"],
        pendingPostingInstant: json["pendingPostingInstant"],
    );

    Map<String, dynamic> toJson() => {
        "draft": draft,
        "otherStages": otherStages,
        "pendingPostingInstant": pendingPostingInstant,
    };
}
 

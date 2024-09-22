// To parse this JSON data, do
//
//     final GetRelatedBusinessToEditResponse = GetRelatedBusinessToEditResponseFromJson(json String?);

import 'dart:convert';

GetRelatedBusinessToEditResponse GetRelatedBusinessToEditResponseFromJson( String? str) => GetRelatedBusinessToEditResponse.fromJson(json.decode(str??''));

 String? GetRelatedBusinessToEditResponseToJson(GetRelatedBusinessToEditResponse data) => json.encode(data.toJson());

class GetRelatedBusinessToEditResponse {
     int? code;
     bool? status;
     String? message;
    RelatedBusinessData? data;

    GetRelatedBusinessToEditResponse({
          this.code,
          this.status,
          this.message,
          this.data,
    });

    factory GetRelatedBusinessToEditResponse.fromJson(Map< String, dynamic> json) => GetRelatedBusinessToEditResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: RelatedBusinessData.fromJson(json["data"]),
    );

    Map< String?, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class RelatedBusinessData {
     int? relatedBusinessId;
     String? reqId;
     int? rowVersion;
     String? itemStage;
     String? name;
     String? address;
     String? relationshipNature;
     String? actionFlag;

    RelatedBusinessData({
          this.relatedBusinessId,
          this.reqId,
          this.rowVersion,
          this.itemStage,
          this.name,
          this.address,
          this.relationshipNature,
          this.actionFlag,
    });

    factory RelatedBusinessData.fromJson(Map< String, dynamic> json) => RelatedBusinessData(
        relatedBusinessId: json["relatedBusinessId"],
        reqId: json["reqId"],
        rowVersion: json["rowVersion"],
        itemStage: json["itemStage"],
        name: json["name"],
        address: json["address"],
        relationshipNature: json["relationshipNature"],
        actionFlag: json["actionFlag"],
    );

    Map< String?, dynamic> toJson() => {
        "relatedBusinessId": relatedBusinessId,
        "reqId": reqId,
        "rowVersion": rowVersion,
        "itemStage": itemStage,
        "name": name,
        "address": address,
        "relationshipNature": relationshipNature,
        "actionFlag": actionFlag,
    };
}
 
DeleteRelatedBusiness deleteRelatedBusinessFromJson( String? str) => DeleteRelatedBusiness.fromJson(json.decode(str??''));

 String? deleteRelatedBusinessToJson(DeleteRelatedBusiness data) => json.encode(data.toJson());

class DeleteRelatedBusiness {
     int? relatedBusinessId;
     String? requestId;
     int? rowVersion;

    DeleteRelatedBusiness({
          this.relatedBusinessId,
          this.requestId,
          this.rowVersion,
    });

    factory DeleteRelatedBusiness.fromJson(Map< String?, dynamic> json) => DeleteRelatedBusiness(
        relatedBusinessId: json["relatedBusinessId"],
        requestId: json["requestId"],
        rowVersion: json["rowVersion"],
    );

    Map< String?, dynamic> toJson() => {
        "relatedBusinessId": relatedBusinessId,
        "requestId": requestId,
        "rowVersion": rowVersion,
    };
}



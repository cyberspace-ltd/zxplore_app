


// To parse this JSON data, do
//
//     final AddRelatedBusiness = AddRelatedBusinessFromJson(jsonString);

import 'dart:convert';

AddRelatedBusiness AddRelatedBusinessFromJson(String str) => AddRelatedBusiness.fromJson(json.decode(str));

String AddRelatedBusinessToJson(AddRelatedBusiness data) => json.encode(data.toJson());

class AddRelatedBusiness {
     int? relatedBusinessId;
     String? requestId;
     int? rowVersion;
     String? itemStage;
     String? name;
     String? address;
     String? relationshipNature;
     String? actionFlag;

    AddRelatedBusiness({
         this.relatedBusinessId,
         this.requestId,
         this.rowVersion,
         this.itemStage,
         this.name,
         this.address,
         this.relationshipNature,
         this.actionFlag,
    });

    factory AddRelatedBusiness.fromJson(Map<String, dynamic> json) => AddRelatedBusiness(
        relatedBusinessId: json["relatedBusinessId"],
        requestId: json["requestId"],
        rowVersion: json["rowVersion"],
        itemStage: json["itemStage"],
        name: json["name"],
        address: json["address"],
        relationshipNature: json["relationshipNature"],
        actionFlag: json["actionFlag"],
    );

    Map<String, dynamic> toJson() => {
        "relatedBusinessId": relatedBusinessId,
        "requestId": requestId,
        "rowVersion": rowVersion,
        "itemStage": itemStage,
        "name": name,
        "address": address,
        "relationshipNature": relationshipNature,
        "actionFlag": actionFlag,
    };
}


 
EditRelatedBusiness editRelatedBusinessFromJson(String str) => EditRelatedBusiness.fromJson(json.decode(str));

String editRelatedBusinessToJson(EditRelatedBusiness data) => json.encode(data.toJson());

class EditRelatedBusiness {
     int? relatedBusinessId;
     String? requestId;
     int? rowVersion;
     String? itemStage;
     String? name;
     String? address;
     String? relationshipNature;
     String? actionFlag;

    EditRelatedBusiness({
         this.relatedBusinessId,
         this.requestId,
         this.rowVersion,
         this.itemStage,
         this.name,
         this.address,
         this.relationshipNature,
         this.actionFlag,
    });

    factory EditRelatedBusiness.fromJson(Map<String, dynamic> json) => EditRelatedBusiness(
        relatedBusinessId: json["relatedBusinessId"],
        requestId: json["requestId"],
        rowVersion: json["rowVersion"],
        itemStage: json["itemStage"],
        name: json["name"],
        address: json["address"],
        relationshipNature: json["relationshipNature"],
        actionFlag: json["actionFlag"],
    );

    Map<String, dynamic> toJson() => {
        "relatedBusinessId": relatedBusinessId,
        "requestId": requestId,
        "rowVersion": rowVersion,
        "itemStage": itemStage,
        "name": name,
        "address": address,
        "relationshipNature": relationshipNature,
        "actionFlag": actionFlag,
    };
}


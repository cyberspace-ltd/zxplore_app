class AccountDatum {
  int? refId;
  int? id;
  String? accountName;
  String? status;
  String? phoneNumber;

  AccountDatum({
    this.refId,
    this.id,
    this.accountName,
    this.status,
    this.phoneNumber,
  });

  factory AccountDatum.fromJson(Map<String, dynamic> json) => new AccountDatum(
        refId: json["refId"],
        id: json["id"],
        accountName: json["accountName"],
        status: json["status"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "refId": refId,
        "id": id,
        "accountName": accountName,
        "status": status,
        "phoneNumber": phoneNumber,
      };
}

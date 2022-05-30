class AccountPurposes{
  String? accountPurpose;

AccountPurposes(this.accountPurpose);

  AccountPurposes.fromJson(Map<String, dynamic> json)
       : accountPurpose = json['AccountPurpose'];

  Map<String, dynamic> toJson() => {
        'AccountPurpose': accountPurpose,
      };

}

class SourceOfFundsObj{
  String? sourceOfFunds;

 SourceOfFundsObj(this.sourceOfFunds);

 SourceOfFundsObj.fromJson(Map<String, dynamic> json)
       : sourceOfFunds = json['SourceOfFunds'];

  Map<String, dynamic> toJson() => {
        'SourceOfFunds': sourceOfFunds,
      };

}
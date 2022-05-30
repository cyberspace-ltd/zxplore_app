class TransactionTypes {
  String? transactionType;
  String? transactionCount;
   String? expectedAmount;

  TransactionTypes({ this.transactionType, 
   this.transactionCount,
   this.expectedAmount});

  TransactionTypes.fromJson(Map<String, dynamic> json)
      : transactionType = json['TransactionType'],
       transactionCount = json['TransactionCount'],
        expectedAmount = json['ExpectedAmount'];

  Map<String, dynamic> toJson() => {
        'TransactionType': transactionType,
         'TransactionCount': transactionCount,
        'ExpectedAmount': expectedAmount,
      };

}
import 'package:equatable/equatable.dart';

class OfflineAccountModel extends Equatable {
  const OfflineAccountModel({
    this.id,
    this.referenceId,
    this.accountType,
    this.accountHolderType,
    this.riskRank,
    this.accountCategory,
    this.bvn,
    this.title,
    this.surname,
    this.firstName,
    this.otherName,
    this.mothersMaidenName,
    this.dateOfBirth,
    this.stateOfOrigin,
    this.countryOfOrigin,
    this.email,
    this.phone,
    this.nextOfKin,
    this.address1,
    this.address2,
    this.countryOfResidence,
    this.stateOfResidence,
    this.cityOfResidence,
    this.gender,
    this.occupation,
    this.maritalStatus,
    this.idType,
    this.idIssuer,
    this.idNumber,
    this.idPlaceOfIssue,
    this.idIssueDate,
    this.idExpiryDate,
    this.isSendEmail,
    this.isReceiveAlert,
    this.isRequestHardwareToken,
    this.isRequestInternetBanking,
    this.idCard,
    this.passport,
    this.utility,
    this.signature,
  });

  final int? id;
  final String? referenceId;
  final String? accountType;
  final String? accountHolderType;
  final String? riskRank;
  final String? accountCategory;
  final String? bvn;
  final String? title;
  final String? surname;
  final String? firstName;
  final String? otherName;
  final String? mothersMaidenName;
  final String? dateOfBirth;
  final String? stateOfOrigin;
  final String? countryOfOrigin;
  final String? email;
  final String? phone;
  final String? nextOfKin;
  final String? address1;
  final String? address2;
  final String? countryOfResidence;
  final String? stateOfResidence;
  final String? cityOfResidence;
  final String? gender;
  final String? occupation;
  final String? maritalStatus;
  final String? idType;
  final String? idIssuer;
  final String? idNumber;
  final String? idPlaceOfIssue;
  final String? idIssueDate;
  final String? idExpiryDate;
  final bool? isSendEmail;
  final bool? isReceiveAlert;
  final bool? isRequestHardwareToken;
  final bool? isRequestInternetBanking;
  final String? idCard;
  final String? passport;
  final String? utility;
  final String? signature;

  @override
  List<Object?> get props => [
        id,
        referenceId,
        accountType,
        accountHolderType,
        riskRank,
        accountCategory,
        bvn,
        title,
        surname,
        firstName,
        otherName,
        mothersMaidenName,
        dateOfBirth,
        stateOfOrigin,
        countryOfOrigin,
        email,
        phone,
        nextOfKin,
        address1,
        address2,
        countryOfResidence,
        stateOfResidence,
        cityOfResidence,
        gender,
        occupation,
        maritalStatus,
        idType,
        idIssuer,
        idNumber,
        idPlaceOfIssue,
        idIssueDate,
        idExpiryDate,
        isSendEmail,
        isReceiveAlert,
        isRequestHardwareToken,
        isRequestInternetBanking,
        idCard,
        passport,
        utility,
        signature,
      ];
}

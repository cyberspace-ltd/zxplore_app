import 'package:freezed_annotation/freezed_annotation.dart';

part 'offline_account_model.freezed.dart';

@freezed
class OfflineAccountModel with _$OfflineAccountModel {
  const factory OfflineAccountModel({
    int? id,
    String? referenceId,
    String? accountType,
    String? accountHolderType,
    String? riskRank,
    String? accountCategory,
    String? bvn,
    String? title,
    String? surname,
    String? firstName,
    String? otherName,
    String? mothersMaidenName,
    String? dateOfBirth,
    String? stateOfOrigin,
    String? countryOfOrigin,
    String? email,
    String? phone,
    String? nextOfKin,
    String? address1,
    String? address2,
    String? countryOfResidence,
    String? stateOfResidence,
    String? cityOfResidence,
    String? gender,
    String? occupation,
    String? maritalStatus,
    String? idType,
    String? idIssuer,
    String? idNumber,
    String? idPlaceOfIssue,
    String? idIssueDate,
    String? idExpiryDate,
    bool? isSendEmail,
    bool? isReceiveAlert,
    bool? isRequestHardwareToken,
    bool? isRequestInternetBanking,
    String? idCard,
    String? passport,
    String? utility,
    String? signature,
  }) = _OfflineAccountModel;
}

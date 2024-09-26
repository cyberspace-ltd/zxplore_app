import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/models/delete_child.dart';
import 'package:zxplore_app/models/epma_models/add_account_model.dart';
import 'package:zxplore_app/models/epma_models/add_edit_child.dart';
import 'package:zxplore_app/models/epma_models/add_edit_foreign_account.dart';
import 'package:zxplore_app/models/epma_models/add_edit_next_of_kin.dart';
import 'package:zxplore_app/models/epma_models/add_edit_refree.dart';
import 'package:zxplore_app/models/epma_models/add_edit_stake_holder.dart';
import 'package:zxplore_app/models/epma_models/delete_document.dart';
import 'package:zxplore_app/models/epma_models/delete_foreign.dart';
import 'package:zxplore_app/models/epma_models/delete_next_of_kin_model.dart';
import 'package:zxplore_app/models/epma_models/delete_other_bank_account.dart';
import 'package:zxplore_app/models/epma_models/delete_refree.dart';
import 'package:zxplore_app/models/epma_models/delete_stake_holder.dart';
import 'package:zxplore_app/models/epma_models/edit_account_purpose.dart';
import 'package:zxplore_app/models/epma_models/edit_duedeligience.dart';
import 'package:zxplore_app/models/epma_models/edit_funding_sources.dart';
import 'package:zxplore_app/models/epma_models/edit_personal_details_data.dart';
import 'package:zxplore_app/models/epma_models/epma_login_response.dart';
import 'package:zxplore_app/models/epma_models/get_assigned_account_to_edit_response.dart';
import 'package:zxplore_app/models/epma_models/get_related_business_response.dart';
import 'package:zxplore_app/models/epma_models/login_modes_response.dart';
import 'package:zxplore_app/models/epma_models/edit_monthly_activity_model.dart';
import 'package:zxplore_app/utils/app_exception.dart';
import 'remote_api_base.dart';

part 'remote_endpoints.g.dart';

@riverpod
RemoteApi remoteApi(RemoteApiRef ref) => RemoteApi(createDio());

/// UnauthorisedException
class UnauthorisedException extends AppException {
  /// UnauthorisedException
  UnauthorisedException(super.message);
}

/// RemoteApi
@RestApi()
abstract class RemoteApi {
  /// RemoteApi
  factory RemoteApi(Dio dio) = _RemoteApi;

  // ----------------- Authentication Endpoints -----------------

  @GET('Account/loginModes')
  Future<LoginModesResponse> getLoginModes({
    @CancelRequest() CancelToken? cancelToken,
  });
  @POST('Account/login')
  Future<EpmaLoginResponse> login({
    @Field('loginMode') required String loginMode,
    @Field('username') required String username,
    @Field('password') required String password,
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST('Account/renewToken')
  Future<dynamic> renewToken({
    @Field('token') required String oldToken,
  });
  // -----------------OPERATIONS IN APP -----------------
  @GET('Operation/userPendingStatistics')
  Future<dynamic> getUserPendingStatistics({
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET('Operation/pendingRequestsDraft')
  Future<dynamic> getUserPendingDraft({
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET('Operation/pendingRequestsAll')
  Future<dynamic> getUserPendingAll({
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET('Operation/viewAccountRequest')
  Future<dynamic> viewAccountRequest({
    @Query('RequestId') required String? requestId,
  });

  @POST('Operation/createNewRequest')
  Future<dynamic> createAccount({
    @Field('surname') required String? surname,
    @Field('firstName') required String? firstName,
    @Field('otherNames') String? otherNames,
    @Field('genderCode') required String? genderCode,
    @Field('birthDate') required String? birthDate,
    @Field('citizenshipCode') required String? citizenshipCode,
    @Field('identificationTypeId') required int? identificationTypeId,
    @Field('identificationNo') required String? identificationNo,
    @Field('idCountryCode') required String? idCountryCode,
    @Field('idIssueAuthority') required String? idIssueAuthority,
    @Field('idExpiryDate') required String? idExpiryDate,
    @Field('idIssueDate') required String? idIssueDate,
    @Field('niaVerificationNo') required String? niaVerificationNo,
    @Field('iddCode') required String? iddCode,
    @Field('telNo') required String? telNo,
    @Field('mobileNo') required String? mobileNo,
    @Field('residentialAddress') required String? residentialAddress,
    @Field('city') required String? city,
    @Field('residentialAddress2') String? residentialAddress2,
    @CancelRequest() CancelToken? cancelToken,
  });

  // ----------------- META Endpoints -----------------
  @GET('Metadata/accountClass')
  Future<dynamic> getAccountClass(
      {@Query('RequestId') required String? requestId,
      @Query('AccountType') required String? accountType,
      @Query('SeriesCode') required String? seriesCode});
  @GET('Metadata/accountSeries')
  Future<dynamic> getAccountSeries(
      {@Query('RequestId') required String? requestId,
      @Query('AccountType') required String? accountType});
  @GET('Metadata/accoutTypes')
  Future<dynamic> getAccoutTypes();
  @GET('Metadata/anticipatedAmounts')
  Future<dynamic> getAnticipatedAmounts();
  @GET('Metadata/anticipatedTransactions')
  Future<dynamic> getAnticipatedTransactions();
  @GET('Metadata/businessNatures')
  Future<dynamic> getBusinessNatures();
  @GET('Metadata/Countries')
  Future<dynamic> getCountries();
  @GET('Metadata/customerClassifications')
  Future<dynamic> getCustomerClassification();
  @GET('Metadata/documentTypes')
  Future<dynamic> getDocumentTypes();
  @GET('Metadata/employmentTypes')
  Future<dynamic> getEmployTypes();
  @GET('Metadata/fatcaStatus')
  Future<dynamic> getFatcaStatus();
  @GET('Metadata/genders')
  Future<dynamic> getGenders();
  @GET('Metadata/identificationTypes')
  Future<dynamic> getIdentificationTypes();
  @GET('Metadata/maritalStatus')
  Future<dynamic> getMaritalStatus();
  @GET('Metadata/regions')
  Future<dynamic> getRegions();
  @GET('Metadata/searchOptions')
  Future<dynamic> getSearchOptions();
  @GET('Metadata/viewAccountRequest')
  Future<dynamic> getReconStatus();
  @GET('Metadata/subBusinessNatures')
  Future<dynamic> getSubBusinessNatures(
      {@Query('BusinessNatureId') required int? businessNatureId});

  // ----------------- Edit Endpoints -----------------
  @GET('Operation/getPersonalDetailToEdit')
  Future<dynamic> getPersonalDetailToEdit({
    @Query('RequestId') required String? RequestId,
  });

  @POST('Operation/editPersonalDetail')
  Future<dynamic> editPersonalDetail({
     @Field("formId")
  int? formId,

  @Field("requestId")
  String? requestId,

  @Field("rowVersion")
  int? rowVersion,

  @Field("itemStage")
  String? itemStage,

  @Field("surname")
  String? surname,

  @Field("firstName")
  String? firstName,

  @Field("otherNames")
  String? otherNames,

  @Field("maidenName")
  String? maidenName,

  @Field("genderCode")
  String? genderCode,

  @Field("birthDate")
  String? birthDate,

  @Field("birthPlace")
  String? birthPlace,

  @Field("identificationTypeId")
  int? identificationTypeId,

  @Field("identificationNo")
  String? identificationNo,

  @Field("idCountryCode")
  String? idCountryCode,

  @Field("idIssueAuthority")
  String? idIssueAuthority,

  @Field("idIssueDate")
  String? idIssueDate,

  @Field("idExpiryDate")
  String? idExpiryDate,

  @Field("niaVerificationNo")
  String? niaVerificationNo,

  @Field("ssnitNo")
  String? ssnitNo,

  @Field("tin")
  String? tin,

  @Field("citizenshipCode")
  String? citizenshipCode,

  @Field("altCitizenshipCode")
  String? altCitizenshipCode,

  @Field("countryOrigCode")
  String? countryOrigCode,

  @Field("homeTown")
  String? homeTown,

  @Field("hasPermanentResidence")
  bool? hasPermanentResidence,

  @Field("residencePermitNo")
  String? residencePermitNo,

  @Field("residencePermitPlaceCode")
  String? residencePermitPlaceCode,

  @Field("permitIssueDate")
  String? permitIssueDate,

  @Field("permitExpiryDate")
  String? permitExpiryDate,

  @Field("iddCode")
  String? iddCode,

  @Field("telNo")
  String? telNo,

  @Field("mobileNo")
  String? mobileNo,

  @Field("emailAddress")
  String? emailAddress,

  @Field("residentialAddress")
  String? residentialAddress,

  @Field("residentialAddress2")
  String? residentialAddress2,

  @Field("districtAssemblyArea")
  String? districtAssemblyArea,

  @Field("city")
  String? city,

  @Field("regionCode")
  String? regionCode,

  @Field("permanentResidentialAddress")
  String? permanentResidentialAddress,

  @Field("permanentResidentialCity")
  String? permanentResidentialCity,

  @Field("permanentResidentialCountryCode")
  String? permanentResidentialCountryCode,

  @Field("mailingAddress")
  String? mailingAddress,

  @Field("motherMaidenName")
  String? motherMaidenName,

  @Field("maritalStatus")
  String? maritalStatus,

  @Field("spouseName")
  String? spouseName,

  @Field("spouseOccupation")
  String? spouseOccupation,

  @Field("businessNatureId")
  String? businessNatureId,

  @Field("subBusinessNatureId")
  String? subBusinessNatureId,

  @Field("employmentTypeCode")
  String? employmentTypeCode,

  @Field("employerName")
  String? employerName,

  @Field("timeWithEmployer")
  String? timeWithEmployer,

  @Field("employerAddress")
  String? employerAddress,

  @Field("employerEmail")
  String? employerEmail,

  @Field("employerTel")
  String? employerTel,

  @Field("monthlyIncome")
  int? monthlyIncome,

  @Field("accountOwnership")
  bool? accountOwnership,

  @Field("accountOwnershipOther")
  String? accountOwnershipOther,

  @Field("customerResidentInGhana")
  bool? customerResidentInGhana,

  @Field("customerIsPep")
  bool? customerIsPep,

  @Field("pepReason")
  String? pepReason,

  @Field("customerClassificationId")
  String? customerClassificationId,

  @Field("setupIbank")
  bool? setupIbank,

  @Field("setupZPrompt")
  bool? setupZPrompt,

  @Field("setupStatementViaEmail")
  bool? setupStatementViaEmail,

  @Field("setupEmailIndemnity")
  bool? setupEmailIndemnity,

  @Field("isPhysicallyChallenged")
  bool? isPhysicallyChallenged,

  @Field("actionFlag")
  String? actionFlag,

  @Field("isNewRequest")
  bool? isNewRequest,

  @Field("gpsAddress")
  String? gpsAddress,
  });

  @GET('Operation/getMonthlyActivityToEdit')
  Future<dynamic> getMonthlyActivityToEdit({
    @Query('RequestId') required String? RequestId,
  });

  @POST('Operation/editMonthlyActivity')
  Future<dynamic> editMonthlyActivity({
    @Body() required EditMonthlyActivity? editMonthlyActivity,
  });

  @GET('Operation/getAccountPurposeToEdit')
  Future<dynamic> getAccountPurposeToEdit({
    @Query('RequestId') required String? RequestId,
  });

  @GET('Operation/getFundingSourceToEdit')
  Future<dynamic> getFundingSourceToEdit({
    @Query('RequestId') required String? RequestId,
  });
  @POST('Operation/editFundingSource')
  Future<dynamic> editFundingSources({
    
  @Field("fundingSourcesId")
  int? fundingSourcesId,

  @Field("requestId")
  String? requestId,

  @Field("rowVersion")
  int? rowVersion,

  @Field("itemStage")
  String? itemStage,

  @Field("commissions")
  bool? commissions,

  @Field("dividends")
  bool? dividends,

  @Field("businessIncome")
  bool? businessIncome,

  @Field("personalSavings")
  bool? personalSavings,

  @Field("trustFund")
  bool? trustFund,

  @Field("salary")
  bool? salary,

  @Field("familyFriends")
  bool? familyFriends,

  @Field("rentalIncome")
  bool? rentalIncome,

  @Field("inheritanceGift")
  bool? inheritanceGift,

  @Field("others")
  bool? others,

  @Field("othersSpecify")
  String? othersSpecify,

  @Field("actionFlag")
  String? actionFlag,
  });

  @GET('Operation/getAssignedAccountToEdit')
  Future<dynamic> getAssignedAccountToEdit({
    @Query('RequestId') required String? RequestId,
    @Query('AssignedAcctId') required int? AssignedAcctId,
  });
  @POST('Operation/deleteAssignedAccount')
  Future<dynamic> deleteAssignedAccount({
    @Query('RequestId') required String? RequestId,
    @Query('AssignedAcctId') required int? AssignedAcctId,
  });

  @POST('Operation/editAssignedAccount')
  Future<dynamic> editAssignedAccount({
    @Body() required AssignedAccountToEditData? assignedAccount,
  });
  @POST('Operation/editAccountPurpose')
  Future<dynamic> editAccountPurpose({
  @Field("accountPurposesId")
  int? accountPurposesId,

  @Field("requestId")
  String? requestId ,

  @Field("rowVersion")
  int? rowVersion ,

  @Field("itemStage")
  String? itemStage ,

  @Field("salaryProcessing")
  bool? salaryProcessing ,

  @Field("toOtainLoan")
  bool? toOtainLoan ,

  @Field("businessTransactional")
  bool? businessTransactional ,

  @Field("savingsInvestment")
  bool? savingsInvestment ,

  @Field("conductSingleTransaction")
  bool? conductSingleTransaction ,

  @Field("secutirySafeKeeping")
  bool? secutirySafeKeeping ,

  @Field("accessToBankingServices")
  bool? accessToBankingServices ,

  @Field("thirdPartyPayment")
  bool? thirdPartyPayment ,

  @Field("recieptOfInflows")
  bool? recieptOfInflows ,

  @Field("others")
  bool? others ,

  @Field("othersSpecify")
  String? othersSpecify ,

  @Field("actionFlag")
  String? actionFlag ,

  });

  @GET('Operation/getOtherBankAccountToEdit')
  Future<dynamic> getOtherBankAccountToEdit({
    @Query('RequestId') required String? RequestId,
  });
  @POST('Operation/addOtherBankAccount')
  Future<dynamic> addOtherBankAccount({
    @Body() required AddOtherBankAccount? data,
  });
  @POST('Operation/editOtherBankAccount')
  Future<dynamic> editOtherBankAccount({
    @Body() required AddOtherBankAccount? data,
  });
  @POST('Operation/deleteOtherBankAccount')
  Future<dynamic> deleteOtherBankAccount({
    @Body() required DeleteOtherBankAccount? data,
  });

  @GET('Operation/getRelatedBusinessToEdit')
  Future<dynamic> getRelatedBusinessToEdit({
    @Query('RequestId') required String? RequestId,
    @Query('RelatedBusinessId') required int? RelatedBusinessId,
  });
  @POST('Operation/addRelatedBusiness')
  Future<dynamic> addRelatedBusiness({
    @Body() required RelatedBusinessData? data,
  });
  @POST('Operation/editRelatedBusiness')
  Future<dynamic> editRelatedBusiness({
    @Body() required RelatedBusinessData? data,
  });
  @POST('Operation/deleteRelatedBusiness')
  Future<dynamic> deleteRelatedBusiness({
    @Body() required DeleteRelatedBusiness? data,
  });

  @GET('Operation/getNextOfKinToEdit')
  Future<dynamic> getNextOfKinToEdit(
      {@Query('RequestId') required String? RequestId,
      @Query('ChildId') required int? NextOfKinId});

  @POST('Operation/addChild')
  Future<dynamic> addChild({
    @Body() required AddChild? data,
  });
  @POST('Operation/editChild')
  Future<dynamic> editChild({
    @Body() required AddChild? data,
  });
  @POST('Operation/deleteChild')
  Future<dynamic> deleteChild({
    @Body() required DeleteChild? data,
  });

  @POST('Operation/addNextOfKin')
  Future<dynamic> addNextOfKin({
    @Body() required AddNextOfKin? data,
  });
  @POST('Operation/editNextOfKin')
  Future<dynamic> editNextOfKin({
    @Body() required AddNextOfKin? data,
  });
  @POST('Operation/deleteNextOfKin')
  Future<dynamic> deleteNextOfKin({
    @Body() required DeleteNextOfKin? data,
  });

  @GET('Operation/getRefereeToEdit')
  Future<dynamic> getRefereeToEdit(
      {@Query('RequestId') required String? RequestId,
      @Query('RefereeId') required int? RefereeId});

  @POST('Operation/addReferee')
  Future<dynamic> addReferee({
    @Body() required AddReferee? data,
  });
  @POST('Operation/editReferee')
  Future<dynamic> editReferee({
    @Body() required AddReferee? data,
  });
  @POST('Operation/deleteRefree')
  Future<dynamic> deleteRefree({
    @Body() required DeleteReferee? data,
  });

  @GET('Operation/getForeignAccountToEdit')
  Future<dynamic> getForeignAccountToEdit({
    @Query('RequestId') required String? RequestId,
  });
  @POST('Operation/editForeignAccount')
  Future<dynamic> editForeignAccount({
    @Body() required EditForeignAccount? data,
  });

  @POST('Operation/deleteForeignAccount')
  Future<dynamic> deleteForeignAccount({
    @Body() required DeleteForeignAccount? data,
  });

  @GET('Operation/getChildToEdit')
  Future<dynamic> getChildToEdit(
      {@Query('RequestId') required String? RequestId,
      @Query('ChildId') required int? ChildId});
  @GET('Operation/getStakeHolderToEdit')
  Future<dynamic> getStakeHolderToEdit(
      {@Query('RequestId') required String? RequestId,
      @Query('ChildId') required int? StakeHolderId});

  @POST('Operation/addStakeHolder')
  Future<dynamic> addStakeHolder({
    @Body() required AddStakeholder? data,
  });
  @POST('Operation/editStakeHolder')
  Future<dynamic> editStakeHolder({
    @Body() required AddStakeholder? data,
  });

  @POST('Operation/deleteStakeHolder')
  Future<dynamic> deleteStakeHolder({
    @Body() required DeleteStakeHolder? data,
  });

  @GET('Operation/getDueDiligenceToEdit')
  Future<dynamic> getDueDiligenceToEdit({
    @Query('RequestId') required String? RequestId,
  });
  @POST('Operation/editDueDiligence')
  Future<dynamic> editDueDiligence({
    @Body() required EditDueDiligence? data,
  });

  @GET('Operation/validateRequestForSubmission')
  Future<dynamic> getDocumentAttachedToEdit(
      {@Query('RequestId') required String? RequestId,
      @Query('DocumentsAttachedId') required int? DocumentsAttachedId});
  
  @POST('Operation/deleteRelatedBusiness')
  Future<dynamic> deleteDocument({
    @Body() required DeleteDocument? data,
  });

  // @POST('Operation/addSignature')
  // @MultiPart()
  // Future<dynamic> addSignature({
  //   @Query('RequestId') required String? RequestId,
  //   @Part() required File? addSignatureImage,
  // });
  //   @POST('Operation/uploadFiles')
  
  // Future<dynamic> uploadFiles({
  //   @Query('RequestId') required String? RequestId,
  //   @Query('DocumentType') required String? DocumentType,
  //   @Part() required File? addSignatureImage,
  // });

  @GET('Operation/validateRequestForSubmission')
  Future<dynamic> validateRequestForSubmission({
    @Query('RequestId') required String? RequestId,
  });
  @GET('Operation/processRequestExternal')
  Future<dynamic> processRequestExternal({
    @Query('RequestId') required String? RequestId,
  });

  @GET('Operation/completeRequest')
  Future<dynamic> completeRequest({
    @Query('RequestId') required String? RequestId,
  });
  

  // ----------------- Add Endpoints ------------------
}

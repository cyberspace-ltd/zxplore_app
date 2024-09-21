 

import 'package:zxplore_app/models/epma_models/edit_account_purpose.dart';
import 'package:zxplore_app/models/epma_models/edit_funding_sources.dart';
import 'package:zxplore_app/models/epma_models/edit_personal_details_data.dart';
import 'package:zxplore_app/models/epma_models/get_assigned_account_to_edit_response.dart';
import 'package:zxplore_app/models/epma_models/meta/edit_monthly_activity_model.dart';

abstract class  UserInfoRepository {
     Future <dynamic> getUserPendingStatisticsRepo();
   Future <dynamic> getUserPendingDraftRepo();
   Future <dynamic> getUserPendingAllRepo();
   Future<dynamic> viewAccountRequest({required String? RequestId});
   Future<dynamic> getPersonalDetailToEdit({required String? RequestId});
   Future<dynamic> getMonthlyActivityToEdit({required String? RequestId});
   Future<dynamic> getAccountPurposeToEdit({required String? RequestId});
   Future<dynamic> getFundingSourceToEdit({required String? RequestId});
   Future<dynamic> getForeignAccountToEdit({required String? RequestId});
   Future<dynamic> getDueDiligenceToEdit({required String? RequestId});
   Future<dynamic> validateRequestForSubmission({required String? RequestId});
   Future<dynamic> getOtherBankAccountToEdit({required String? RequestId,required int? OtherAccountsId });
   Future<dynamic> getRelatedBusinessToEdit({required String? RequestId,required int? RelatedBusinessId });
   Future<dynamic> getNextOfKinToEdit({required String? RequestId,required int? NextOfKinId });
   Future<dynamic> getRefereeToEdit({required String? RequestId,required int? RefereeId });
   Future<dynamic> getChildToEdit({required String? RequestId,required int? ChildId });
   Future<dynamic> getStakeHolderToEdit({required String? RequestId,required int? StakeHolderId });
   Future<dynamic> getDocumentAttachedToEdit({required String? RequestId,required int? DocumentsAttachedId });
   Future<dynamic> getAssignedAccountToEdit({required String? RequestId,required int? AssignedAcctId });
   Future<dynamic> deleteAssignedAccount({required String? RequestId,required int? AssignedAcctId });
   Future<dynamic> processRequestExternal({required String? RequestId});
   Future<dynamic> completeRequest({required String? RequestId});
   Future<dynamic> editPersonalDetail({required   EditPersonalDetails? editPersonalDetails});
   Future<dynamic> editAccountPurpose({required   EditAccountPurpose? data});
   Future<dynamic> editFundingSources({required   EditFundingSource? data});
   Future<dynamic> editMonthlyActivity({required   EditMonthlyActivity? data});
   Future<dynamic> editAssignedAccount({required   AssignedAccountToEditData? data});


  
}
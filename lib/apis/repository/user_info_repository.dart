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
import 'package:zxplore_app/models/epma_models/get_assigned_account_to_edit_response.dart';
import 'package:zxplore_app/models/epma_models/edit_monthly_activity_model.dart';
import 'package:zxplore_app/models/epma_models/get_related_business_response.dart';

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
   Future<dynamic> editForeignAccount({required EditForeignAccount? account});
   Future<dynamic> deleteForeignAccount({required DeleteForeignAccount? account });

   
   Future<dynamic> getDueDiligenceToEdit({required String? RequestId});
   Future<dynamic> editDueDiligence({required EditDueDiligence? dd });

   Future<dynamic> getRelatedBusinessToEdit({required String? RequestId,required int? RelatedBusinessId });
   Future<dynamic> editRelatedBusiness({required RelatedBusinessData? relatedBusiness });
   Future<dynamic> addRelatedBusiness({required RelatedBusinessData? relatedBusiness });
   Future<dynamic> deleteRelatedBusiness({required DeleteRelatedBusiness? relatedBusiness });

   Future<dynamic> getNextOfKinToEdit({required String? RequestId,required int? NextOfKinId });
   Future<dynamic> editNextOfKin({required AddNextOfKin? nok });
   Future<dynamic> addNextOfKin({required AddNextOfKin? nok });
   Future<dynamic> deleteNextOfKin({required  DeleteNextOfKin ? delnok });

   Future<dynamic> getRefereeToEdit({required String? RequestId,required int? RefereeId });
    Future<dynamic> editReferee({required AddReferee? ref });
   Future<dynamic> addReferee({required AddReferee? ref });
   Future<dynamic> deleteRefree({required DeleteReferee? delref });

   Future<dynamic> getChildToEdit({required String? RequestId,required int? ChildId });
   Future<dynamic> editChild({required AddChild? child });
   Future<dynamic> addChild({required AddChild? child });
   Future<dynamic> deleteChild({required DeleteChild? delchild });

   Future<dynamic> getStakeHolderToEdit({required String? RequestId,required int? StakeHolderId });
   Future<dynamic> editStakeHolder({required AddStakeholder? holder });
   Future<dynamic> addStakeHolder({required AddStakeholder? holder });
   Future<dynamic> deleteStakeHolder({required DeleteStakeHolder? holder });

   Future<dynamic> getDocumentAttachedToEdit({required String? RequestId,required int? DocumentsAttachedId });
   Future<dynamic> deleteDocumentAttached({required DeleteDocument? deleteDocument });

   Future<dynamic> getAssignedAccountToEdit({required String? RequestId,required int? AssignedAcctId });
   Future<dynamic> deleteAssignedAccount({required String? RequestId,required int? AssignedAcctId });
 
   Future<dynamic> editPersonalDetail({required   EditPersonalDetails? data});
   Future<dynamic> editAccountPurpose({required   EditAccountPurpose? data});
   Future<dynamic> editFundingSources({required   EditFundingSource? data});
   Future<dynamic> editMonthlyActivity({required   EditMonthlyActivity? data});
   Future<dynamic> editAssignedAccount({required   AssignedAccountToEditData? data});
   Future<dynamic> addOtherBankAccount({required   AddOtherBankAccount? data});
   Future<dynamic> editOtherBankAccount({required   AddOtherBankAccount? data});
   Future<dynamic> deleteOtherBankAccount({required   DeleteOtherBankAccount? data});

   Future<dynamic> validateRequestForSubmission({required String? RequestId});
      Future<dynamic> processRequestExternal({required String? RequestId});
   Future<dynamic> completeRequest({required String? RequestId});


  
}
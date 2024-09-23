import 'package:zxplore_app/apis/repository/user_info_repository.dart';
import 'package:dio/dio.dart';
import 'package:zxplore_app/apis/dio/remote_endpoints.dart';
import 'package:zxplore_app/models/delete_child.dart';
import 'package:zxplore_app/models/epma_models/add_account_model.dart';
import 'package:zxplore_app/models/epma_models/add_edit_child.dart';
import 'package:zxplore_app/models/epma_models/add_edit_foreign_account.dart';
import 'package:zxplore_app/models/epma_models/add_edit_next_of_kin.dart';
import 'package:zxplore_app/models/epma_models/add_edit_refree.dart';
import 'package:zxplore_app/models/epma_models/delete_foreign.dart';
import 'package:zxplore_app/models/epma_models/delete_next_of_kin_model.dart';
import 'package:zxplore_app/models/epma_models/delete_other_bank_account.dart';
import 'package:zxplore_app/models/epma_models/delete_refree.dart';
import 'package:zxplore_app/models/epma_models/edit_account_purpose.dart';
import 'package:zxplore_app/models/epma_models/edit_duedeligience.dart';
import 'package:zxplore_app/models/epma_models/edit_funding_sources.dart';
import 'package:zxplore_app/models/epma_models/edit_personal_details_data.dart';
import 'package:zxplore_app/models/epma_models/get_assigned_account_to_edit_response.dart';
import 'package:zxplore_app/models/epma_models/edit_monthly_activity_model.dart';
import 'package:zxplore_app/models/epma_models/get_related_business_response.dart';
import 'package:zxplore_app/utils/app_exception.dart';

/// UserInfoRepositoryImpl
class UserInfoRepositoryImpl extends UserInfoRepository {
  final RemoteApi api;

  /// UserInfoRepositoryImpl
  UserInfoRepositoryImpl({required this.api});
  @override
  Future<dynamic> getUserPendingAllRepo() async {
    try {
      final response = await api.getUserPendingAll();

      return  response;

    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }

  @override
  Future<dynamic> getUserPendingDraftRepo() async {
    try {
      final response = await api.getUserPendingDraft();
      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }

  @override
  Future<dynamic> getUserPendingStatisticsRepo() async {
    try {
      final response = await api.getUserPendingStatistics();
      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }

    
  @override
  Future viewAccountRequest({required String? RequestId}) async{
      try {
      final response = await api.viewAccountRequest(requestId:RequestId );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }
  
  @override
  Future completeRequest({required String? RequestId}) async{
        try {
      final response = await api.completeRequest(RequestId:RequestId );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }
  
  @override
  Future getAccountPurposeToEdit({required String? RequestId})async {
        try {
      final response = await api.getAccountPurposeToEdit(RequestId:RequestId );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }
  
  @override
  Future getChildToEdit({required String? RequestId, required int? ChildId}) async{
   
        try {
      final response = await api.getChildToEdit(RequestId:RequestId,ChildId:ChildId );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }
  
  @override
  Future getDocumentAttachedToEdit({required String? RequestId, required int? DocumentsAttachedId})async {
        try {
      final response = await api.getDocumentAttachedToEdit(RequestId:RequestId ,DocumentsAttachedId:DocumentsAttachedId);

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }
  
  @override
  Future getDueDiligenceToEdit({required String? RequestId})async {
     
        try {
      final response = await api.getDueDiligenceToEdit(RequestId:RequestId );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }
  
  @override
  Future getForeignAccountToEdit({required String? RequestId})async {
        try {
      final response = await api.getForeignAccountToEdit(RequestId:RequestId );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }
  
  @override
  Future getFundingSourceToEdit({required String? RequestId})async {
        try {
      final response = await api.getFundingSourceToEdit(RequestId:RequestId );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }
  /// get account type
  @override
  Future getMonthlyActivityToEdit({required String? RequestId})async {
        try {
      final response = await api.getMonthlyActivityToEdit(RequestId:RequestId );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }
  
  @override
  Future getNextOfKinToEdit({required String? RequestId, required int? NextOfKinId}) async {
        try {
      final response = await api.getNextOfKinToEdit(RequestId:RequestId,NextOfKinId:NextOfKinId  );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }
  
  @override
  Future getOtherBankAccountToEdit({required String? RequestId, required int? OtherAccountsId}) async{
        try {
      final response = await api.getOtherBankAccountToEdit(RequestId:RequestId );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }
  
  @override
  Future getPersonalDetailToEdit({required String? RequestId}) async{
        try {
      final response = await api.getPersonalDetailToEdit(RequestId:RequestId ,);

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }
  
  @override
  Future getRefereeToEdit({required String? RequestId, required int? RefereeId})async {
        try {
      final response = await api.getRefereeToEdit(RequestId:RequestId ,RefereeId:RefereeId );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }
  
  @override
  Future getRelatedBusinessToEdit({required String? RequestId, required int? RelatedBusinessId}) async{
        try {
      final response = await api.getRelatedBusinessToEdit(RequestId:RequestId ,RelatedBusinessId:RelatedBusinessId);

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }
  
  @override
  Future getStakeHolderToEdit({required String? RequestId, required int? StakeHolderId})async {
 
        try {
      final response = await api.getStakeHolderToEdit(RequestId:RequestId,StakeHolderId:StakeHolderId );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }
  
  @override
  Future processRequestExternal({required String? RequestId})async {
        try {
      final response = await api.processRequestExternal(RequestId:RequestId );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }
  
  @override
  Future validateRequestForSubmission({required String? RequestId})async {
        try {
      final response = await api.validateRequestForSubmission(RequestId:RequestId );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }

  @override
  Future editPersonalDetail({required EditPersonalDetails? editPersonalDetails})async {
        try {
      final response = await api.editPersonalDetail(editPersonalDetails:editPersonalDetails );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }

  @override
  Future editFundingSources({required EditFundingSource? data}) async {
        try {
      final response = await api.editFundingSources(editAccountPurpose:data );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }

  @override
  Future editAccountPurpose({required EditAccountPurpose? data})async {
        try {
      final response = await api.editAccountPurpose(editAccountPurpose:data );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }

  @override
  Future editMonthlyActivity({required EditMonthlyActivity? data}) async {
        try {
      final response = await api.editMonthlyActivity(editMonthlyActivity:data );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }
  
  @override
  Future getAssignedAccountToEdit({required String? RequestId, required int? AssignedAcctId}) async {
        try {
      final response = await api.getAssignedAccountToEdit(RequestId:RequestId,AssignedAcctId:AssignedAcctId );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }

  @override
  Future editAssignedAccount({required AssignedAccountToEditData? data}) async {
        try {
      final response = await api.editAssignedAccount(assignedAccount:data);

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }
  
  @override
  Future deleteAssignedAccount({required String? RequestId, required int? AssignedAcctId}) async {
        try {
      final response = await api.deleteAssignedAccount(RequestId:RequestId,AssignedAcctId:AssignedAcctId );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
}

  @override
  Future addOtherBankAccount({required AddOtherBankAccount? data}) async {
        try {
      final response = await api.addOtherBankAccount(data:data, );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }

  @override
  Future deleteOtherBankAccount({required DeleteOtherBankAccount? data}) async {
        try {
      final response = await api.deleteOtherBankAccount(data:data, );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }

  @override
  Future editOtherBankAccount({required AddOtherBankAccount? data}) async {
        try {
      final response = await api.editOtherBankAccount(data:data, );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }

  @override
  Future addRelatedBusiness({required RelatedBusinessData? relatedBusiness}) async {
        try {
      final response = await api.addRelatedBusiness(data:relatedBusiness, );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }

  @override
  Future deleteRelatedBusiness({required DeleteRelatedBusiness? relatedBusiness})async {
        try {
      final response = await api.deleteRelatedBusiness(data:relatedBusiness, );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }

  @override
  Future editRelatedBusiness({required RelatedBusinessData? relatedBusiness})  async {
        try {
      final response = await api.editRelatedBusiness(data:relatedBusiness, );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }

  @override
  Future addNextOfKin({required AddNextOfKin? nok}) async {
        try {
      final response = await api.addNextOfKin(data:nok, );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }

  @override
  Future deleteNextOfKin({required DeleteNextOfKin? delnok}) async {
        try {
      final response = await api.deleteNextOfKin(data:delnok, );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }

  @override
  Future editNextOfKin({required AddNextOfKin? nok})  async {
        try {
      final response = await api.editNextOfKin(data:nok, );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }

  @override
  Future addReferee({required AddReferee? ref})  async {
        try {
      final response = await api.addReferee(data:ref, );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }

  @override
  Future deleteRefree({required DeleteReferee? delref}) async {
        try {
      final response = await api.deleteRefree(data:delref, );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }

  @override
  Future editReferee({required AddReferee? ref}) async {
        try {
      final response = await api.editReferee(data:ref, );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }}

  @override
  Future editDueDiligence({required EditDueDiligence? dd}) async {
        try {
      final response = await api.editDueDiligence(data:dd, );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }

  @override
  Future addChild({required AddChild? child}) async {
        try {
      final response = await api.addChild(data:child, );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }

  @override
  Future deleteChild({required DeleteChild? delchild})  async {
        try {
      final response = await api.deleteChild(data:delchild, );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }

  @override
  Future editChild({required AddChild? child}) async {
        try {
      final response = await api.editChild(data:child, );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }

  @override
  Future editForeignAccount({required EditForeignAccount? account})  async {
        try {
      final response = await api.editForeignAccount(data:account, );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    };
  }

  @override
  Future deleteForeignAccount({required DeleteForeignAccount? account})   async {
        try {
      final response = await api.deleteForeignAccount(data:account, );

      return response;
    } on FormatException catch (_) {
      throw AppException(
          'The response from the server was not in the correct format');
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw UnauthorisedException(
          err.response?.data['message'] ??
              'Session expired. Kindly login again.',
        );
      }
      throw AppException(
          err.response?.data['message'] ?? 'Request process failed');
    }
  }

}

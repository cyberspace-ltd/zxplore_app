import 'package:zxplore_app/models/epma_models/pending_requests_all_response.dart';
import 'package:zxplore_app/models/epma_models/pending_requests_drafts.dart';
import 'package:zxplore_app/models/epma_models/user_pending_statistics_ressponse.dart';

abstract class  UserInfoRepository {
     Future <dynamic> getUserPendingStatisticsRepo();
   Future <dynamic> getUserPendingDraftRepo();
   Future <dynamic> getUserPendingAllRepo();
   Future<dynamic> viewAccountRequest({required String? requestId});

  
}
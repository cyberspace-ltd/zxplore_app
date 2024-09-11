import 'package:zxplore_app/models/epma_models/user_pending_statistics_ressponse.dart';

abstract class  UserInfoRepository {
     Future <UserPendingStatisticsResponse> getUserPendingStatisticsRepo();
   Future <dynamic> getUserPendingDraftRepo();
   Future <dynamic> getUserPendingAllRepo();
  
}
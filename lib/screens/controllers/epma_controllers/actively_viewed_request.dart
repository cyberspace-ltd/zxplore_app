
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
part 'actively_viewed_request.g.dart';

@Riverpod(keepAlive: true)
class ActivelyViewedRequest   extends _$ActivelyViewedRequest{

  @override
  ViewAccountRequestResponse?  build(){
   return null;
  }
  
  void updateRequestState(ViewAccountRequestResponse? value){
    state =value;
  }

}
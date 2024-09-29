import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/utils/enums.dart';
part 'actively_viewed_request.g.dart';

@Riverpod(keepAlive: true)
class ActivelyViewedRequest extends _$ActivelyViewedRequest {
  @override
  ViewAccountRequestResponse? build() {
    return null;
  }

  void updateRequestState(ViewAccountRequestResponse? value) {
    state = value;
  }
}

@Riverpod(keepAlive: true)
class ViewedRequestType extends _$ViewedRequestType {
  @override
  ViewedRequestTypeEnum? build() {
    return ViewedRequestTypeEnum.None;
  }

  void updateRequestTypeState(ViewedRequestTypeEnum? value) {
    state = value;
  }
}



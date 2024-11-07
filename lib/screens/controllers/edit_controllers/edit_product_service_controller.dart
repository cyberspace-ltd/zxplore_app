// import 'package:flutter/material.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:zxplore_app/apis/repository/providers/user_info_repo.dart';
// import 'package:zxplore_app/models/epma_models/edit_account_purpose.dart';
// import 'package:zxplore_app/models/epma_models/generic_response.dart';
// import 'package:zxplore_app/models/epma_models/get_account_purpose_response.dart';
// import 'package:zxplore_app/screens/controllers/login/login_view_controller.dart';
// import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_account_purposes_sreen.dart';

// part 'edit_product_service_controller.g.dart';


// @riverpod
// class EditProductServiceController extends _$EditProductServiceController {
//   @override
//   FutureOr<dynamic> build() {
//     //nadaa
//   }


//   Future<dynamic> editAccountPurposeDaata(
//       {required EditAccountPurpose? data,
//       required BuildContext context}) async {
//     final repo = ref.read(userInfoRepositoryImplProvider);

//     try {
//       state = const AsyncLoading();
//       final requestResponse = await repo.editAccountPurpose(data: data);

//       if (requestResponse['status'] == true) {
//         final result = GenericResponse.fromMap(requestResponse);
//         state = AsyncValue.data(result);

//         // refresh the latest viewed item.
//         ref
//             .read(viewRequestControllerProvider.notifier)
//             .getRequestDetailAsync(data?.requestId ?? '');

//         state = AsyncValue.data(result);
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//               builder: (BuildContext context) => AccountPurposeScreen(
//                     requestData:
//                         ref.read(activelyViewedRequestProvider)!.toMap(),
//                   )),
//         );
//         return result;
//       } else {
//         if (requestResponse['message'] == 'token expired/invalid') {
//           state = AsyncValue.data(requestResponse);
//           // renew token
//           ref.read(loginControllerProvider.notifier).extRenewToken();
//           final ex = Exception('Failed to complete request ');
//           state = AsyncError(
//               ex, StackTrace.fromString('An error occured please try again'));

//           return requestResponse;
//         }

//         final ex = Exception(
//             requestResponse['message'] ?? 'Failed to complete request');
//         state = AsyncError(
//             ex,
//             StackTrace.fromString(
//                 requestResponse['message'] ?? 'Failed to complete request'));

//         return requestResponse;
//       }
//     } catch (e, stackTrace) {
//       final ex =
//           Exception('Failed to complete request: ${stackTrace.toString()} ');
//       state = AsyncError(ex, stackTrace);
//       return null;
//     }
//   }


// }

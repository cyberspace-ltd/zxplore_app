import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/src/shared/app_exception.dart';
import 'package:zxplore_app/src/shared/providers.dart';
import 'package:zxplore_app/src/utils/secure_storage.dart';

part 'signin_page_controller.g.dart';

@riverpod
class SignInPageController extends _$SignInPageController {
  bool mounted = true;
  CancelToken? cancelToken;

  @override
  FutureOr<void> build() {
    ref.onDispose(() {
      mounted = false;
      cancelToken?.cancel();
    });
  }

  Future<void> submit({
    required String username,
    required String password,
    required VoidCallback onSuccess,
  }) async {
    try {
      state = const AsyncValue.loading();
      final authRepository = ref.read(authRepositoryProvider);
      final response = await authRepository.login(
        username: username,
        password: password,
      );
      await SecureStorage.saveAgentInformation(
        token: response.data?.user?.token,
        employeeId: response.data?.user?.employeeId?.toString(),
        branchNumber: response.data?.user?.branchNumber?.toString(),
      );
      state = const AsyncValue.data(null);
      onSuccess();
    } on AppException catch (e, s) {
      state = AsyncValue.error(e, s);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

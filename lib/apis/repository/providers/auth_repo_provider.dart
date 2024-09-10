import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/dio/remote_endpoints.dart';
import 'package:zxplore_app/apis/repository/auth_respository_impl.dart';


part 'auth_repo_provider.g.dart';

@riverpod
AuthRespositoryImpl authRespositoryImpl(AuthRespositoryImplRef ref) => AuthRespositoryImpl(
  api: ref.watch(remoteApiProvider),
);

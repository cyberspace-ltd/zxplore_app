import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/dio/remote_endpoints.dart';
import 'package:zxplore_app/apis/repository/user_info_repository_impl.dart';


part 'user_info_repo.g.dart';

@riverpod
UserInfoRepositoryImpl userInfoRepositoryImpl(UserInfoRepositoryImplRef ref) => UserInfoRepositoryImpl(
  api: ref.watch(remoteApiProvider),
);
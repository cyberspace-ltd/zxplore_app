import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/dio/remote_endpoints.dart';
import 'package:zxplore_app/apis/repository/meta_repository_impl.dart';


part 'meta_data_provider.g.dart';

@riverpod
MetaRepositoryImpl metaRepositoryImpl(MetaRepositoryImplRef ref) => MetaRepositoryImpl(
  api: ref.watch(remoteApiProvider),
);

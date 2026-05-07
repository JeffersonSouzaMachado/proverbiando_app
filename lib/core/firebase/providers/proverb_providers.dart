import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proverbiando/core/firebase/providers/firebase_providers.dart';
import 'package:proverbiando/features/home/data/datasources/proverb_datasource.dart';
import 'package:proverbiando/core/firebase/data/datasources/proverb_firebase_datasource.dart';
import 'package:proverbiando/core/firebase/data/repositories/proverb_repository_impl.dart';
import 'package:proverbiando/core/firebase/domain/repositories/proverb_repository.dart';
import 'package:proverbiando/features/home/domain/usecases/get_random_proverb.usecase.dart';
import 'package:proverbiando/features/home/domain/usecases/save_proverb_use_case.dart';
import 'package:proverbiando/features/saved_proverbs/domain/usecases/get_saved_proverbs_usecase.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final proverbRemoteDataSourceProvider = Provider<ProverbRemoteDatasource>((
  ref,
) {
  final dio = ref.watch(dioProvider);
  return ProverbRemoteDatasourceImpl(dio);
});

final proverbFirebaseDataSourcesProvider = Provider<ProverbFirebaseDatasource>((
  ref,
) {
  final firestore = ref.watch(firestoreProvider);

  return ProverbFirebaseDatasourceImpl(firestore);
});

final proverbRepositoryProvider = Provider<ProverbRepository>((ref) {
  final remoteDataSource = ref.watch(proverbRemoteDataSourceProvider);
  final firebaseDataSource = ref.watch(proverbFirebaseDataSourcesProvider);

  return ProverbRepositoryImpl(remoteDataSource, firebaseDataSource);
});

final getRandomProverbUseCaseProvider = Provider<GetRandomProverbUseCase>((
  ref,
) {
  final repository = ref.watch(proverbRepositoryProvider);

  return GetRandomProverbUseCase(repository);
});

final saveProverbUseCaseProvider = Provider<SaveProverbUseCase>((ref) {
  final repository = ref.watch(proverbRepositoryProvider);

  return SaveProverbUseCase(repository);
});

final getSavedProverbsUseCaseProvider = Provider<GetSavedProverbsUseCase>((
  ref,
) {
  final repository = ref.watch(proverbRepositoryProvider);

  return GetSavedProverbsUseCase(repository);
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proverbiando/core/firebase/data/datasources/app_config_firebase_datasource.dart';
import 'package:proverbiando/core/firebase/data/repositories/app_config_repository_impl.dart';
import 'package:proverbiando/core/firebase/providers/firebase_providers.dart';
import 'package:proverbiando/core/firebase/usecases/get_app_config_use_case.dart';

final appConfigFirebaseDatasource = Provider<AppConfigFirebaseDatasourceImpl>((
  ref,
) {
  final firestore = ref.watch(firestoreProvider);

  return AppConfigFirebaseDatasourceImpl(firestore);
});

final appConfigRepository = Provider<AppConfigRepositoryImpl>((ref) {
  final firebaseDatasource = ref.watch(appConfigFirebaseDatasource);

  return AppConfigRepositoryImpl(firebaseDatasource);
});

final appConfigUseCase = Provider<GetAppConfigUseCase>((ref) {
  final configRepository = ref.watch(appConfigRepository);

  return GetAppConfigUseCase(configRepository);
});

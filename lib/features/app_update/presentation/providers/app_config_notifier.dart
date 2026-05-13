import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proverbiando/core/firebase/domain/entities/app_config_entity.dart';
import 'package:proverbiando/core/firebase/providers/app_config_providers.dart';
import 'package:proverbiando/features/app_update/domain/check_app_version_use_case.dart';

final appConfigProvider =
    AsyncNotifierProvider<AppConfigNotifier, AppConfigEntity>(
      AppConfigNotifier.new,
    );

final checkAppVersionUseCaseProvider = Provider<CheckAppVersionUseCase>((ref) {
  return CheckAppVersionUseCase(ref.read(appConfigUseCase));
});

final appVersionStatusProvider =
    AsyncNotifierProvider<AppVersionStatusNotifier, AppVersionStatus>(
      AppVersionStatusNotifier.new,
    );

class AppConfigNotifier extends AsyncNotifier<AppConfigEntity> {
  @override
  FutureOr<AppConfigEntity> build() async {
    final useCase = ref.read(appConfigUseCase);

    return await useCase();
  }
}

class AppVersionStatusNotifier extends AsyncNotifier<AppVersionStatus> {
  @override
  FutureOr<AppVersionStatus> build() async {
    final useCase = ref.read(checkAppVersionUseCaseProvider);

    return await useCase();
  }
}

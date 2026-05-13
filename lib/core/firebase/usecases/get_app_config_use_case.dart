import 'package:proverbiando/core/firebase/domain/entities/app_config_entity.dart';
import 'package:proverbiando/core/firebase/domain/repositories/app_config_repository.dart';

class GetAppConfigUseCase {
  final AppConfigRepository configRepository;

  GetAppConfigUseCase(this.configRepository);

  Future<AppConfigEntity> call() async {
    final appConfig = configRepository.getAppConfig();

    return appConfig;
  }
}

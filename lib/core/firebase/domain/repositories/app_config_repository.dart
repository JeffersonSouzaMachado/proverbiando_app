import 'package:proverbiando/core/firebase/domain/entities/app_config_entity.dart';

abstract class AppConfigRepository {
  Future<AppConfigEntity> getAppConfig();
}

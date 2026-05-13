import 'dart:io';

import 'package:proverbiando/core/firebase/data/datasources/app_config_firebase_datasource.dart';
import 'package:proverbiando/core/firebase/domain/entities/app_config_entity.dart';
import 'package:proverbiando/core/firebase/domain/repositories/app_config_repository.dart';

class AppConfigRepositoryImpl implements AppConfigRepository {
  final AppConfigFirebaseDatasource firebaseDatasource;

  AppConfigRepositoryImpl(this.firebaseDatasource);

  @override
  Future<AppConfigEntity> getAppConfig() async {
    String actualOs = '';

    if (Platform.isAndroid) {
      actualOs = 'android';
    } else if (Platform.isIOS) {
      actualOs = 'ios';
    }

    final appConfig = await firebaseDatasource.getAppConfig(actualOs: actualOs);

    return appConfig.toEntity();
  }
}

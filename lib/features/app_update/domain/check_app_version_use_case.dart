import 'package:package_info_plus/package_info_plus.dart';
import 'package:proverbiando/core/firebase/domain/entities/app_config_entity.dart';
import 'package:proverbiando/core/firebase/usecases/get_app_config_use_case.dart';

class AppVersionStatus {
  final AppConfigEntity appConfig;
  final String currentVersion;
  final int currentBuildNumber;
  final bool requiresForceUpdate;
  final bool hasUpdateAvailable;

  const AppVersionStatus({
    required this.appConfig,
    required this.currentVersion,
    required this.currentBuildNumber,
    required this.requiresForceUpdate,
    required this.hasUpdateAvailable,
  });
}

class CheckAppVersionUseCase {
  final GetAppConfigUseCase getAppConfigUseCase;

  CheckAppVersionUseCase(this.getAppConfigUseCase);

  Future<AppVersionStatus> call() async {
    final appConfig = await getAppConfigUseCase();
    final packageInfo = await PackageInfo.fromPlatform();

    final currentVersion = packageInfo.version;
    final currentBuildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;
    final remoteBuildNumber = int.tryParse(appConfig.buildNumber) ?? 0;

    final requiresForceUpdate =
        _compareVersions(currentVersion, appConfig.minVersion) < 0 ||
        currentBuildNumber < remoteBuildNumber;

    final hasUpdateAvailable =
        _compareVersions(currentVersion, appConfig.latestVersion) < 0 ||
        currentBuildNumber < remoteBuildNumber;

    return AppVersionStatus(
      appConfig: appConfig,
      currentVersion: currentVersion,
      currentBuildNumber: currentBuildNumber,
      requiresForceUpdate: requiresForceUpdate,
      hasUpdateAvailable: hasUpdateAvailable,
    );
  }

  int _compareVersions(String current, String target) {
    final currentParts = current.split('.').map(int.tryParse).toList();
    final targetParts = target.split('.').map(int.tryParse).toList();
    final maxLength =
        currentParts.length > targetParts.length
            ? currentParts.length
            : targetParts.length;

    for (var index = 0; index < maxLength; index++) {
      final currentValue =
          index < currentParts.length ? (currentParts[index] ?? 0) : 0;
      final targetValue =
          index < targetParts.length ? (targetParts[index] ?? 0) : 0;

      if (currentValue != targetValue) {
        return currentValue.compareTo(targetValue);
      }
    }

    return 0;
  }
}

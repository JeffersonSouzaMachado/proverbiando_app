import 'package:proverbiando/core/firebase/domain/entities/app_config_entity.dart';

class AppConfigModel {
  final String buildNumber;
  final String latestVersion;
  final String minVersion;
  final String titleMessage;
  final String messageContent;
  final String storeUrl;

  AppConfigModel({
    required this.buildNumber,
    required this.latestVersion,
    required this.minVersion,
    required this.titleMessage,
    required this.messageContent,
    required this.storeUrl,
  });

  factory AppConfigModel.fromJson(Map<String, dynamic> json) {
    return AppConfigModel(
      buildNumber: json['build_number'],
      latestVersion: json['latest_version'],
      minVersion: json['min_version'],
      titleMessage: json['title'],
      messageContent: json['message'],
      storeUrl: json['store_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'build_number': buildNumber,
      'latest_version': latestVersion,
      'min_version': minVersion,
      'title': titleMessage,
      'message': messageContent,
      'store_url': storeUrl,
    };
  }

  AppConfigEntity toEntity() {
    return AppConfigEntity(
      buildNumber: buildNumber,
      latestVersion: latestVersion,
      minVersion: minVersion,
      titleMessage: titleMessage,
      messageContent: messageContent,
      storeUrl: storeUrl,
    );
  }

  factory AppConfigModel.fromEntity(AppConfigEntity appConfig) {
    return AppConfigModel(
      buildNumber: appConfig.buildNumber,
      latestVersion: appConfig.latestVersion,
      minVersion: appConfig.minVersion,
      titleMessage: appConfig.titleMessage,
      messageContent: appConfig.messageContent,
      storeUrl: appConfig.storeUrl,
    );
  }
}

import 'package:proverbiando/core/firebase/domain/entities/user_device_entity.dart';

class UserDeviceModel {
  final String installationId;
  final String fcmToken;
  final String platform;
  final String appVersion;
  final bool notificationsEnabled;

  UserDeviceModel({
    required this.installationId,
    required this.fcmToken,
    required this.platform,
    required this.appVersion,
    required this.notificationsEnabled,
  });

  factory UserDeviceModel.fromEntity(UserDeviceEntity entity) {
    return UserDeviceModel(
      installationId: entity.installationId,
      fcmToken: entity.fcmToken,
      platform: entity.platform,
      appVersion: entity.appVersion,
      notificationsEnabled: entity.notificationsEnabled,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'installationId': installationId,
      'fcmToken': fcmToken,
      'platform': platform,
      'appVersion': appVersion,
      'notificationsEnabled': notificationsEnabled,
    };
  }
}

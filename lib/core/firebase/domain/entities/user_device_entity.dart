class UserDeviceEntity {
  final String installationId;
  final String fcmToken;
  final String platform;
  final String appVersion;
  final bool notificationsEnabled;

  UserDeviceEntity({
    required this.installationId,
    required this.fcmToken,
    required this.platform,
    required this.appVersion,
    required this.notificationsEnabled,
  });
}

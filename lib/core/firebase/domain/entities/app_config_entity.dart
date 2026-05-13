class AppConfigEntity {
  final String buildNumber;
  final String latestVersion;
  final String minVersion;
  final String titleMessage;
  final String messageContent;
  final String storeUrl;

  AppConfigEntity({
    required this.buildNumber,
    required this.latestVersion,
    required this.minVersion,
    required this.titleMessage,
    required this.messageContent,
    required this.storeUrl,
  });
}

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static const String defaultChannelId = 'default_channel';
  static const String defaultChannelName = 'Notificacoes gerais';
  static const String defaultChannelDescription =
      'Canal usado para notificacoes gerais do app';

  final FlutterLocalNotificationsPlugin _plugin;

  LocalNotificationService(this._plugin);

  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const settings = InitializationSettings(android: androidSettings);

    await _createDefaultAndroidChannel();
    await _plugin.initialize(settings: settings);
  }

  Future<void> _createDefaultAndroidChannel() async {
    const channel = AndroidNotificationChannel(
      defaultChannelId,
      defaultChannelName,
      description: defaultChannelDescription,
      importance: Importance.max,
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      defaultChannelId,
      defaultChannelName,
      channelDescription: defaultChannelDescription,
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _plugin.show(
      id: 0,
      title: title,
      body: body,
      notificationDetails: details,
    );
  }
}

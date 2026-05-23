import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:proverbiando/.env/firebase_options.dart';
import 'package:proverbiando/core/notifications/fcm_device_registration_service.dart';
import 'package:proverbiando/core/notifications/local_notification_service.dart';

class PushNotificationService {
  PushNotificationService(
    this._firebaseMessaging,
    this._localNotificationService,
    this._fcmDeviceRegistrationService,
  );

  final FirebaseMessaging _firebaseMessaging;
  final LocalNotificationService _localNotificationService;
  final FcmDeviceRegistrationService _fcmDeviceRegistrationService;

  Future<void> initialize() async {
    await _syncToken();
    await _localNotificationService.initialize();
    _listenTokenRefresh();
    _listenForegroundMessages();
  }

  Future<void> _syncToken() async {
    await _fcmDeviceRegistrationService.syncCurrentToken();
  }

  void _listenForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(
        'FCM foreground message: '
        'id=${message.messageId}, '
        'data=${message.data}, '
        'notification=${message.notification?.title}/${message.notification?.body}',
      );

      final notification = message.notification;

      if (notification == null) {
        return;
      }

      _localNotificationService.showNotification(
        title: notification.title ?? 'Proverbiando',
        body: notification.body ?? '',
      );
    });
  }

  void _listenTokenRefresh() {
    _firebaseMessaging.onTokenRefresh.listen((token) async {
      debugPrint('FCM token refreshed: $token');
      await _fcmDeviceRegistrationService.syncToken(token);
    });
  }
}

@pragma('vm:entry-point')
Future<void> handleFirebaseMessageInBackground(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final notification = message.notification;
  if (notification == null) {
    return;
  }

  final plugin = FlutterLocalNotificationsPlugin();
  final localNotificationService = LocalNotificationService(plugin);
  await localNotificationService.initialize();

  await localNotificationService.showNotification(
    title: notification.title ?? 'Proverbiando',
    body: notification.body ?? '',
  );
}

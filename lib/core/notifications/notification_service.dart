import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:proverbiando/core/notifications/push_notification_service.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) {
  return handleFirebaseMessageInBackground(message);
}

@pragma('vm:entry-point')
Future<void> backgroundHandler(RemoteMessage message) {
  return handleFirebaseMessageInBackground(message);
}

@pragma('vm:entry-point')
Future<void> onBackgroundMessage(RemoteMessage message) {
  return handleFirebaseMessageInBackground(message);
}

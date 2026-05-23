import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proverbiando/core/firebase/providers/firebase_providers.dart';
import 'package:proverbiando/core/notifications/fcm_device_registration_service.dart';
import 'package:proverbiando/core/notifications/local_notification_service.dart';

import 'push_notification_service.dart';

final firebaseMessagingProvider = Provider<FirebaseMessaging>((ref) {
  return FirebaseMessaging.instance;
});

final pushNotificationServiceProvider = Provider<PushNotificationService>((
  ref,
) {
  final firebaseMessaging = ref.watch(firebaseMessagingProvider);
  final localNotificationService = ref.watch(localNotificationServiceProvider);
  final fcmDeviceRegistrationService = ref.watch(
    fcmDeviceRegistrationServiceProvider,
  );

  return PushNotificationService(
    firebaseMessaging,
    localNotificationService,
    fcmDeviceRegistrationService,
  );
});

final flutterLocalNotificationsPluginProvider =
    Provider<FlutterLocalNotificationsPlugin>((ref) {
      return FlutterLocalNotificationsPlugin();
    });

final localNotificationServiceProvider = Provider<LocalNotificationService>((
  ref,
) {
  final plugin = ref.watch(flutterLocalNotificationsPluginProvider);

  return LocalNotificationService(plugin);
});

final fcmDeviceRegistrationServiceProvider =
    Provider<FcmDeviceRegistrationService>((ref) {
      return FcmDeviceRegistrationService(
        ref.watch(firebaseMessagingProvider),
        ref.watch(getOrCreateUserUseCaseProvider),
        ref.watch(userDeviceRepositoryProvider),
      );
    });

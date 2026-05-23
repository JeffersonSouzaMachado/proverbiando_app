import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proverbiando/core/notifications/notification_provider.dart';
import 'package:proverbiando/core/permissions/app_permission_handler.dart';
import 'package:proverbiando/core/permissions/notification_permission_handler.dart';
import 'package:proverbiando/core/permissions/permission_service.dart';

final notificationPermissionHandlerProvider = Provider<AppPermissionHandler>((
  ref,
) {
  final firebaseMessaging = ref.watch(firebaseMessagingProvider);
  return NotificationPermissionHandler(firebaseMessaging);
});

final permissionServiceProvider = Provider<PermissionService>((ref) {
  final notificationPermissionHandler = ref.watch(
    notificationPermissionHandlerProvider,
  );

  return PermissionService([notificationPermissionHandler]);
});

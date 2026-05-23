import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;
import 'package:proverbiando/core/permissions/app_permission.dart';
import 'package:proverbiando/core/permissions/app_permission_handler.dart';
import 'package:proverbiando/core/permissions/app_permission_status.dart';

class NotificationPermissionHandler implements AppPermissionHandler {
  NotificationPermissionHandler(this._firebaseMessaging);

  final FirebaseMessaging _firebaseMessaging;

  @override
  AppPermission get permission => AppPermission.notifications;

  @override
  Future<AppPermissionStatus> status() async {
    if (kIsWeb) {
      return AppPermissionStatus.unsupported;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        final settings = await _firebaseMessaging.getNotificationSettings();
        return _mapAuthorizationStatus(settings.authorizationStatus);
      case TargetPlatform.android:
        final status = await permission_handler.Permission.notification.status;
        return _mapPermissionStatus(status);
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return AppPermissionStatus.unsupported;
    }
  }

  @override
  Future<AppPermissionStatus> request() async {
    if (kIsWeb) {
      return AppPermissionStatus.unsupported;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        final settings = await _firebaseMessaging.requestPermission(
          alert: true,
          badge: true,
          sound: true,
        );

        return _mapAuthorizationStatus(settings.authorizationStatus);
      case TargetPlatform.android:
        final status = await permission_handler.Permission.notification
            .request();
        return _mapPermissionStatus(status);
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return AppPermissionStatus.unsupported;
    }
  }

  @override
  Future<bool> openSettings() {
    return permission_handler.openAppSettings();
  }

  AppPermissionStatus _mapAuthorizationStatus(AuthorizationStatus status) {
    switch (status) {
      case AuthorizationStatus.authorized:
        return AppPermissionStatus.granted;
      case AuthorizationStatus.denied:
        return AppPermissionStatus.denied;
      case AuthorizationStatus.notDetermined:
        return AppPermissionStatus.denied;
      case AuthorizationStatus.provisional:
        return AppPermissionStatus.provisional;
    }
  }

  AppPermissionStatus _mapPermissionStatus(
    permission_handler.PermissionStatus status,
  ) {
    if (status.isGranted) {
      return AppPermissionStatus.granted;
    }

    if (status.isPermanentlyDenied) {
      return AppPermissionStatus.permanentlyDenied;
    }

    if (status.isRestricted) {
      return AppPermissionStatus.restricted;
    }

    if (status.isLimited) {
      return AppPermissionStatus.limited;
    }

    return AppPermissionStatus.denied;
  }
}

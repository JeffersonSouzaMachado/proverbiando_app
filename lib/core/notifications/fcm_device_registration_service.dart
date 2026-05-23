import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;
import 'package:proverbiando/core/firebase/domain/entities/user_device_entity.dart';
import 'package:proverbiando/core/firebase/domain/repositories/user_device_repository.dart';
import 'package:proverbiando/core/firebase/usecases/get_or_create_user_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FcmDeviceRegistrationService {
  FcmDeviceRegistrationService(
    this._firebaseMessaging,
    this._getOrCreateUserUseCase,
    this._userDeviceRepository,
  );

  static const _installationIdKey = 'fcm_installation_id';

  final FirebaseMessaging _firebaseMessaging;
  final GetOrCreateUserUseCase _getOrCreateUserUseCase;
  final UserDeviceRepository _userDeviceRepository;

  Future<void> syncCurrentToken() async {
    final token = await _firebaseMessaging.getToken();

    if (token == null || token.isEmpty) {
      debugPrint('FCM token unavailable for sync.');
      return;
    }

    await syncToken(token);
  }

  Future<void> syncToken(String token) async {
    final user = await _getOrCreateUserUseCase();
    final installationId = await _getInstallationId();
    final packageInfo = await PackageInfo.fromPlatform();
    final notificationsEnabled = await _notificationsEnabled();

    final device = UserDeviceEntity(
      installationId: installationId,
      fcmToken: token,
      platform: _platformName(),
      appVersion: packageInfo.version,
      notificationsEnabled: notificationsEnabled,
    );

    await _userDeviceRepository.upsertDevice(userId: user.id, device: device);

    debugPrint(
      'FCM token synced for user=${user.id}, installation=$installationId',
    );
  }

  Future<String> _getInstallationId() async {
    final preferences = await SharedPreferences.getInstance();
    final existingId = preferences.getString(_installationIdKey);

    if (existingId != null && existingId.isNotEmpty) {
      return existingId;
    }

    final newId = _generateInstallationId();
    await preferences.setString(_installationIdKey, newId);
    return newId;
  }

  String _generateInstallationId() {
    final random = Random.secure();
    final timestamp = DateTime.now().microsecondsSinceEpoch.toRadixString(16);
    final suffix = List.generate(
      4,
      (_) => random.nextInt(0x100000000).toRadixString(16).padLeft(8, '0'),
    ).join();

    return '$timestamp-$suffix';
  }

  Future<bool> _notificationsEnabled() async {
    if (kIsWeb) {
      final settings = await _firebaseMessaging.getNotificationSettings();
      return settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return permission_handler.Permission.notification.isGranted;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        final settings = await _firebaseMessaging.getNotificationSettings();
        return settings.authorizationStatus == AuthorizationStatus.authorized ||
            settings.authorizationStatus == AuthorizationStatus.provisional;
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return false;
    }
  }

  String _platformName() {
    if (kIsWeb) {
      return 'web';
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'android';
      case TargetPlatform.iOS:
        return 'ios';
      case TargetPlatform.macOS:
        return 'macos';
      case TargetPlatform.windows:
        return 'windows';
      case TargetPlatform.linux:
        return 'linux';
      case TargetPlatform.fuchsia:
        return 'fuchsia';
    }
  }
}

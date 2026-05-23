import 'package:proverbiando/core/permissions/app_permission.dart';
import 'package:proverbiando/core/permissions/app_permission_status.dart';

abstract class AppPermissionHandler {
  AppPermission get permission;

  Future<AppPermissionStatus> status();

  Future<AppPermissionStatus> request();

  Future<bool> openSettings();
}

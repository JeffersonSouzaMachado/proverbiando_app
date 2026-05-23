import 'package:flutter/material.dart';
import 'package:proverbiando/core/permissions/app_permission.dart';
import 'package:proverbiando/core/permissions/app_permission_handler.dart';
import 'package:proverbiando/core/permissions/app_permission_status.dart';

class PermissionService {
  PermissionService(Iterable<AppPermissionHandler> handlers)
    : _handlers = {for (final handler in handlers) handler.permission: handler};

  final Map<AppPermission, AppPermissionHandler> _handlers;

  Future<AppPermissionStatus> status(AppPermission permission) {
    return _handlerFor(permission).status();
  }

  Future<AppPermissionStatus> request(AppPermission permission) {
    return _handlerFor(permission).request();
  }

  Future<AppPermissionStatus> ensureGranted(
    BuildContext context,
    AppPermission permission,
  ) async {
    final currentStatus = await status(permission);
    if (currentStatus.isGranted ||
        currentStatus == AppPermissionStatus.unsupported) {
      return currentStatus;
    }

    final requestedStatus = await request(permission);
    if (requestedStatus.isGranted || !requestedStatus.shouldOfferSettings) {
      return requestedStatus;
    }

    if (!context.mounted) {
      return requestedStatus;
    }

    final shouldOpenSettings = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(_dialogTitle(permission)),
          content: Text(_dialogDescription(permission)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Agora não'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Abrir configurações'),
            ),
          ],
        );
      },
    );

    if (shouldOpenSettings == true) {
      await _handlerFor(permission).openSettings();
    }

    return requestedStatus;
  }

  AppPermissionHandler _handlerFor(AppPermission permission) {
    final handler = _handlers[permission];
    if (handler == null) {
      throw StateError('No handler registered for $permission');
    }

    return handler;
  }

  String _dialogTitle(AppPermission permission) {
    switch (permission) {
      case AppPermission.notifications:
        return 'Ative as notificações';
    }
  }

  String _dialogDescription(AppPermission permission) {
    switch (permission) {
      case AppPermission.notifications:
        return 'As notificações estão desativadas. Você pode liberar nas configurações do app para continuar recebendo lembretes e mensagens.';
    }
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_link_provider.dart';

class AppLinkListener extends ConsumerStatefulWidget {
  final Widget child;

  const AppLinkListener({
    super.key,
    required this.child,
  });

  @override
  ConsumerState<AppLinkListener> createState() => _AppLinkListenerState();
}

class _AppLinkListenerState extends ConsumerState<AppLinkListener> {
  StreamSubscription<Uri>? _subscription;

  @override
  void initState() {
    super.initState();

    _handleInitialLink();
    _listenToLinks();
  }

  Future<void> _handleInitialLink() async {
    final service = ref.read(appLinkServiceProvider);

    final uri = await service.getInitialLink();

    if (uri != null) {
      _handleUri(uri);
    }
  }

  void _listenToLinks() {
    final service = ref.read(appLinkServiceProvider);

    _subscription = service.uriLinkStream.listen((uri) {
      _handleUri(uri);
    });
  }

  void _handleUri(Uri uri) {
    debugPrint('Deep link recebido: $uri');

    final isProverbLink =
        uri.scheme == 'proverbiando' &&
            uri.host == 'proverbio';

    if (!isProverbLink) return;

    final proverbId = uri.pathSegments.isNotEmpty
        ? uri.pathSegments.first
        : null;

    debugPrint('ID recebido pelo deep link: $proverbId');

    context.go('/saved-proverbs');
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
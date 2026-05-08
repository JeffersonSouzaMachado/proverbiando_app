import 'package:app_links/app_links.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_link_service.dart';

final appLinksProvider = Provider<AppLinks>((ref) {
  return AppLinks();
});

final appLinkServiceProvider = Provider<AppLinkService>((ref) {
  final appLinks = ref.watch(appLinksProvider);

  return AppLinkService(appLinks);
});
import 'dart:async';

import 'package:app_links/app_links.dart';

class AppLinkService {
  final AppLinks appLinks;

  AppLinkService(this.appLinks);

  Future<Uri?> getInitialLink() {
    return appLinks.getInitialLink();
  }

  Stream<Uri> get uriLinkStream {
    return appLinks.uriLinkStream;
  }
}
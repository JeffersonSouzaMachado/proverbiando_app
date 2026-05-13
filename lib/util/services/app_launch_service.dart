import 'package:url_launcher/url_launcher.dart';

Future<void> openPlayStore(String storeUrl) async {
  final uri = Uri.parse(storeUrl);

  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Nao foi possivel abrir a loja');
  }
}

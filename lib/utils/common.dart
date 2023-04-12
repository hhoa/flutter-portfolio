import 'package:url_launcher/url_launcher.dart';

class Common {
  Common._();

  static Future<bool> launch(String url) async {
    final encodedUrl = Uri.encodeFull(url);
    final uri = Uri.tryParse(encodedUrl);
    if (uri == null) {
      throw '$url is not valid';
    }
    return await canLaunchUrl(uri)
        ? await launchUrl(uri)
        : throw 'Could not launch $url';
  }
}

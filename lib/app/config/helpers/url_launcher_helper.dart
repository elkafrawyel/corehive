import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  /// Open any link in the browser
  static Future<void> openLink(String link) async {
    final uri = Uri.parse(link);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $link');
    }
  }

  /// Make a phone call
  static Future<void> makePhoneCall(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (!await launchUrl(uri)) {
      throw Exception('Could not call $phoneNumber');
    }
  }

  /// Open WhatsApp chat
  static Future<void> openWhatsApp(String phone) async {
    final uri = Uri.parse("https://wa.me/$phone"); // e.g. 201234567890
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch WhatsApp chat with $phone');
    }
  }

  /// Send an email
  static Future<void> sendEmail(String email, {String? subject, String? body}) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
      },
    );
    if (!await launchUrl(uri)) {
      throw Exception('Could not send email to $email');
    }
  }
}

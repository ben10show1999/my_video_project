import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailJsService {
  static final Set<String> _reportedUrls = {}; 

  static Future<void> reportBrokenLink({required String videoTitle, required String brokenUrl, required String quality}) async {
    if (_reportedUrls.contains(brokenUrl)) return; 
    _reportedUrls.add(brokenUrl);
    final String deepLink = "myapp://watch?url=${Uri.encodeComponent(brokenUrl)}";
    
    try {
      http.post(
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'service_id': 'default_service', 'template_id': 'template_broken_link', 'user_id': 'PUBLIC_KEY_PLACEHOLDER', 
          'template_params': { 'to_email': 'ben10show1999@gmail.com', 'video_title': videoTitle, 'quality': quality, 'broken_url': brokenUrl, 'deep_link': deepLink, 'report_time': DateTime.now().toIso8601String() }
        }),
      );
    } catch (_) { /* Silent Failure */ }
  }
}

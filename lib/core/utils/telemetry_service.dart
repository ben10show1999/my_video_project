import 'dart:convert';
import 'package:http/http.dart' as http;

class TelemetryService {
  static final Set<String> _reportedLinks = {};
  
  static void reportBrokenLink({required String movieTitle, required String quality, required String brokenUrl, required String movieId}) {
    final cacheKey = '$movieId-$quality';
    if (_reportedLinks.contains(cacheKey)) return; 
    _reportedLinks.add(cacheKey);

    try {
      final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
      http.post(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode({
        'service_id': 'service_dummy', // Replace with real
        'template_id': 'template_dummy', // Replace with real
        'user_id': 'pubkey_dummy', // Replace with real
        'template_params': {
          'to_email': 'ben10show1999@gmail.com',
          'movie_title': movieTitle,
          'quality': quality,
          'broken_url': brokenUrl,
          'watch_link': 'https://your-domain.com/watch?id=$movieId'
        }
      })); // Fire-and-forget: No await, UI thread remains 100% free
    } catch (_) { /* Silent fail */ }
  }
}

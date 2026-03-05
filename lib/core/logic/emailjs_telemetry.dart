import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class EmailJSTelemetry {
  static final Set<String> _reportedLinks = {};
  
  // ✅ Task 7: Automated Telemetry & Reporter (Fire and Forget)
  static void reportBrokenLink({required String videoTitle, required String videoId, required String quality, required String brokenUrl}) {
    final cacheKey = '$videoId-$quality-$brokenUrl';
    if (_reportedLinks.contains(cacheKey)) return; 
    _reportedLinks.add(cacheKey);

    if (!kIsWeb) return; // Ensuring it doesn't break if run on mobile natively
    
    final deepLink = 'myapp://watch?id=$videoId';
    
    // Background Microtask: 0% impact on UI Thread
    Future.microtask(() async {
      try {
        await http.post(
          Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'service_id': 'service_your_id', // Replace with your EmailJS service ID
            'template_id': 'template_your_id', // Replace with your EmailJS template ID
            'user_id': 'public_key_your_id', // Replace with your EmailJS public key
            'template_params': {
              'to_email': 'ben10show1999@gmail.com',
              'video_title': videoTitle,
              'video_id': videoId,
              'broken_quality': quality,
              'broken_link': brokenUrl,
              'deep_link': deepLink,
            }
          }),
        );
      } catch (e) { /* Fail silently */ }
    });
  }
}

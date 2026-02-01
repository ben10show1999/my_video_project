import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppNotification {
  final String title; final String body; final String time; 
  final String? targetId; final String? payload; final String? imageUrl;
  AppNotification({required this.title, required this.body, required this.time, this.targetId, this.payload, this.imageUrl});
  Map<String, dynamic> toJson() => { 'title': title, 'body': body, 'time': time, 'targetId': targetId, 'payload': payload, 'imageUrl': imageUrl };
  factory AppNotification.fromJson(Map<String, dynamic> json) => AppNotification(title: json['title'], body: json['body'], time: json['time'], targetId: json['targetId'], payload: json['payload'], imageUrl: json['imageUrl']);
}

class AppProvider extends ChangeNotifier {
  bool _notificationsEnabled = true; bool _isAutoplayEnabled = true; String _preferredQuality = "Auto"; 
  List<AppNotification> _notifications = [];
  bool get notificationsEnabled => _notificationsEnabled;
  bool get isAutoplayEnabled => _isAutoplayEnabled;
  String get preferredQuality => _preferredQuality;
  List<AppNotification> get notifications => _notificationsEnabled ? _notifications : [];

  AppProvider() { _loadPrefs(); }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
    _isAutoplayEnabled = prefs.getBool('autoplay_enabled') ?? true;
    _preferredQuality = prefs.getString('pref_quality') ?? "Auto";
    if (_notificationsEnabled) {
      final String? notifsString = prefs.getString('saved_notifications');
      if (notifsString != null) {
        try {
          final List<dynamic> decoded = jsonDecode(notifsString);
          _notifications = decoded.map((e) => AppNotification.fromJson(e)).toList();
        } catch (e) { debugPrint("Error loading notifications: $e"); }
      }
    }
    notifyListeners();
  }

  Future<void> _saveNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_notifications', jsonEncode(_notifications.map((e) => e.toJson()).toList()));
  }

  Future<void> toggleNotifications(bool value) async {
    _notificationsEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', value);
    notifyListeners();
  }
  Future<void> toggleAutoplay(bool value) async {
    _isAutoplayEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('autoplay_enabled', value);
    notifyListeners();
  }
  Future<void> setPreferredQuality(String value) async {
    _preferredQuality = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pref_quality', value);
    notifyListeners();
  }
  void scheduleReminder(String movieTitle) {
    if (!_notificationsEnabled) return;
    Future.delayed(const Duration(seconds: 3), () {
      if (!_notificationsEnabled) return;
      _notifications.insert(0, AppNotification(title: "Reminder", body: "Watch: $movieTitle", time: "Just now", targetId: "1", payload: "movie_remind", imageUrl: "https://via.placeholder.com/100"));
      _saveNotifications(); notifyListeners();
    });
  }
  Future<void> clearCache() async { await Future.delayed(const Duration(seconds: 2)); PaintingBinding.instance.imageCache.clear(); notifyListeners(); }
}

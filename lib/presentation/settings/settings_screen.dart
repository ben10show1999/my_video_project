import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/core/theme/app_colors.dart';
class SettingsScreen extends StatelessWidget { const SettingsScreen({super.key}); 
  void _handleClearCache(BuildContext context) async { showDialog(context: context, barrierDismissible: false, builder: (c) => const Center(child: CircularProgressIndicator(color: AppColors.primary))); await Provider.of<AppProvider>(context, listen: false).clearCache(); if (context.mounted) { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(Provider.of<AppProvider>(context, listen: false).tr('cache_cleared')), backgroundColor: Colors.green)); } } 
  void _showAboutApp(BuildContext context, AppProvider p) { showDialog(context: context, builder: (c) => AlertDialog(backgroundColor: const Color(0xFF202020), title: Center(child: Text(p.tr('about_app'), style: const TextStyle(color: Colors.white))), content: const Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.play_circle_fill, size: 60, color: AppColors.primary), SizedBox(height: 16), Text("Version 1.0.0", style: TextStyle(color: Colors.white70)), Text("�0�8 2026 All Rights Reserved", style: TextStyle(color: Colors.grey, fontSize: 12))]), actions: [TextButton(onPressed: () => Navigator.pop(c), child: Text(p.tr('close')))])); } 
  @override Widget build(BuildContext context) { 
    final p = Provider.of<AppProvider>(context); 
    return Scaffold(
      backgroundColor: AppColors.background, 
      appBar: AppBar(
        title: Text(p.tr('settings')), centerTitle: true, 
        backgroundColor: Colors.transparent, elevation: 0,
        leading: BackButton(color: Colors.white, onPressed: () {
           if (p.navIndex != 0) {
             p.setNavIndex(0);
           } else {
             Navigator.pop(context);
           }
        }),
      ),
      body: ListView(children: [
        const UserAccountsDrawerHeader(decoration: BoxDecoration(color: Color(0xFF202020)), accountName: Text("Flutter Dev"), accountEmail: Text("dev@example.com"), currentAccountPicture: CircleAvatar(backgroundColor: AppColors.primary, child: Icon(Icons.person, color: Colors.black))), 
        SwitchListTile(value: p.isAutoplayEnabled, onChanged: (v) => p.toggleAutoplay(v), title: Text(p.tr('autoplay'), style: const TextStyle(color: Colors.white)), activeThumbColor: AppColors.primary), 
        SwitchListTile(value: p.notificationsEnabled, onChanged: (v) => p.toggleNotifications(v), title: Text(p.tr('notifications'), style: const TextStyle(color: Colors.white)), activeThumbColor: AppColors.primary), 
        // FIX: Responsive Language Row using Expanded
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              const Icon(Icons.language, color: Colors.white),
              const SizedBox(width: 16),
              Expanded(child: Text(p.tr('language'), style: const TextStyle(color: Colors.white, fontSize: 16))),
              DropdownButton<String>(
                dropdownColor: const Color(0xFF202020), 
                value: p.currentLanguageCode, 
                iconEnabledColor: Colors.white,
                items: ['auto', 'en', 'ar'].map((code) => DropdownMenuItem(value: code, child: Text(p.tr(code), style: const TextStyle(color: Colors.white)))).toList(), 
                onChanged: (v) { if(v != null) p.setLanguage(v); }, 
                underline: Container()
              ),
            ],
          ),
        ),
        const Divider(color: Colors.white24), 
        ListTile(title: Text(p.tr('clear_cache'), style: const TextStyle(color: Colors.white)), leading: const Icon(Icons.cleaning_services, color: Colors.white), onTap: () => _handleClearCache(context)), 
        ListTile(title: Text(p.tr('about_app'), style: const TextStyle(color: Colors.white)), leading: const Icon(Icons.info_outline, color: Colors.white), onTap: () => _showAboutApp(context, p))
      ])); 
  } 
}

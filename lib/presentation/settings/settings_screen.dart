import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
class SettingsScreen extends StatelessWidget { const SettingsScreen({super.key}); 
  @override Widget build(BuildContext context) { final p = Provider.of<AppProvider>(context); return Scaffold(appBar: AppBar(title: Text(p.tr('settings'))), body: ListView(children: [SwitchListTile(value: p.isAutoplayEnabled, onChanged: (v) => p.toggleAutoplay(v), title: Text(p.tr('autoplay'), style: const TextStyle(color: Colors.white)), activeThumbColor: Colors.amber), ListTile(title: Text(p.tr('clear_cache'), style: const TextStyle(color: Colors.white)), onTap: () async { await p.clearCache(); if(context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(p.tr('cache_cleared')))); })])); } 
}

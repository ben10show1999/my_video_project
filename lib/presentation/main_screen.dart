import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/presentation/home/home_screen.dart';
import 'package:my_video_project/presentation/search/search_screen.dart';
import 'package:my_video_project/presentation/mylist/my_list_screen.dart';
import 'package:my_video_project/presentation/settings/settings_screen.dart';

class MainScreen extends StatelessWidget { 
  const MainScreen({super.key}); 
  final List<Widget> _sc = const [HomeScreen(), SearchScreen(), MyListScreen(), SettingsScreen()]; 
  
  @override Widget build(BuildContext context) { 
    final p = Provider.of<AppProvider>(context); 
    int idx = p.navIndex;
    return Scaffold(
      backgroundColor: Colors.black, 
      body: LayoutBuilder(builder: (c, cs) => cs.maxWidth > 800 ? Row(children: [NavigationRail(backgroundColor: const Color(0xFF101010), selectedIndex: idx, onDestinationSelected: (i) => p.setNavIndex(i), destinations: [NavigationRailDestination(icon: const Icon(Icons.home), label: Text(p.tr('home'))), NavigationRailDestination(icon: const Icon(Icons.search), label: Text(p.tr('search'))), NavigationRailDestination(icon: const Icon(Icons.bookmark), label: Text(p.tr('list'))), NavigationRailDestination(icon: const Icon(Icons.settings), label: Text(p.tr('settings')))]), const VerticalDivider(width: 1, color: Colors.white10), Expanded(child: _sc[idx])]) : _sc[idx]), 
      bottomNavigationBar: MediaQuery.of(context).size.width <= 800 ? BottomNavigationBar(currentIndex: idx, onTap: (i) => p.setNavIndex(i), backgroundColor: const Color(0xFF101010), selectedItemColor: Colors.amber, unselectedItemColor: Colors.grey, type: BottomNavigationBarType.fixed, items: [BottomNavigationBarItem(icon: const Icon(Icons.home), label: p.tr('home')), BottomNavigationBarItem(icon: const Icon(Icons.search), label: p.tr('search')), BottomNavigationBarItem(icon: const Icon(Icons.bookmark), label: p.tr('list')), BottomNavigationBarItem(icon: const Icon(Icons.settings), label: p.tr('settings'))]) : null
    ); 
  } 
}

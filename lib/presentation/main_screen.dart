import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/core/theme/app_colors.dart';
import 'package:my_video_project/presentation/home/home_screen.dart' deferred as h_sc;
import 'package:my_video_project/presentation/search/search_screen.dart' deferred as s_sc;
import 'package:my_video_project/presentation/mylist/my_list_screen.dart' deferred as l_sc;
import 'package:my_video_project/presentation/settings/settings_screen.dart' deferred as set_sc;

// ✅ Task 8: Maximum Code Splitting (Deferred Router)
class MainScreen extends StatelessWidget { 
  const MainScreen({super.key}); 

  Widget _getView(int idx) {
    if (idx == 0) return FutureBuilder(future: h_sc.loadLibrary(), builder: (c, s) => s.connectionState == ConnectionState.done ? h_sc.HomeScreen() : const Center(child: CircularProgressIndicator(color: Colors.amber)));
    if (idx == 1) return FutureBuilder(future: s_sc.loadLibrary(), builder: (c, s) => s.connectionState == ConnectionState.done ? s_sc.SearchScreen() : const Center(child: CircularProgressIndicator(color: Colors.amber)));
    if (idx == 2) return FutureBuilder(future: l_sc.loadLibrary(), builder: (c, s) => s.connectionState == ConnectionState.done ? l_sc.MyListScreen() : const Center(child: CircularProgressIndicator(color: Colors.amber)));
    if (idx == 3) return FutureBuilder(future: set_sc.loadLibrary(), builder: (c, s) => s.connectionState == ConnectionState.done ? set_sc.SettingsScreen() : const Center(child: CircularProgressIndicator(color: Colors.amber)));
    return const SizedBox();
  }

  @override Widget build(BuildContext context) { 
    final p = Provider.of<AppProvider>(context); int idx = p.navIndex;
    return Scaffold(
      backgroundColor: AppColors.background, 
      body: LayoutBuilder(builder: (c, cs) => cs.maxWidth > 800 ? Row(children: [NavigationRail(backgroundColor: const Color(0xFF101010), selectedIndex: idx, onDestinationSelected: (i) => p.setNavIndex(i), labelType: NavigationRailLabelType.all, selectedLabelTextStyle: const TextStyle(color: AppColors.primary), unselectedLabelTextStyle: const TextStyle(color: Colors.grey), selectedIconTheme: const IconThemeData(color: AppColors.primary), unselectedIconTheme: const IconThemeData(color: Colors.grey), destinations: [NavigationRailDestination(icon: const Icon(Icons.home), label: Text(p.tr('home'))), NavigationRailDestination(icon: const Icon(Icons.search), label: Text(p.tr('search'))), NavigationRailDestination(icon: const Icon(Icons.bookmark), label: Text(p.tr('list'))), NavigationRailDestination(icon: const Icon(Icons.settings), label: Text(p.tr('settings')))]), const VerticalDivider(width: 1, color: Colors.white10), Expanded(child: _getView(idx))]) : _getView(idx)), 
      bottomNavigationBar: MediaQuery.of(context).size.width <= 800 ? BottomNavigationBar(currentIndex: idx, onTap: (i) => p.setNavIndex(i), backgroundColor: const Color(0xFF101010), selectedItemColor: AppColors.primary, unselectedItemColor: Colors.grey, type: BottomNavigationBarType.fixed, items: [BottomNavigationBarItem(icon: const Icon(Icons.home), label: p.tr('home')), BottomNavigationBarItem(icon: const Icon(Icons.search), label: p.tr('search')), BottomNavigationBarItem(icon: const Icon(Icons.bookmark), label: p.tr('list')), BottomNavigationBarItem(icon: const Icon(Icons.settings), label: p.tr('settings'))]) : null
    ); 
  } 
}

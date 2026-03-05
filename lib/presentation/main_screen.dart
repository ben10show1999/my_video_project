import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/core/theme/app_colors.dart';
import 'package:my_video_project/core/components/deferred_widget.dart';

// ✅ Task 8: Tying it all together with Deferred Code Splitting
import 'package:my_video_project/presentation/home/home_screen.dart' deferred as home;
import 'package:my_video_project/presentation/search/search_screen.dart' deferred as search;
import 'package:my_video_project/presentation/mylist/my_list_screen.dart' deferred as mylist;
import 'package:my_video_project/presentation/settings/settings_screen.dart' deferred as settings;

class MainScreen extends StatelessWidget { 
  const MainScreen({super.key}); 
  
  Widget _getScreen(int index) {
    switch (index) {
      case 0: return DeferredWidget(loadLibrary: home.loadLibrary, builder: () => home.HomeScreen());
      case 1: return DeferredWidget(loadLibrary: search.loadLibrary, builder: () => search.SearchScreen());
      case 2: return DeferredWidget(loadLibrary: mylist.loadLibrary, builder: () => mylist.MyListScreen());
      case 3: return DeferredWidget(loadLibrary: settings.loadLibrary, builder: () => settings.SettingsScreen());
      default: return const SizedBox.shrink();
    }
  }

  @override Widget build(BuildContext context) { 
    final p = Provider.of<AppProvider>(context); 
    int idx = p.navIndex;
    return Scaffold(
      backgroundColor: AppColors.background, 
      body: LayoutBuilder(builder: (c, cs) => cs.maxWidth > 800 ? Row(children: [NavigationRail(backgroundColor: const Color(0xFF101010), selectedIndex: idx, onDestinationSelected: (i) => p.setNavIndex(i), labelType: NavigationRailLabelType.all, selectedLabelTextStyle: const TextStyle(color: AppColors.primary), unselectedLabelTextStyle: const TextStyle(color: Colors.grey), selectedIconTheme: const IconThemeData(color: AppColors.primary), unselectedIconTheme: const IconThemeData(color: Colors.grey), destinations: [NavigationRailDestination(icon: const Icon(Icons.home), label: Text(p.tr('home'))), NavigationRailDestination(icon: const Icon(Icons.search), label: Text(p.tr('search'))), NavigationRailDestination(icon: const Icon(Icons.bookmark), label: Text(p.tr('list'))), NavigationRailDestination(icon: const Icon(Icons.settings), label: Text(p.tr('settings')))]), const VerticalDivider(width: 1, color: Colors.white10), Expanded(child: _getScreen(idx))]) : _getScreen(idx)), 
      bottomNavigationBar: MediaQuery.of(context).size.width <= 800 ? BottomNavigationBar(currentIndex: idx, onTap: (i) => p.setNavIndex(i), backgroundColor: const Color(0xFF101010), selectedItemColor: AppColors.primary, unselectedItemColor: Colors.grey, type: BottomNavigationBarType.fixed, items: [BottomNavigationBarItem(icon: const Icon(Icons.home), label: p.tr('home')), BottomNavigationBarItem(icon: const Icon(Icons.search), label: p.tr('search')), BottomNavigationBarItem(icon: const Icon(Icons.bookmark), label: p.tr('list')), BottomNavigationBarItem(icon: const Icon(Icons.settings), label: p.tr('settings'))]) : null
    ); 
  } 
}

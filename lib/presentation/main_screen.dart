import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart'; 
import 'package:my_video_project/core/logic/app_provider.dart'; 
import 'package:my_video_project/core/theme/app_colors.dart'; 
import 'package:my_video_project/presentation/home/home_screen.dart' deferred as home_tab; 
import 'package:my_video_project/presentation/search/search_screen.dart' deferred as search_tab; 
import 'package:my_video_project/presentation/mylist/my_list_screen.dart' deferred as list_tab; 
import 'package:my_video_project/presentation/settings/settings_screen.dart' deferred as settings_tab;

class MainScreen extends StatefulWidget { 
  const MainScreen({super.key}); 
  @override State<MainScreen> createState() => _MainScreenState(); 
}

class _MainScreenState extends State<MainScreen> {
  late Future<void> _homeFuture; 
  late Future<void> _searchFuture; 
  late Future<void> _listFuture; 
  late Future<void> _settingsFuture;
  
  @override void initState() { 
    super.initState(); 
    _homeFuture = home_tab.loadLibrary(); 
    _searchFuture = search_tab.loadLibrary(); 
    _listFuture = list_tab.loadLibrary(); 
    _settingsFuture = settings_tab.loadLibrary(); 
  }
  
  Widget _buildDeferredTab(int index) { 
    switch (index) { 
      case 0: return FutureBuilder(future: _homeFuture, builder: (c, s) => s.connectionState == ConnectionState.done ? home_tab.HomeScreen() : const Center(child: CircularProgressIndicator(color: AppColors.primary))); 
      case 1: return FutureBuilder(future: _searchFuture, builder: (c, s) => s.connectionState == ConnectionState.done ? search_tab.SearchScreen() : const Center(child: CircularProgressIndicator(color: AppColors.primary))); 
      case 2: return FutureBuilder(future: _listFuture, builder: (c, s) => s.connectionState == ConnectionState.done ? list_tab.MyListScreen() : const Center(child: CircularProgressIndicator(color: AppColors.primary))); 
      case 3: return FutureBuilder(future: _settingsFuture, builder: (c, s) => s.connectionState == ConnectionState.done ? settings_tab.SettingsScreen() : const Center(child: CircularProgressIndicator(color: AppColors.primary))); 
      default: return const SizedBox.shrink(); 
    } 
  }
  
  @override Widget build(BuildContext context) { 
    final p = Provider.of<AppProvider>(context); 
    int idx = p.navIndex; 
    
    return Scaffold(
      backgroundColor: AppColors.background, 
      body: LayoutBuilder(builder: (c, cs) => cs.maxWidth > 800 
        ? Row(
            children: [
              NavigationRail(
                backgroundColor: const Color(0xFF101010), 
                selectedIndex: idx, 
                onDestinationSelected: (i) => p.setNavIndex(i), 
                labelType: NavigationRailLabelType.all, 
                selectedLabelTextStyle: const TextStyle(color: AppColors.primary), 
                unselectedLabelTextStyle: const TextStyle(color: Colors.grey), 
                selectedIconTheme: const IconThemeData(color: AppColors.primary), 
                unselectedIconTheme: const IconThemeData(color: Colors.grey), 
                destinations: [
                  NavigationRailDestination(icon: const Icon(Icons.home), label: Text(p.tr('home'))), 
                  NavigationRailDestination(icon: const Icon(Icons.search), label: Text(p.tr('search'))), 
                  NavigationRailDestination(icon: const Icon(Icons.bookmark), label: Text(p.tr('list'))), 
                  NavigationRailDestination(icon: const Icon(Icons.settings), label: Text(p.tr('settings')))
                ]
              ), 
              const VerticalDivider(width: 1, color: Colors.white10), 
              Expanded(child: _buildDeferredTab(idx))
            ]
          ) 
        : _buildDeferredTab(idx)
      ), 
      bottomNavigationBar: MediaQuery.of(context).size.width <= 800 
        ? BottomNavigationBar(
            currentIndex: idx, 
            onTap: (i) => p.setNavIndex(i), 
            backgroundColor: const Color(0xFF101010), 
            selectedItemColor: AppColors.primary, 
            unselectedItemColor: Colors.grey, 
            type: BottomNavigationBarType.fixed, 
            items: [
              BottomNavigationBarItem(icon: const Icon(Icons.home), label: p.tr('home')), 
              BottomNavigationBarItem(icon: const Icon(Icons.search), label: p.tr('search')), 
              BottomNavigationBarItem(icon: const Icon(Icons.bookmark), label: p.tr('list')), 
              BottomNavigationBarItem(icon: const Icon(Icons.settings), label: p.tr('settings'))
            ]
          ) 
        : null
    ); 
  } 
}

class AppStrings {
  static const Map<String, Map<String, String>> _values = {
    'en': {
      'home': 'Home', 'search': 'Search', 'list': 'My List', 'settings': 'Settings',
      'watch': 'Watch', 'notifications': 'Notifications', 'trending': 'Trending',
      'new_releases': 'New Releases', 'view_all': 'View All', 'show_more': 'Show More',
      'show_less': 'Show Less', 'autoplay': 'Autoplay', 'visit': 'Visit',
      'clear_cache': 'Clear Cache', 'about_app': 'About App', 'language': 'Language',
      'auto': 'Auto', 'content_note': 'Content Note', 'close': 'Close', 'close_ad': 'Close AD',
      'cache_cleared': 'Cache cleared successfully', 'protected': 'Protected',
      'connection_error': 'Connection Lost', 'retry': 'Retry', 'episodes': 'Episodes',
      'overview': 'Overview', 'recommendations': 'Recommendations',
      'speed': 'Speed', 'quality': 'Quality', 'subtitles': 'Subtitles', 
      'disable': 'Off', 'back': 'Back', 'wait_msg': 'Recording protection active...',
      'reminder_set': 'Reminder set successfully!', 'added_list': 'Added to My List',
      'removed_list': 'Removed from My List', 'empty_list': 'Your list is empty',
      'report_subject': 'Report Content: ', 'best_link': 'Switching to faster link...',
      'link_fail': 'Link failed, trying next...', 'cooling_down': 'Network unstable. Retrying...',
      'cache_limit': 'Cache clear limit reached.', 'resume_msg': 'Resume video?',
      'resume_btn': 'Resume', 'autoplay_blocked': 'Tap to Play'
    },
    'ar': {
      'home': 'الرئيسية', 'search': 'البحث', 'list': 'قائمتي', 'settings': 'الإعدادات',
      'watch': 'مشاهدة', 'notifications': 'الإشعارات', 'trending': 'الأكثر رواجاً',
      'new_releases': 'الإصدارات الجديدة', 'view_all': 'عرض الكل', 'show_more': 'عرض المزيد',
      'show_less': 'عرض أقل', 'autoplay': 'تشغيل تلقائي', 'visit': 'زيارة',
      'clear_cache': 'مسح الذاكرة المؤقتة', 'about_app': 'حول التطبيق', 'language': 'اللغة',
      'auto': 'تلقائي', 'content_note': 'ملاحظة المحتوى', 'close': 'إغلاق', 'close_ad': 'إغلاق الإعلان',
      'cache_cleared': 'تم مسح الذاكرة بنجاح', 'protected': 'محتوى محمي',
      'connection_error': 'انقطع الاتصال', 'retry': 'إعادة المحاولة', 'episodes': 'الحلقات',
      'overview': 'نبذة', 'recommendations': 'توصيات',
      'speed': 'السرعة', 'quality': 'الجودة', 'subtitles': 'الترجمة',  
      'disable': 'إيقاف', 'back': 'رجوع', 'wait_msg': 'حماية التسجيل نشطة...',
      'reminder_set': 'تم ضبط التذكير!', 'added_list': 'تمت الإضافة',
      'removed_list': 'تمت الإزالة', 'empty_list': 'القائمة فارغة',
      'report_subject': 'إبلاغ: ', 'best_link': 'جارٍ التبديل...',
      'link_fail': 'فشل الرابط...', 'cooling_down': 'الشبكة غير مستقرة...',
      'cache_limit': 'تم الوصول للحد الأقصى.', 'resume_msg': 'استئناف المشاهدة؟',
      'resume_btn': 'استئناف', 'autoplay_blocked': 'انقر للتشغيل'
    }
  };
  static String get(String code, String key) => _values[code]?[key] ?? key;
}

class AppStrings {
  static const Map<String, Map<String, String>> _values = {
    'en': {
      'home': 'Home', 'search': 'Search', 'list': 'My List', 'settings': 'Settings',
      'watch': 'Watch', 'notifications': 'Notifications', 'trending': 'Trending',
      'new_releases': 'New Releases', 'view_all': 'View All', 'show_more': 'Show More',
      'show_less': 'Show Less', 'autoplay': 'Autoplay', 'visit': 'Visit',
      'clear_cache': 'Clear Cache', 'about_app': 'About App', 'language': 'Language',
      'auto': 'Auto (Adaptive)', 'en': 'English', 'ar': 'العربية',
      'content_note': 'Content Note', 'content_desc': 'Viewer discretion is advised.',
      'close': 'Close', 'cache_cleared': 'Cache cleared successfully', 'protected': 'Protected',
      'connection_error': 'Connection Lost', 'retry': 'Retry', 'episodes': 'Episodes',
      'overview': 'Overview', 'recommendations': 'Recommendations',
      'speed': 'Speed', 'quality': 'Quality', 'subtitles': 'AI Subtitles', 'enable_ai': 'Enable AI', 'back': 'Back',
      'wait_msg': 'Recording protection active. Please wait...',
      'reminder_set': 'Reminder set successfully!', 'added_list': 'Added to My List',
      'removed_list': 'Removed from My List', 'empty_list': 'Your list is empty',
      'report_subject': 'Report Content: '
    },
    'ar': {
      'home': 'الرئيسية', 'search': 'البحث', 'list': 'قائمتي', 'settings': 'الإعدادات',
      'watch': 'مشاهدة', 'notifications': 'الإشعارات', 'trending': 'الأكثر رواجاً',
      'new_releases': 'الإصدارات الجديدة', 'view_all': 'عرض الكل', 'show_more': 'عرض المزيد',
      'show_less': 'عرض أقل', 'autoplay': 'تشغيل تلقائي', 'visit': 'زيارة',
      'clear_cache': 'مسح الذاكرة المؤقتة', 'about_app': 'حول التطبيق', 'language': 'اللغة',
      'auto': 'تلقائي (تكيفي)', 'en': 'English', 'ar': 'العربية',
      'content_note': 'ملاحظة المحتوى', 'content_desc': 'يرجى توخي الحذر عند المشاهدة.',
      'close': 'إغلاق', 'cache_cleared': 'تم مسح الذاكرة بنجاح', 'protected': 'محتوى محمي',
      'connection_error': 'انقطع الاتصال', 'retry': 'إعادة المحاولة', 'episodes': 'الحلقات',
      'overview': 'نبذة', 'recommendations': 'توصيات',
      'speed': 'السرعة', 'quality': 'الجودة', 'subtitles': 'ترجمة الذكاء الاصطناعي', 'enable_ai': 'تفعيل AI', 'back': 'رجوع',
      'wait_msg': 'حماية التسجيل نشطة. يرجى الانتظار...',
      'reminder_set': 'تم ضبط التذكير بنجاح!', 'added_list': 'تمت الإضافة إلى قائمتي',
      'removed_list': 'تمت الإزالة من قائمتي', 'empty_list': 'قائمتك فارغة',
      'report_subject': 'إبلاغ عن محتوى: '
    }
  };
  static String get(String code, String key) => _values[code]?[key] ?? key;
}

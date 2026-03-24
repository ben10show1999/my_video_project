class AppStrings {
  static const Map<String, Map<String, String>> _values = {
    'en': {
      'home': 'Home', 'search': 'Search', 'list': 'My List', 'settings': 'Settings', 'watch': 'Watch', 
      'clear_cache': 'Clear Cache', 'language': 'Language', 'auto': 'Auto', 'en': 'English', 'ar': 'العربية', 
      'close': 'Close', 'cache_cleared': 'Cache cleared successfully', 'protected': 'Protected',
      'connection_error': 'Connection Lost', 'retry': 'Retry', 'speed': 'Speed', 'quality': 'Quality', 
      'subtitles': 'Subtitles', 'ai_transition': 'AI Transition', 'disable': 'Off', 'back': 'Back',
      'wait_msg': 'Recording protection active. Please wait...', 'link_fail': 'Link failed, trying next...',
      'cooling_down': 'Network unstable. Retrying...', 'ai_loading': 'AI Model Loading...',
      'cache_limit': 'Cache clear limit reached (3/day). Please wait 24h.',
      'resume_msg': 'Do you want to resume the video from where you left off?', 'resume_btn': 'Resume',
      'trending': 'Trending', 'new_releases': 'New Releases', 'view_all': 'View All', 'show_more': 'Show More',
      'show_less': 'Show Less', 'autoplay': 'Autoplay', 'visit': 'Visit', 'about_app': 'About App',
      'content_note': 'Content Note', 'content_desc': 'Viewer discretion is advised.', 'close_ad': 'Close AD',
      'episodes': 'Episodes', 'overview': 'Overview', 'recommendations': 'Recommendations',
      'reminder_set': 'Reminder set successfully!', 'added_list': 'Added to My List', 'removed_list': 'Removed from My List',
      'empty_list': 'Your list is empty', 'report_subject': 'Report Content: ', 'notifications': 'Notifications'
    },
    'ar': {
      'home': 'الرئيسية', 'search': 'البحث', 'list': 'قائمتي', 'settings': 'الإعدادات', 'watch': 'مشاهدة', 
      'clear_cache': 'مسح الذاكرة المؤقتة', 'language': 'اللغة', 'auto': 'تلقائي', 'en': 'English', 'ar': 'العربية', 
      'close': 'إغلاق', 'cache_cleared': 'تم مسح الذاكرة بنجاح', 'protected': 'محتوى محمي',
      'connection_error': 'انقطع الاتصال', 'retry': 'إعادة المحاولة', 'speed': 'السرعة', 'quality': 'الجودة', 
      'subtitles': 'الترجمة', 'ai_transition': 'الترجمة بالذكاء الاصطناعي', 'disable': 'إيقاف', 'back': 'رجوع',
      'wait_msg': 'حماية التسجيل نشطة. يرجى الانتظار...', 'link_fail': 'فشل الرابط، جارٍ تجربة التالي...',
      'cooling_down': 'الشبكة غير مستقرة. سنحاول بعد قليل...', 'ai_loading': 'جاري تحميل نموذج الذكاء الاصطناعي...',
      'cache_limit': 'تم الوصول للحد الأقصى لمسح الذاكرة (3/يومياً). يرجى الانتظار 24 ساعة.',
      'resume_msg': 'هل تريد استئناف الفديو من حيث توقفت', 'resume_btn': 'أستئناف',
      'trending': 'الأكثر رواجاً', 'new_releases': 'الإصدارات الجديدة', 'view_all': 'عرض الكل', 'show_more': 'عرض المزيد',
      'show_less': 'عرض أقل', 'autoplay': 'تشغيل تلقائي', 'visit': 'زيارة', 'about_app': 'حول التطبيق',
      'content_note': 'ملاحظة المحتوى', 'content_desc': 'يرجى توخي الحذر عند المشاهدة.', 'close_ad': 'إغلاق الإعلان',
      'episodes': 'الحلقات', 'overview': 'نبذة', 'recommendations': 'توصيات',
      'reminder_set': 'تم ضبط التذكير بنجاح!', 'added_list': 'تمت الإضافة إلى قائمتي', 'removed_list': 'تمت الإزالة من قائمتي',
      'empty_list': 'قائمتك فارغة', 'report_subject': 'إبلاغ عن محتوى: ', 'notifications': 'الإشعارات'
    }
  };
  static String get(String code, String key) => _values[code]?[key] ?? key;
}

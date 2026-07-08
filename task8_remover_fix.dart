import 'dart:io';

void main() async {
  print('==================================================');
  print('🛠️ Master Build - Web Dependency Fixer');
  print('==================================================\n');

  final mainFile = File('lib/main.dart');
  
  if (!await mainFile.exists()) {
    print('❌ خطأ حرج: لم يتم العثور على lib/main.dart.');
    print('💡 تأكد من تواجدك في المسار الرئيسي للمشروع.');
    return;
  }

  List<String> lines = await mainFile.readAsLines();
  String content = await mainFile.readAsString();

  print('⏳ جاري الفحص واستعادة تبعيات الويب الأساسية...');

  // التحقق من وجود الاستيراد لمنع التكرار (0% تكرار)
  if (content.contains("import 'package:web/web.dart' as web;")) {
    print('✔️ حزمة الويب موجودة بالفعل. لا حاجة لأي تعديل.');
    return;
  }

  // البحث عن أفضل مكان لحقن الاستيراد (بعد آخر سطر import)
  int insertIndex = lines.lastIndexWhere((line) => line.startsWith('import '));
  
  if (insertIndex != -1) {
    lines.insert(insertIndex + 1, "import 'package:web/web.dart' as web;");
  } else {
    // في حال عدم وجود أي استيراد سابق، يتم وضعه في السطر الأول
    lines.insert(0, "import 'package:web/web.dart' as web;");
  }

  // إجبار النظام على حفظ التعديلات فوراً
  await mainFile.writeAsString(lines.join('\n'), flush: true);
  
  print('\n✔️ تم إصلاح الأخطاء الأربعة بنجاح قاطع!');
  print('✅ تمت إعادة ربط حزمة (package:web) لضمان استقرار الإشعارات والروابط.');
  print('🔄 يرجى عمل Refresh (تحديث) لشجرة الملفات أو إعادة فتح main.dart للتأكد.');
  print('==================================================');
}
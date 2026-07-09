import 'dart:io';

void main() async {
  print('==================================================');
  print('🧹 Master Build - Anti-Flicker Edge Cleanup (مُهمة 14)');
  print('==================================================\n');

  final netlifyToml = File('netlify.toml');
  final tsFile = File('netlify/edge-functions/secure_headers.ts');
  final edgeDir = Directory('netlify/edge-functions');

  bool isModified = false;

  print('⏳ جاري إزالة ترويسات العزل (CSP) لمنع الشاشة السوداء...');

  // 1. تنظيف ملف netlify.toml من استدعاء دالة الحافة (Edge Function)
  if (await netlifyToml.exists()) {
    String toml = await netlifyToml.readAsString();
    
    // البحث عن قسم [[edge_functions]] وإزالته مع الحفاظ على [build] و [[redirects]]
    int edgeIndex = toml.indexOf('[[edge_functions]]');
    if (edgeIndex != -1) {
      toml = toml.substring(0, edgeIndex).trim();
      await netlifyToml.writeAsString(toml + '\n');
      print('✔️ تم تنظيف (netlify.toml) بنجاح من توجيهات العزل الخارجي.');
      isModified = true;
    } else {
      print('✔️ ملف (netlify.toml) نظيف مسبقاً.');
    }
  }

  // 2. حذف ملف TypeScript المسبب لعملية (Process Swap) في المتصفح
  if (await tsFile.exists()) {
    await tsFile.delete();
    print('✔️ تم حذف ملف (secure_headers.ts) بنجاح.');
    isModified = true;
  }

  // 3. حذف مجلد دوال الحافة إذا أصبح فارغاً
  if (await edgeDir.exists()) {
    try {
      await edgeDir.delete();
      print('✔️ تم إزالة مجلد دوال الحافة بالكامل.');
    } catch (e) {
      // قد يحتوي على ملفات أخرى، نتركه بأمان
    }
  }

  if (isModified) {
    print('\n==================================================');
    print('✅ تمت عملية الإزالة الجراحية بنجاح مطلق!');
    print('🚀 التطبيق الآن سيعرض شاشة البداية (SVG) مرة واحدة بثبات تام.');
    print('💡 الخطوة القادمة للتطبيق الفوري:');
    print('نفذ: git add . && git commit -m "Remove CSP Edge Function to fix Double Splash" && git push');
    print('==================================================');
  } else {
    print('\n==================================================');
    print('⚠️ البيئة نظيفة بالفعل، لم يتم العثور على ملفات Edge Function.');
    print('==================================================');
  }
}

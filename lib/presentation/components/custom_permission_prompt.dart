import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:web/web.dart' as web;

class CustomPermissionPrompt {
  static Future<void> checkAndShow(BuildContext context) async {
    if (!kIsWeb) return; // التطبيقات المدمجة لا تعاني من هذه المشكلة، لكن يمكنك إلغاء الشرط إذا أردت توحيد التجربة تماماً

    try {
      // 1. التحقق مما إذا كنا قد سألنا المستخدم من قبل عبر الذاكرة المحلية
      final hasAsked = web.window.localStorage.getItem('soft_prompt_asked');
      if (hasAsked == 'true') return;

      // 2. التحقق من حالة الصلاحية الفعلية من النظام
      final settings = await FirebaseMessaging.instance.getNotificationSettings();
      if (settings.authorizationStatus == AuthorizationStatus.authorized || 
          settings.authorizationStatus == AuthorizationStatus.denied) {
        return; // إذا كان قد وافق مسبقاً أو رفض بشكل قاطع من المتصفح، لا نظهر الحاوية
      }

      // 3. إظهار الحاوية المخصصة الفخمة
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (c) => const _CustomPromptDialog(),
        );
      }
    } catch (e) {
      debugPrint('Soft Prompt Check Error: $e');
    }
  }
}

class _CustomPromptDialog extends StatelessWidget {
  const _CustomPromptDialog();

  void _onDeny(BuildContext context) {
    web.window.localStorage.setItem('soft_prompt_asked', 'true');
    Navigator.pop(context);
  }

  void _onAllow(BuildContext context) async {
    // حفظ القرار لإيقاف إظهار الحاوية مستقبلاً
    web.window.localStorage.setItem('soft_prompt_asked', 'true');
    Navigator.pop(context);

    try {
      // استدعاء الحاوية الأصلية للنظام بعد تهيئة المستخدم
      final result = await FirebaseMessaging.instance.requestPermission();
      
      if (result.authorizationStatus == AuthorizationStatus.authorized) {
        // تهيئة الرمز والاشتراك في الراديو بعد الموافقة الناجحة فقط
        await FirebaseMessaging.instance.getToken(vapidKey: "BPvG4GZiDGMHneEmaOgYXY7zRgFMPIwOJw4wuHs_IDjfXlD_cMcw-GftysTarsXk8mrUm5egqvSVpgQBKr1JSXk");
        await FirebaseMessaging.instance.subscribeToTopic('all_users');
      }
    } catch (e) {
      debugPrint("Native prompt failed or silently dropped by WebView: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white10),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 20, offset: const Offset(0, 10))],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.amber.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: const Icon(Icons.notifications_active_rounded, color: Colors.amber, size: 48),
            ),
            const SizedBox(height: 20),
            const Text(
              'تفعيل إشعارات التطبيق',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'لتبقى على اطلاع دائم بأحدث الحلقات والأفلام فور صدورها، نرجو منك السماح لنا بإرسال الإشعارات. نعدك بأننا لن نقوم بإزعاجك.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => _onDeny(context),
                    style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                    child: const Text('ليس الآن', style: TextStyle(color: Colors.grey, fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _onAllow(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('سماح بالإشعارات', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

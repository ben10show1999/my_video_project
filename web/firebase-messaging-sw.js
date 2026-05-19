importScripts('https://www.gstatic.com/firebasejs/10.12.2/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.12.2/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey: "AIzaSyAHEohG8X7bUK0LWfTmCVFkPT6SjbJGL08",
  authDomain: "my-video-project-c6696.firebaseapp.com",
  projectId: "my-video-project-c6696",
  storageBucket: "my-video-project-c6696.firebasestorage.app",
  messagingSenderId: "162978515705",
  appId: "1:162978515705:web:f837eb508d1b341bff3028"
});

const messaging = firebase.messaging();

// صائد نقرات المتصفح المتقدم: قنص المعرف من كافة ثنايا كتل حزم بيانات FCM Console الأصلية وحقنها بذكاء
self.addEventListener('notificationclick', function(event) {
  event.notification.close();
  
  let targetId = '';
  try {
    if (event.notification.data) {
      if (event.notification.data.targetId) {
        targetId = event.notification.data.targetId;
      } else if (event.notification.data.FCM_MSG && event.notification.data.FCM_MSG.data) {
        targetId = event.notification.data.FCM_MSG.data.targetId || '';
      } else {
        // فحص مجهري لكافة الحقول المباشرة داخل الهيكل لمنع أي تغيير في واجهة كونسول فيسبوك/جوجل
        for (let key in event.notification.data) {
          if (key.toLowerCase() === 'targetid') {
            targetId = event.notification.data[key];
            break;
          }
        }
      }
    }
  } catch (e) {
    console.error('Critical Error parsing payload structured data:', e);
  }

  // بناء المسار المباشر المدمج ليتوافق مع آلية القنص المبكر للنواة وفلاتر ويب
  const baseOrigin = self.location.origin + self.location.pathname;
  const targetUrl = targetId ? baseOrigin + '?targetId=' + targetId : baseOrigin;

  event.waitUntil(
    clients.matchAll({ type: 'window', includeUncontrolled: true }).then(function(windowClients) {
      // في حال كان هناك تبويب نشط للموقع، أعد توجيهه للرابط المشحون بالمعرف واجلب التركيز عليه
      for (var i = 0; i < windowClients.length; i++) {
        var client = windowClients[i];
        if (client.url.indexOf(self.location.origin) !== -1 && 'navigate' in client) {
          return client.navigate(targetUrl).then(function(c) {
            return c.focus();
          });
        }
      }
      // إذا كان التطبيق مغلقاً تماماً، افتح نافذة جديدة نقية محقونة بالمعرف السائل مباشرة
      if (clients.openWindow) {
        return clients.openWindow(targetUrl);
      }
    })
  );
});

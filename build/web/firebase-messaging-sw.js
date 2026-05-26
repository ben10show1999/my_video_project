// 🎯 1. الاختطاف السيادي: قنص نقرة الإشعار قبل محرك Firebase الافتراضي
self.addEventListener('notificationclick', function(event) {
  event.stopImmediatePropagation(); // إيقاف السلوك الافتراضي لمنع فتح التطبيق من البداية دون المعرف
  event.notification.close();
  
  let targetId = '';
  try {
    if (event.notification.data) {
      if (event.notification.data.targetId) {
        targetId = event.notification.data.targetId;
      } else if (event.notification.data.FCM_MSG && event.notification.data.FCM_MSG.data) {
        targetId = event.notification.data.FCM_MSG.data.targetId || '';
      } else {
        for (let key in event.notification.data) {
          if (key.toLowerCase() === 'targetid') {
            targetId = event.notification.data[key];
            break;
          }
        }
      }
    }
  } catch (e) {
    console.error('Payload parse error:', e);
  }

  // 🎯 التعديل الحاسم: فرض الدومين الرئيسي النقي المستضاف على Netlify واختزال أي مسارات وهمية
  const baseUrl = self.location.origin + '/';
  const targetUrl = targetId ? baseUrl + '?targetId=' + targetId : baseUrl;

  event.waitUntil(
    clients.matchAll({ type: 'window', includeUncontrolled: true }).then(function(windowClients) {
      // إذا كان تبويب الموقع مفتوحاً، وجهه للرابط النقي الجديد واجلب التركيز عليه
      for (var i = 0; i < windowClients.length; i++) {
        var client = windowClients[i];
        if (client.url.indexOf(self.location.origin) !== -1 && 'navigate' in client) {
          return client.navigate(targetUrl).then(c => c.focus());
        }
      }
      // إذا كان مغلقاً، افتح نافذة جديدة بالرابط الرئيسي المحقون بالبيانات مباشرة
      if (clients.openWindow) {
        return clients.openWindow(targetUrl);
      }
    })
  );
});

// 2. استدعاء مكاتب Firebase الرسمية بعد إتمام بروتوكول الحماية والـ Routing
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

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

// صائد نقرات المتصفح السيادي: استخراج المعرف بدقة من كافة هياكل حزم لوحة التحكم وحقنها في رابط الويب
self.addEventListener('notificationclick', function(event) {
  event.notification.close();
  
  let targetId = '';
  try {
    if (event.notification.data) {
      if (event.notification.data.targetId) {
        targetId = event.notification.data.targetId;
      } else if (event.notification.data.FCM_MSG && event.notification.data.FCM_MSG.data) {
        targetId = event.notification.data.FCM_MSG.data.targetId || '';
      }
    }
  } catch (e) {
    console.error('Error extracting data payload from click event:', e);
  }

  // بناء الرابط المباشر مشحوناً بالمعرف لدعم طبقة الالتقاط المبكر جداً في النواة
  const baseOrigin = self.location.origin + self.location.pathname;
  const targetUrl = targetId ? baseOrigin + '?targetId=' + targetId : baseOrigin;

  event.waitUntil(
    clients.matchAll({ type: 'window', includeUncontrolled: true }).then(function(windowClients) {
      // إذا كان هناك تبويب مفتوح مسبقاً، اجبره على الانتقال للرابط المشحون بالمعرف الجديد والتركيز عليه
      for (var i = 0; i < windowClients.length; i++) {
        var client = windowClients[i];
        if (client.url.indexOf(self.location.origin) !== -1 && 'navigate' in client) {
          return client.navigate(targetUrl).then(function(c) {
            return c.focus();
          });
        }
      }
      // إذا كان مغلقاً تماماً، افتح نافذة جديدة نقية محقونة بالمعرف مباشرة
      if (clients.openWindow) {
        return clients.openWindow(targetUrl);
      }
    })
  );
});

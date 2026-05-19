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

// 🎯 صائد نقرات المتصفح السيادي: استخراج البيانات وحقنها مباشرة في رابط الويب لمنع الضياع والتكرار
self.addEventListener('notificationclick', function(event) {
  event.notification.close();
  
  let targetId = '';
  try {
    // التقاط المعرف من هيكل بيانات FCM المتقدمة المرسلة من لوحة التحكم
    if (event.notification.data && event.notification.data.FCM_MSG && event.notification.data.FCM_MSG.data) {
      targetId = event.notification.data.FCM_MSG.data.targetId || '';
    }
  } catch (e) {
    console.error('Error parsing FCM payload data:', e);
  }

  // بناء الرابط السائل الجديد مشحوناً بمعرف الفيلم المستهدف
  const targetUrl = targetId ? self.location.origin + '/?targetId=' + targetId : self.location.origin + '/';

  event.waitUntil(
    clients.matchAll({ type: 'window', includeUncontrolled: true }).then(function(windowClients) {
      // إذا كان الموقع مفتوحاً مسبقاً في أي تبويب، اجبره على الانتقال للرابط الجديد والتركيز عليه
      for (var i = 0; i < windowClients.length; i++) {
        var client = windowClients[i];
        if (client.url.indexOf(self.location.origin) !== -1 && 'navigate' in client) {
          return client.navigate(targetUrl).then(function(c) {
            return c.focus();
          });
        }
      }
      // إذا كان الموقع مغلقاً، افتح نافذة جديدة بالرابط المشحون بالبيانات مباشرة
      if (clients.openWindow) {
        return clients.openWindow(targetUrl);
      }
    })
  );
});

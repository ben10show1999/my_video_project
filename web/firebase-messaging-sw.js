// 🎯 1. الاختطاف السيادي: يجب أن يكون هذا الكود في السطر الأول قبل استدعاء مكاتب Firebase
self.addEventListener('notificationclick', function(event) {
  event.stopImmediatePropagation(); // 🛑 إيقاف محرك Firebase الافتراضي الغبي من فتح التطبيق من البداية!
  event.notification.close();
  
  let targetId = '';
  try {
    if (event.notification.data && event.notification.data.FCM_MSG && event.notification.data.FCM_MSG.data) {
      targetId = event.notification.data.FCM_MSG.data.targetId || '';
    }
  } catch (e) {
    console.error('Payload parse error:', e);
  }

  // بناء الرابط المحقون بالبيانات
  let baseUrl = self.registration.scope;
  if (!baseUrl.endsWith('/')) { baseUrl += '/'; }
  const targetUrl = targetId ? baseUrl + '?targetId=' + targetId : baseUrl;

  event.waitUntil(
    clients.matchAll({ type: 'window', includeUncontrolled: true }).then(function(windowClients) {
      for (var i = 0; i < windowClients.length; i++) {
        var client = windowClients[i];
        if (client.url.indexOf(baseUrl) !== -1 && 'navigate' in client) {
          return client.navigate(targetUrl).then(c => c.focus());
        }
      }
      if (clients.openWindow) {
        return clients.openWindow(targetUrl);
      }
    })
  );
});

// 2. تحميل مكاتب Firebase بعد أن ضمنا السيطرة المطلقة على النقرات
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

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

messaging.onBackgroundMessage((payload) => {
  console.log('[ServiceWorker] Background Push Core Received: ', payload);
  const notificationTitle = payload.notification?.title || 'إشعار نظام جديد';
  
  // 💡 التعديل الجراحي: استخدام رابط صورة حي لمنع الـ (Silent Abort)
  const notificationOptions = {
    body: payload.notification?.body || 'انقر لفتح المنصة',
    icon: payload.notification?.image || 'https://iili.io/q2Ty8N4.webp',
    data: {
      url: self.location.origin
    }
  };

  return self.registration.showNotification(notificationTitle, notificationOptions);
});

self.addEventListener('notificationclick', function(event) {
  event.notification.close();
  event.waitUntil(
    clients.matchAll({ type: 'window' }).then(windowClients => {
      for (var i = 0; i < windowClients.length; i++) {
        var client = windowClients[i];
        if (client.url.indexOf(self.location.origin) !== -1 && 'focus' in client) {
          return client.focus();
        }
      }
      if (clients.openWindow) {
        return clients.openWindow('/');
      }
    })
  );
});

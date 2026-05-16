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

// 💡 مُهمة (1) & (4): استقبال النبضة السحابية في الخلفية للمتصفح المباشر، وتحويلها بقوة إلى إشعار نظام سيادي (OS-Level Toast)
messaging.onBackgroundMessage((payload) => {
  console.log('[ServiceWorker] Background Push Received: ', payload);
  const notificationTitle = payload.notification?.title || 'إشعار جديد من النظام';
  const notificationOptions = {
    body: payload.notification?.body || 'انقر لفتح التطبيق ومعاينة المحتوى',
    icon: '/icons/Icon-192.png',
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

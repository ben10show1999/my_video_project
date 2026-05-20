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
        for (let key in event.notification.data) {
          if (key.toLowerCase() === 'targetid') {
            targetId = event.notification.data[key];
            break;
          }
        }
      }
    }
  } catch (e) {
    console.error('Payload parsing error:', e);
  }

  // 🎯 التعديل الجذري: استخدام scope بدلاً من pathname لضمان فتح الجذر الرئيسي للموقع
  const baseUrl = self.registration.scope;
  const targetUrl = targetId ? baseUrl + '?targetId=' + targetId : baseUrl;

  event.waitUntil(
    clients.matchAll({ type: 'window', includeUncontrolled: true }).then(function(windowClients) {
      for (var i = 0; i < windowClients.length; i++) {
        var client = windowClients[i];
        if (client.url.indexOf(baseUrl) !== -1 && 'navigate' in client) {
          return client.navigate(targetUrl).then(function(c) {
            return c.focus();
          });
        }
      }
      if (clients.openWindow) {
        return clients.openWindow(targetUrl);
      }
    })
  );
});

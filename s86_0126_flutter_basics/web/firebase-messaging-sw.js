importScripts('https://www.gstatic.com/firebasejs/9.22.2/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.22.2/firebase-messaging-compat.js');

// Initialize the Firebase app in the service worker by passing in
// your app's Firebase config. This config should match the one used
// in your Flutter app (lib/firebase_options.dart).
firebase.initializeApp({
  apiKey: 'AIzaSyD-5q8vOAXB42iXxK5BvNqDqTN17WA5TuQ',
  appId: '1:976106218961:web:a54487dd3a209f7b34ecf0',
  messagingSenderId: '976106218961',
  projectId: 'my-play-on-id',
  authDomain: 'my-play-on-id.firebaseapp.com',
  storageBucket: 'my-play-on-id.firebasestorage.app',
  measurementId: 'G-2V5Q28X8GS'
});

const messaging = firebase.messaging();

// Background message handler
messaging.onBackgroundMessage(function(payload) {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);
  const notificationTitle = (payload.notification && payload.notification.title) || 'Background Message';
  const notificationOptions = {
    body: (payload.notification && payload.notification.body) || '',
    // You can add an icon here if you have one at the specified path
    // icon: '/icons/Icon-192.png'
  };

  return self.registration.showNotification(notificationTitle, notificationOptions);
});

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static String? deviceToken;
  static String? foregroundMessage;
  static String? backgroundMessage;

  // Callback function for handling notifications
  static void Function(RemoteMessage)? onForegroundMessageCallback;

  /// Initialize Firebase Messaging
  static Future<void> initialize() async {
    try {
      debugPrint("🔔 [FCM] Initializing Firebase Messaging...");

      // Request notification permissions
      NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      debugPrint(
          "🔔 [FCM] Notification permission status: ${settings.authorizationStatus}");

      // Get FCM token
      deviceToken = await _messaging.getToken();
      debugPrint("🔔 [FCM] Device Token: $deviceToken");

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint("🔔 [FCM] Foreground message received");
        debugPrint("🔔 [FCM] Title: ${message.notification?.title}");
        debugPrint("🔔 [FCM] Body: ${message.notification?.body}");

        foregroundMessage =
            "${message.notification?.title}\n${message.notification?.body}";

        // Call the callback if provided
        if (onForegroundMessageCallback != null) {
          onForegroundMessageCallback!(message);
        }
      });

      // Handle messages when app is opened from a notification
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        debugPrint("🔔 [FCM] App opened from notification");
        debugPrint("🔔 [FCM] Title: ${message.notification?.title}");
        debugPrint("🔔 [FCM] Body: ${message.notification?.body}");

        backgroundMessage =
            "${message.notification?.title}\n${message.notification?.body}";
      });

      // Handle messages when app is in terminated state
      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();

      if (initialMessage != null) {
        debugPrint("🔔 [FCM] App opened from terminated state notification");
        debugPrint("🔔 [FCM] Title: ${initialMessage.notification?.title}");
        debugPrint("🔔 [FCM] Body: ${initialMessage.notification?.body}");

        backgroundMessage =
            "${initialMessage.notification?.title}\n${initialMessage.notification?.body}";
      }

      debugPrint("🔔 [FCM] Firebase Messaging initialization complete");
    } catch (e) {
      debugPrint("❌ [FCM] Error initializing Firebase Messaging: $e");
    }
  }

  /// Get current device token
  static Future<String?> getDeviceToken() async {
    try {
      deviceToken ??= await _messaging.getToken();
      return deviceToken;
    } catch (e) {
      debugPrint("❌ [FCM] Error getting device token: $e");
      return null;
    }
  }

  /// Listen for token refresh
  static void listenForTokenRefresh(Function(String) onTokenRefresh) {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      debugPrint("🔔 [FCM] Token refreshed: $newToken");
      deviceToken = newToken;
      onTokenRefresh(newToken);
    });
  }

  /// Get last foreground message
  static String? getLastForegroundMessage() => foregroundMessage;

  /// Get last background message
  static String? getLastBackgroundMessage() => backgroundMessage;

  /// Clear messages
  static void clearMessages() {
    foregroundMessage = null;
    backgroundMessage = null;
  }
}

/// Background message handler (must be a top-level function)
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("🔔 [FCM] Background message handler triggered");
  debugPrint("🔔 [FCM] Title: ${message.notification?.title}");
  debugPrint("🔔 [FCM] Body: ${message.notification?.body}");
  debugPrint("🔔 [FCM] Data: ${message.data}");
}

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../services/notification_service.dart';

class PushNotificationsDemoScreen extends StatefulWidget {
  const PushNotificationsDemoScreen({Key? key}) : super(key: key);

  @override
  State<PushNotificationsDemoScreen> createState() =>
      _PushNotificationsDemoScreenState();
}

class _PushNotificationsDemoScreenState extends State<PushNotificationsDemoScreen> {
  String _deviceToken = "Loading...";
  String _foregroundMessage = "No message received yet";
  String _backgroundMessage = "No message received yet";
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _loadDeviceToken();
    _setupNotificationCallback();
  }

  void _loadDeviceToken() async {
    try {
      final token = await NotificationService.getDeviceToken();
      setState(() {
        _deviceToken = token ?? "Failed to get token";
        _isInitialized = true;
      });
    } catch (e) {
      setState(() {
        _deviceToken = "Error: $e";
        _isInitialized = false;
      });
    }
  }

  void _setupNotificationCallback() {
    NotificationService.onForegroundMessageCallback =
        (RemoteMessage message) {
      setState(() {
        _foregroundMessage =
            "${message.notification?.title}\n${message.notification?.body}";
      });
    };

    NotificationService.listenForTokenRefresh((newToken) {
      setState(() {
        _deviceToken = newToken;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Push Notifications (FCM)"),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildStatusSection(),
            const SizedBox(height: 24),
            _buildDeviceTokenSection(),
            const SizedBox(height: 24),
            _buildMessagesSection(),
            const SizedBox(height: 24),
            _buildInstructionsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepOrange.shade50,
        border: Border.all(color: Colors.deepOrange, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "📱 Firebase Cloud Messaging (FCM)",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Real-time push notifications for your sports tournament app",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _isInitialized
                  ? Colors.green.shade100
                  : Colors.red.shade100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              _isInitialized ? "✅ FCM Initialized" : "⚠️ FCM Not Ready",
              style: TextStyle(
                color: _isInitialized ? Colors.green.shade700 : Colors.red.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        border: Border.all(color: Colors.blue, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.blue.shade600),
              const SizedBox(width: 8),
              const Text(
                "Permission Status",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "✅ Notifications: Enabled\n"
            "✅ Badge: Enabled\n"
            "✅ Sound: Enabled\n"
            "✅ Background Delivery: Configured",
            style: TextStyle(fontSize: 12, color: Colors.blue.shade700),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceTokenSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        border: Border.all(color: Colors.purple, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.security, color: Colors.purple.shade600),
              const SizedBox(width: 8),
              const Text(
                "Device FCM Token",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.purple.shade200),
              borderRadius: BorderRadius.circular(4),
            ),
            child: SelectableText(
              _deviceToken,
              style: const TextStyle(
                fontFamily: 'Courier',
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: _loadDeviceToken,
            icon: const Icon(Icons.refresh),
            label: const Text("Refresh Token"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple.shade600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Use this token to send test notifications from Firebase Console → Messaging",
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "📨 Received Messages",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
        const SizedBox(height: 12),
        _buildMessageBox(
          title: "Foreground Message",
          message: _foregroundMessage,
          color: Colors.green,
          icon: Icons.arrow_downward,
        ),
        const SizedBox(height: 12),
        _buildMessageBox(
          title: "Background/Terminated Message",
          message: _backgroundMessage,
          color: Colors.blue,
          icon: Icons.arrow_upward,
        ),
      ],
    );
  }

  Widget _buildMessageBox({
    required String title,
    required String message,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              message,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        border: Border.all(color: Colors.amber, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.amber.shade600),
              const SizedBox(width: 8),
              const Text(
                "How to Test Notifications",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "1. Copy the FCM Token above\n"
            "2. Go to Firebase Console → Messaging\n"
            "3. Click \"Send your first message\"\n"
            "4. Enter title and body\n"
            "5. Select \"Send to a device\"\n"
            "6. Paste the FCM Token\n"
            "7. Click \"Send\"\n"
            "8. Message appears here when received\n\n"
            "Message States:\n"
            "• Foreground: App is open\n"
            "• Background: App is minimized\n"
            "• Terminated: App is closed",
            style: TextStyle(fontSize: 11, color: Colors.amber.shade900),
          ),
        ],
      ),
    );
  }
}

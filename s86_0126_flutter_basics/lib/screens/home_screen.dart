import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/index.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    debugPrint('🏠 [HOME] HomeScreen initialized');
  }

  void _handleLogout() async {
    try {
      await _authService.logout();
      debugPrint('👋 [LOGOUT] User logged out');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logged out successfully'),
          backgroundColor: Colors.red,
        ),
      );
      // Navigation is handled by StreamBuilder in main.dart
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logout error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _navigateToScreen(String routeName, String screenName) {
    debugPrint('📱 [NAVIGATION] Navigating to $screenName');
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Welcome, ${user?.email ?? 'User'}'),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _handleLogout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Welcome Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green[400]!, Colors.green[600]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome Back! 👋',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Explore Flutter demos and features',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Demo Screens Section
                Text(
                  'Available Demos',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 16),

                // Hot Reload Demo Card
                CustomCard(
                  icon: Icons.flash_on,
                  iconColor: Colors.amber,
                  title: 'Hot Reload Demo',
                  description:
                      'See the power of Hot Reload with interactive components and debug logging',
                  features: ['Counter', 'Color Cycling', 'Slider', 'Theme Toggle'],
                  onTap: () => _navigateToScreen('/hot-reload', 'Hot Reload Demo'),
                ),
                const SizedBox(height: 16),

                // Stateless/Stateful Demo Card
                CustomCard(
                  icon: Icons.widgets,
                  iconColor: Colors.blue,
                  title: 'Stateless & Stateful Widgets',
                  description:
                      'Learn the difference between stateless and stateful widgets',
                  features: ['Counter Widget', 'Theme Toggle', 'State Management'],
                  onTap: () =>
                      _navigateToScreen('/stateless-stateful', 'Widgets Demo'),
                ),
                const SizedBox(height: 16),

                // Second Screen Demo Card
                CustomCard(
                  icon: Icons.dashboard_customize,
                  iconColor: Colors.purple,
                  title: 'Second Screen',
                  description:
                      'Navigate to a secondary screen demonstrating multi-screen navigation',
                  features: ['Navigator.pop()', 'Named Routes', 'Back Button'],
                  onTap: () =>
                      _navigateToScreen('/second', 'Second Screen'),
                ),
                const SizedBox(height: 16),

                // Responsive Layout Demo Card
                CustomCard(
                  icon: Icons.dashboard,
                  iconColor: Colors.deepOrange,
                  title: 'Responsive Layout Design',
                  description:
                      'Learn about Container, Row, Column, and responsive design principles',
                  features: ['MediaQuery', 'Adaptive Layouts', 'Grid Design'],
                  onTap: () =>
                      _navigateToScreen('/responsive-layout', 'Responsive Layout'),
                ),
                const SizedBox(height: 16),

                // Scrollable Views Demo Card
                CustomCard(
                  icon: Icons.list,
                  iconColor: Colors.teal,
                  title: 'Scrollable Views - Tournament Tracker',
                  description:
                      'Explore ListView and GridView for displaying live scores, tournaments, and player stats',
                  features: ['ListView.builder', 'GridView.builder', 'Live Data'],
                  onTap: () =>
                      _navigateToScreen('/scrollable-views', 'Scrollable Views'),
                ),
                const SizedBox(height: 16),

                // User Input Form Demo Card
                CustomCard(
                  icon: Icons.app_registration,
                  iconColor: Colors.pink,
                  title: 'User Input Form - Tournament Registration',
                  description:
                      'Learn form validation with TextFormField, buttons, and real-time feedback messages',
                  features: ['TextFormField', 'Validation Logic', 'SnackBar Feedback'],
                  onTap: () =>
                      _navigateToScreen('/user-input', 'User Input Form'),
                ),
                const SizedBox(height: 16),

                // State Management Demo Card
                CustomCard(
                  icon: Icons.refresh,
                  iconColor: Colors.deepPurple,
                  title: 'State Management - setState() Demo',
                  description:
                      'Master local state management with setState() and build interactive, responsive UIs',
                  features: ['setState()', 'Dynamic UI', 'Conditional Rendering'],
                  onTap: () =>
                      _navigateToScreen('/state-management', 'State Management Demo'),
                ),
                const SizedBox(height: 16),

                // Asset Management Demo Card
                CustomCard(
                  icon: Icons.image,
                  iconColor: Colors.cyan,
                  title: 'Managing Assets - Images & Icons',
                  description:
                      'Learn how to add, register, and display images, icons, and local assets in Flutter',
                  features: ['Image.asset()', 'Built-in Icons', 'Asset Configuration'],
                  onTap: () =>
                      _navigateToScreen('/asset-demo', 'Asset Management Demo'),
                ),
                const SizedBox(height: 16),

                // Animations & Transitions Demo Card
                CustomCard(
                  icon: Icons.animation,
                  iconColor: Colors.deepPurple,
                  title: 'Animations & Transitions',
                  description:
                      'Master implicit and explicit animations to create smooth, professional UI transitions and effects',
                  features: ['AnimatedContainer', 'RotationTransition', 'PageRouteBuilder'],
                  onTap: () =>
                      _navigateToScreen('/animation-demo', 'Animations & Transitions'),
                ),
                const SizedBox(height: 16),

                // Tasks / Firestore Demo Card
                CustomCard(
                  icon: Icons.task,
                  iconColor: Colors.indigo,
                  title: 'Tasks - Firestore Writes',
                  description:
                      'Add and update tasks in Cloud Firestore with safe writes and validation',
                  features: ['Add (auto-id)', 'Update (merge)', 'Real-time list'],
                  onTap: () => _navigateToScreen('/tasks', 'Tasks'),
                ),
                const SizedBox(height: 32),

                // Info Section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info, color: Colors.blue[600]),
                          const SizedBox(width: 12),
                          Text(
                            'About This App',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'This app demonstrates Flutter fundamentals including:\n'
                        '• Multi-screen navigation using named routes\n'
                        '• Stateless and Stateful widgets\n'
                        '• Hot Reload functionality\n'
                        '• Flutter DevTools integration\n'
                        '• Debug console and logging',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blue[800],
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Quick Stats
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard('2', 'Demos'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard('5', 'Features'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard('3', 'Screens'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String count, String label) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            count,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}


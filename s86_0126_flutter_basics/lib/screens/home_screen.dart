import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint('🏠 [HOME] HomeScreen initialized');
  }

  void _handleLogout() {
    debugPrint('👋 [LOGOUT] User logged out');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Logged out successfully'),
        backgroundColor: Colors.red,
      ),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  void _navigateToScreen(String routeName, String screenName) {
    debugPrint('📱 [NAVIGATION] Navigating to $screenName');
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Dashboard'),
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
                GestureDetector(
                  onTap: () => _navigateToScreen('/hot-reload', 'Hot Reload Demo'),
                  child: _buildDemoCard(
                    icon: Icons.flash_on,
                    iconColor: Colors.amber,
                    title: 'Hot Reload Demo',
                    description:
                        'See the power of Hot Reload with interactive components and debug logging',
                    features: ['Counter', 'Color Cycling', 'Slider', 'Theme Toggle'],
                  ),
                ),
                const SizedBox(height: 16),

                // Stateless/Stateful Demo Card
                GestureDetector(
                  onTap: () =>
                      _navigateToScreen('/stateless-stateful', 'Widgets Demo'),
                  child: _buildDemoCard(
                    icon: Icons.widgets,
                    iconColor: Colors.blue,
                    title: 'Stateless & Stateful Widgets',
                    description:
                        'Learn the difference between stateless and stateful widgets',
                    features: ['Counter Widget', 'Theme Toggle', 'State Management'],
                  ),
                ),
                const SizedBox(height: 16),

                // Second Screen Demo Card
                GestureDetector(
                  onTap: () =>
                      _navigateToScreen('/second', 'Second Screen'),
                  child: _buildDemoCard(
                    icon: Icons.dashboard_customize,
                    iconColor: Colors.purple,
                    title: 'Second Screen',
                    description:
                        'Navigate to a secondary screen demonstrating multi-screen navigation',
                    features: ['Navigator.pop()', 'Named Routes', 'Back Button'],
                  ),
                ),
                const SizedBox(height: 16),

                // Responsive Layout Demo Card
                GestureDetector(
                  onTap: () =>
                      _navigateToScreen('/responsive-layout', 'Responsive Layout'),
                  child: _buildDemoCard(
                    icon: Icons.dashboard,
                    iconColor: Colors.deepOrange,
                    title: 'Responsive Layout Design',
                    description:
                        'Learn about Container, Row, Column, and responsive design principles',
                    features: ['MediaQuery', 'Adaptive Layouts', 'Grid Design'],
                  ),
                ),
                const SizedBox(height: 16),

                // Scrollable Views Demo Card
                GestureDetector(
                  onTap: () =>
                      _navigateToScreen('/scrollable-views', 'Scrollable Views'),
                  child: _buildDemoCard(
                    icon: Icons.list,
                    iconColor: Colors.teal,
                    title: 'Scrollable Views - Tournament Tracker',
                    description:
                        'Explore ListView and GridView for displaying live scores, tournaments, and player stats',
                    features: ['ListView.builder', 'GridView.builder', 'Live Data'],
                  ),
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

  Widget _buildDemoCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required List<String> features,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 28),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward, color: Colors.grey[400]),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: features
                  .map(
                    (feature) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        feature,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
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

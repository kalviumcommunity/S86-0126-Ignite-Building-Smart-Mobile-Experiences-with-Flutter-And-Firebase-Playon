import 'package:flutter/material.dart';

// ===== STATELESS WIDGET =====
/// A StatelessWidget that displays a static header/title
/// This widget does not change its UI unless rebuilt by a parent widget
class AppHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AppHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// A simple StatelessWidget for displaying static information
class InfoCard extends StatelessWidget {
  final String label;
  final String value;
  final Color backgroundColor;

  const InfoCard({
    super.key,
    required this.label,
    required this.value,
    this.backgroundColor = Colors.lightBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ===== STATEFUL WIDGET =====
/// A StatefulWidget that manages an interactive counter
/// This widget maintains internal state that changes on user interaction
class InteractiveCounter extends StatefulWidget {
  const InteractiveCounter({super.key});

  @override
  State<InteractiveCounter> createState() => _InteractiveCounterState();
}

class _InteractiveCounterState extends State<InteractiveCounter> {
  int _count = 0;
  bool _isDarkMode = false;

  void _incrementCounter() {
    setState(() {
      _count++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_count > 0) {
        _count--;
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _count = 0;
    });
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        _isDarkMode ? Colors.grey[800] : Colors.lightBlue[50];
    final textColor = _isDarkMode ? Colors.white : Colors.black87;
    final buttonColor =
        _isDarkMode ? Colors.orange : Colors.blue;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: buttonColor.withOpacity(0.5),
          width: 2,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Counter Display
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            decoration: BoxDecoration(
              color: buttonColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  'Counter Value',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textColor.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '$_count',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: buttonColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Control Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _decrementCounter,
                icon: const Icon(Icons.remove),
                label: const Text('Decrease'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
              ElevatedButton.icon(
                onPressed: _resetCounter,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                ),
              ),
              ElevatedButton.icon(
                onPressed: _incrementCounter,
                icon: const Icon(Icons.add),
                label: const Text('Increase'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Theme Toggle
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _isDarkMode ? '🌙 Dark Mode' : '☀️ Light Mode',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                Switch(
                  value: _isDarkMode,
                  onChanged: (value) {
                    _toggleDarkMode();
                  },
                  activeThumbColor: Colors.orange,
                  inactiveThumbColor: Colors.blue,
                ),
              ],
            ),
          ),

          // Status Message
          const SizedBox(height: 20),
          Text(
            _count > 10
                ? '🎉 Count is above 10!'
                : _count > 5
                    ? '👍 You\'re making progress!'
                    : _count > 0
                        ? '⬆️ Keep clicking to reach 10!'
                        : '🚀 Click to start counting!',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ===== MAIN DEMO SCREEN =====
/// Main screen combining StatelessWidget and StatefulWidget
class StatelessStatefulDemo extends StatelessWidget {
  const StatelessStatefulDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateless vs Stateful Widgets'),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // STATELESS WIDGET: Header
              const AppHeader(
                title: 'Interactive Counter App',
                subtitle:
                    'Explore Stateless & Stateful Widgets',
              ),
              const SizedBox(height: 32),

              // Info about Stateless Widgets (using StatelessWidget)
              const InfoCard(
                label: '📌 STATELESS WIDGET',
                value: 'Static & Immutable',
                backgroundColor: Colors.blue,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue, width: 1),
                ),
                child: const Text(
                  '✓ Does not store mutable state\n✓ Remains unchanged until rebuilt by parent\n✓ Ideal for static UI like labels, icons, headers\n✓ More performant for static content',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // STATEFUL WIDGET: Interactive Counter
              const InteractiveCounter(),
              const SizedBox(height: 32),

              // Info about Stateful Widgets (using StatelessWidget)
              const InfoCard(
                label: '⚙️ STATEFUL WIDGET',
                value: 'Dynamic & Interactive',
                backgroundColor: Colors.green,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green, width: 1),
                ),
                child: const Text(
                  '✓ Maintains mutable state during lifecycle\n✓ Updates UI dynamically via setState()\n✓ Responds to user interactions\n✓ Supports animations and real-time changes',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Summary
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.purple, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Key Takeaway',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Use StatelessWidget for UI elements that don\'t change, and StatefulWidget for components that need to react to user input or update dynamically. Combining both creates efficient and responsive Flutter apps! 🚀',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

// ===== HOT RELOAD DEMO SCREEN =====
/// This screen demonstrates Hot Reload functionality with interactive elements
/// and debug logging to showcase Debug Console usage.
///
/// Try modifying:
/// - Colors, text, or button labels → Save and Hot Reload to see instant changes
/// - Add new widgets → Hot Reload rebuilds without losing state
/// - Change styling or layout → Observe real-time updates
class HotReloadDemoScreen extends StatefulWidget {
  const HotReloadDemoScreen({super.key});

  @override
  State<HotReloadDemoScreen> createState() => _HotReloadDemoScreenState();
}

class _HotReloadDemoScreenState extends State<HotReloadDemoScreen>
    with WidgetsBindingObserver {
  int _clickCount = 0;
  int _colorIndex = 0;
  bool _showExtraContent = false;
  double _sliderValue = 0.5;
  String _userMessage = 'Welcome to Hot Reload Demo!';

  // List of colors to cycle through
  final List<Color> _colors = [
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.teal,
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    debugPrint('🚀 [HOT RELOAD DEMO] Screen initialized');
    debugPrint('📊 Initial state: clickCount=$_clickCount, colorIndex=$_colorIndex');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    debugPrint('🔌 [HOT RELOAD DEMO] Screen disposed');
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint('📱 [LIFECYCLE] App state changed to: $state');
  }

  void _incrementCounter() {
    setState(() {
      _clickCount++;
      _userMessage = 'You clicked $_clickCount times!';
      debugPrint('✅ [BUTTON CLICK] Counter incremented to: $_clickCount');
    });
  }

  void _changeColor() {
    setState(() {
      _colorIndex = (_colorIndex + 1) % _colors.length;
      debugPrint('🎨 [COLOR CHANGE] Color changed to: ${_colors[_colorIndex]}');
    });
  }

  void _resetCounter() {
    setState(() {
      _clickCount = 0;
      _colorIndex = 0;
      _showExtraContent = false;
      _sliderValue = 0.5;
      _userMessage = 'Welcome to Hot Reload Demo!';
      debugPrint('🔄 [RESET] All state values reset to initial state');
    });
  }

  void _toggleExtraContent() {
    setState(() {
      _showExtraContent = !_showExtraContent;
      debugPrint(
          '👁️ [VISIBILITY TOGGLE] Extra content is now: ${_showExtraContent ? 'VISIBLE' : 'HIDDEN'}');
    });
  }

  void _updateSlider(double value) {
    setState(() {
      _sliderValue = value;
      debugPrint(
          '📈 [SLIDER UPDATE] Slider value changed to: ${value.toStringAsFixed(2)}');
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('🔨 [BUILD] Rebuilding HotReloadDemoScreen widget');

    return Scaffold(
      appBar: AppBar(
        title: const Text('🔥 Hot Reload Demo'),
        centerTitle: true,
        elevation: 4,
        backgroundColor: _colors[_colorIndex],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _colors[_colorIndex].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _colors[_colorIndex],
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Hot Reload Demonstration',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Try modifying the code and saving to see instant updates!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Main Counter Display
              _buildCounterSection(),
              const SizedBox(height: 24),

              // Interactive Buttons
              _buildButtonsSection(),
              const SizedBox(height: 24),

              // Color and Theme Section
              _buildColorSection(),
              const SizedBox(height: 24),

              // Slider Section
              _buildSliderSection(),
              const SizedBox(height: 24),

              // Toggle Extra Content
              _buildToggleSection(),
              const SizedBox(height: 24),

              // Extra Content (conditionally shown)
              if (_showExtraContent) ...[
                _buildExtraContentSection(),
                const SizedBox(height: 24),
              ],

              // Debug Info Section
              _buildDebugInfoSection(),
              const SizedBox(height: 24),

              // Tips Section
              _buildTipsSection(),
            ],
          ),
        ),
      ),
    );
  }

  // ===== UI BUILDER METHODS =====

  Widget _buildCounterSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _colors[_colorIndex].withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _colors[_colorIndex],
          width: 2,
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Click Counter',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            decoration: BoxDecoration(
              color: _colors[_colorIndex],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$_clickCount',
              style: const TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _userMessage,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: _colors[_colorIndex],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildButtonsSection() {
    return Column(
      children: [
        const Text(
          'Interactive Buttons',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: _incrementCounter,
              icon: const Icon(Icons.add),
              label: const Text('Click Me!'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _changeColor,
              icon: const Icon(Icons.palette),
              label: const Text('Change Color'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _colors[_colorIndex],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: _resetCounter,
          icon: const Icon(Icons.refresh),
          label: const Text('Reset All'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColorSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: _colors[_colorIndex],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Current Theme Color',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Color index: $_colorIndex / ${_colors.length - 1}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dynamic Slider (Try adjusting and using Hot Reload)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.amber[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.amber[200]!,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Slider(
                value: _sliderValue,
                onChanged: _updateSlider,
                min: 0,
                max: 1,
                activeColor: Colors.amber[700],
                inactiveColor: Colors.amber[200],
              ),
              const SizedBox(height: 8),
              Text(
                'Value: ${(_sliderValue * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.amber[900],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildToggleSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.purple[200]!,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Show Extra Content',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.purple[900],
            ),
          ),
          Switch(
            value: _showExtraContent,
            onChanged: (_) => _toggleExtraContent(),
            activeColor: Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildExtraContentSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.teal[300]!,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.star,
            size: 48,
            color: Colors.teal,
          ),
          const SizedBox(height: 12),
          const Text(
            'Extra Content Section',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This section appeared through Hot Reload! Try toggling it on/off and saving the file to see how state is preserved.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Hot Reload preserves your app state while updating the UI!',
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Colors.teal,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDebugInfoSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Debug Console Output',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.green,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.black,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _debugLine('✅ App Initialized'),
                  _debugLine('🔨 Build: ${DateTime.now().toString().split('.')[0]}'),
                  _debugLine('🎯 Click Count: $_clickCount'),
                  _debugLine('🎨 Color Index: $_colorIndex'),
                  _debugLine('👁️ Extra Content: ${_showExtraContent ? 'VISIBLE' : 'HIDDEN'}'),
                  _debugLine('📈 Slider Value: ${(_sliderValue * 100).toStringAsFixed(0)}%'),
                  _debugLine(
                      '💭 Message: "${_userMessage.length} characters"'),
                  _debugLine('>>> Check Debug Console for detailed logs'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _debugLine(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.green,
        fontSize: 11,
        fontFamily: 'monospace',
      ),
    );
  }

  Widget _buildTipsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.blue[300]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '💡 Hot Reload Tips',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 12),
          _tipItem(
            '1. Press "r" in the terminal or use the Hot Reload button',
            'Apply code changes without restarting the app',
          ),
          _tipItem(
            '2. Hot Reload preserves app state',
            'Your counter, toggles, and other state values persist',
          ),
          _tipItem(
            '3. Check the Debug Console for logs',
            'Open the Debug tab to see print() and debugPrint() output',
          ),
          _tipItem(
            '4. Hot Reload works best for UI changes',
            'State initialization changes may require Hot Restart',
          ),
          _tipItem(
            '5. Use DevTools for deeper inspection',
            'Inspect the widget tree, check performance, and analyze memory',
          ),
        ],
      ),
    );
  }

  Widget _tipItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}

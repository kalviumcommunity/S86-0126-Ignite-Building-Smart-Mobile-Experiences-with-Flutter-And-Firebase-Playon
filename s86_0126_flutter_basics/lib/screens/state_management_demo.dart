import 'package:flutter/material.dart';

class StateManagementDemo extends StatefulWidget {
  const StateManagementDemo({super.key});

  @override
  State<StateManagementDemo> createState() => _StateManagementDemoState();
}

class _StateManagementDemoState extends State<StateManagementDemo> {
  // ===== STATE VARIABLES =====
  int _counter = 0;
  int _score = 0;
  double _opacity = 1.0;
  bool _isFavorite = false;
  List<String> _items = ['Item 1', 'Item 2', 'Item 3'];
  List<bool> _itemStates = [false, false, false];

  // ===== STATE MANAGEMENT METHODS =====

  void _incrementCounter() {
    setState(() {
      _counter++;
      _updateScore();
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
        _updateScore();
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _score = 0;
      _opacity = 1.0;
      _itemStates = [false, false, false];
    });
  }

  void _updateScore() {
    // Score increases exponentially with counter
    setState(() {
      _score = _counter * _counter;
      _opacity = (100 - (_counter * 5)) / 100;
      if (_opacity < 0.2) _opacity = 0.2;
    });
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  void _toggleItem(int index) {
    setState(() {
      _itemStates[index] = !_itemStates[index];
    });
  }

  // ===== BUILD METHOD =====

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('State Management Demo'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(isTablet ? 32 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== HEADER SECTION =====
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  border: Border.all(color: Colors.purple[200]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.refresh, color: Colors.purple[700]),
                        const SizedBox(width: 12),
                        Text(
                          'Local State Management',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[900],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Watch how setState() makes your UI responsive! Change state values and see the interface update in real-time.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.purple[800],
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ===== MAIN COUNTER SECTION =====
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple[300]!, Colors.deepPurple[600]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Tournament Button Press Counter',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '$_counter',
                            style: const TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Presses',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _decrementCounter,
                          icon: const Icon(Icons.remove),
                          label: const Text('Decrease'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: _incrementCounter,
                          icon: const Icon(Icons.add),
                          label: const Text('Increase'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ===== SCORE DISPLAY SECTION =====
              Text(
                'Real-time Score Updates',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  border: Border.all(color: Colors.orange[300]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Score',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.orange[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$_score points',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[700],
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.star,
                      size: 48,
                      color: Colors.orange[500],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ===== CONDITIONAL UI SECTION =====
              Text(
                'Conditional UI Updates (State-Driven)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _counter >= 5
                      ? Colors.green[50]
                      : _counter >= 3
                          ? Colors.amber[50]
                          : Colors.red[50],
                  border: Border.all(
                    color: _counter >= 5
                        ? Colors.green[300]!
                        : _counter >= 3
                            ? Colors.amber[300]!
                            : Colors.red[300]!,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Status',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: _counter >= 5
                                ? Colors.green[800]
                                : _counter >= 3
                                    ? Colors.amber[800]
                                    : Colors.red[800],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _counter >= 5
                                ? Colors.green
                                : _counter >= 3
                                    ? Colors.amber
                                    : Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _counter >= 5
                                ? 'Excellent!'
                                : _counter >= 3
                                    ? 'Good'
                                    : 'Start',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _counter >= 5
                          ? '🎉 Amazing! You\'ve reached excellent status!'
                          : _counter >= 3
                              ? '👍 Good progress! Keep tapping to reach excellent!'
                              : '🚀 Tap the button to get started!',
                      style: TextStyle(
                        fontSize: 13,
                        color: _counter >= 5
                            ? Colors.green[800]
                            : _counter >= 3
                                ? Colors.amber[800]
                                : Colors.red[800],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ===== OPACITY INDICATOR SECTION =====
              Text(
                'Dynamic Opacity (Visual Feedback)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Opacity(
                  opacity: _opacity,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.visibility,
                          size: 32,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Opacity: ${(_opacity * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Decreases as counter increases',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ===== FAVORITE TOGGLE SECTION =====
              Text(
                'Interactive State Toggle',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _toggleFavorite,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _isFavorite ? Colors.pink[50] : Colors.grey[100],
                    border: Border.all(
                      color: _isFavorite ? Colors.pink[300]! : Colors.grey[300]!,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mark Tournament as Favorite',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        size: 28,
                        color: _isFavorite ? Colors.pink : Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ===== LIST ITEMS SECTION =====
              Text(
                'Managing List State',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 12),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: _itemStates[index]
                          ? Colors.green[50]
                          : Colors.grey[100],
                      border: Border.all(
                        color: _itemStates[index]
                            ? Colors.green[300]!
                            : Colors.grey[300]!,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CheckboxListTile(
                      value: _itemStates[index],
                      onChanged: (value) => _toggleItem(index),
                      title: Text(
                        _items[index],
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: _itemStates[index]
                              ? Colors.green[800]
                              : Colors.grey[800],
                        ),
                      ),
                      activeColor: Colors.green,
                      checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // ===== RESET BUTTON SECTION =====
              Center(
                child: ElevatedButton.icon(
                  onPressed: _resetCounter,
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('Reset All State'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ===== INFO BOX =====
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.cyan[50],
                  border: Border.all(color: Colors.cyan[200]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: Colors.cyan[700]),
                        const SizedBox(width: 12),
                        Text(
                          'About setState()',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan[900],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '✓ setState() rebuilds the widget when state changes\n'
                      '✓ Only affected parts of the UI update (efficient)\n'
                      '✓ Never call setState() inside build() method\n'
                      '✓ Local state is scoped to the StatefulWidget\n'
                      '✓ Multiple setState() calls can be batched\n'
                      '✓ This is local state management (StatefulWidget)\n'
                      '✓ For complex apps, use Provider, Riverpod, or GetX',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.cyan[800],
                        height: 1.8,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

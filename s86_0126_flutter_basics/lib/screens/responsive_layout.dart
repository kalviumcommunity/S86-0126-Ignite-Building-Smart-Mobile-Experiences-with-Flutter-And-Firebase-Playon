import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Determine device type
    final isTablet = screenWidth > 600;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Layout Design'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(isTablet ? 24 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ===== HEADER SECTION =====
              Container(
                width: double.infinity,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Header Section',
                      style: TextStyle(
                        fontSize: isTablet ? 28 : 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Screen Width: ${screenWidth.toStringAsFixed(0)}px | ${isTablet ? "📱 Tablet Mode" : "📱 Mobile Mode"}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ===== MAIN CONTENT: ADAPTIVE LAYOUT =====
              LayoutBuilder(
                builder: (context, constraints) {
                  // Tablet or Landscape: Two-Column Layout
                  if (isTablet || isLandscape) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Panel
                        Expanded(
                          child: _buildCard(
                            title: 'Left Panel',
                            icon: Icons.view_list,
                            color: Colors.amber,
                            content:
                                'This is the left panel.\nIt displays on tablets and landscape mode.',
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Right Panel
                        Expanded(
                          child: _buildCard(
                            title: 'Right Panel',
                            icon: Icons.view_stream,
                            color: Colors.teal,
                            content:
                                'This is the right panel.\nResponsive layout adapts to screen size.',
                          ),
                        ),
                      ],
                    );
                  }

                  // Mobile: Single Column Layout
                  return Column(
                    children: [
                      _buildCard(
                        title: 'Content Panel 1',
                        icon: Icons.article,
                        color: Colors.amber,
                        content:
                            'This is the first content panel.\nOn mobile, panels stack vertically.',
                      ),
                      const SizedBox(height: 16),
                      _buildCard(
                        title: 'Content Panel 2',
                        icon: Icons.article,
                        color: Colors.teal,
                        content:
                            'This is the second content panel.\nScroll to see more content.',
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),

              // ===== FEATURES SECTION =====
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  border: Border.all(color: Colors.blue[200]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.blue[600]),
                        const SizedBox(width: 12),
                        Text(
                          'Layout Features',
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
                      '✓ Container: Flexible box with padding & styling\n'
                      '✓ Row: Horizontal arrangement of widgets\n'
                      '✓ Column: Vertical stacking of widgets\n'
                      '✓ MediaQuery: Responsive to screen size\n'
                      '✓ Expanded: Fills available space\n'
                      '✓ LayoutBuilder: Adaptive layouts',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blue[800],
                        height: 1.8,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ===== GRID LAYOUT SHOWCASE =====
              Text(
                'Responsive Grid',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 12),
              LayoutBuilder(
                builder: (context, constraints) {
                  int columns = isTablet ? 4 : 2;
                  double itemWidth = (constraints.maxWidth - (columns - 1) * 8) / columns;

                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(
                      6,
                      (index) => Container(
                        width: itemWidth,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.primaries[index % Colors.primaries.length],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'Item ${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // ===== STATISTICS CARDS =====
              Text(
                'Screen Statistics',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 12),
              LayoutBuilder(
                builder: (context, constraints) {
                  int columns = isTablet ? 4 : 2;
                  return GridView.count(
                    crossAxisCount: columns,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: [
                      _buildStatCard(
                        'Width',
                        '${screenWidth.toStringAsFixed(0)}px',
                        Colors.blue,
                      ),
                      _buildStatCard(
                        'Height',
                        '${screenHeight.toStringAsFixed(0)}px',
                        Colors.green,
                      ),
                      _buildStatCard(
                        'Device Type',
                        isTablet ? 'Tablet' : 'Mobile',
                        Colors.purple,
                      ),
                      _buildStatCard(
                        'Orientation',
                        isLandscape ? 'Landscape' : 'Portrait',
                        Colors.orange,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),

              // ===== ACTION BUTTONS =====
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Layout is responsive!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      icon: const Icon(Icons.check),
                      label: const Text('Verify Responsive'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Back'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Reusable Card Widget
  Widget _buildCard({
    required String title,
    required IconData icon,
    required Color color,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  /// Reusable Statistics Card Widget
  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

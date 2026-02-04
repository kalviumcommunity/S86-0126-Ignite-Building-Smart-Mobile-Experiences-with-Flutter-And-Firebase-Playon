import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AssetDemoScreen extends StatelessWidget {
  const AssetDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets Demo'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Section 1: Introduction
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.indigo[400]!, Colors.indigo[600]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Managing Assets in Flutter',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Learn how to add, register, and display images, icons, and local assets',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Section 2: Local Images
                Text(
                  '1. Local Images (Image.asset)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo[800],
                  ),
                ),
                const SizedBox(height: 12),
                
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.indigo[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      // Try to load local image, with fallback
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[100],
                        ),
                        child: _buildImageWidget('assets/images/logo.png'),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Logo Image (Image.asset)',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.indigo[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[100],
                        ),
                        child: _buildImageWidget('assets/images/banner.jpg'),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Banner Image (JPG)',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Section 3: Images as Background
                Text(
                  '2. Images as Background Decoration',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo[800],
                  ),
                ),
                const SizedBox(height: 12),
                
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.indigo[300]!),
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Background Image with Text Overlay',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Section 4: Built-in Icons
                Text(
                  '3. Flutter Built-in Icons',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo[800],
                  ),
                ),
                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.indigo[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      // Material Icons
                      const Text(
                        'Material Icons',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 40),
                              const SizedBox(height: 4),
                              const Text('Star', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.sports, color: Colors.green, size: 40),
                              const SizedBox(height: 4),
                              const Text('Sports', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.people, color: Colors.blue, size: 40),
                              const SizedBox(height: 4),
                              const Text('People', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.location_on, color: Colors.red, size: 40),
                              const SizedBox(height: 4),
                              const Text('Location', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Cupertino Icons
                      const Text(
                        'Cupertino Icons (iOS-style)',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Icon(CupertinoIcons.heart, color: Colors.red, size: 40),
                              const SizedBox(height: 4),
                              const Text('Heart', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(CupertinoIcons.star, color: Colors.amber, size: 40),
                              const SizedBox(height: 4),
                              const Text('Star', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(CupertinoIcons.person, color: Colors.purple, size: 40),
                              const SizedBox(height: 4),
                              const Text('Person', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(CupertinoIcons.bell, color: Colors.orange, size: 40),
                              const SizedBox(height: 4),
                              const Text('Bell', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Section 5: Custom Icons
                Text(
                  '4. Custom Local Icons',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo[800],
                  ),
                ),
                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.indigo[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[100],
                            ),
                            child: _buildImageWidget('assets/icons/star.png'),
                          ),
                          const SizedBox(height: 8),
                          const Text('Star Icon', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[100],
                            ),
                            child: _buildImageWidget('assets/icons/profile.png'),
                          ),
                          const SizedBox(height: 8),
                          const Text('Profile Icon', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Section 6: Asset Configuration Info
                Text(
                  '5. Asset Configuration (pubspec.yaml)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo[800],
                  ),
                ),
                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[700]!),
                  ),
                  child: const Text(
                    '''flutter:
  assets:
    - assets/images/
    - assets/icons/''',
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Section 7: Key Learnings
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green[300]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green[700]),
                          const SizedBox(width: 8),
                          Text(
                            'Key Learnings',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[900],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildLearningPoint('1. Assets must be registered in pubspec.yaml under flutter:'),
                      _buildLearningPoint('2. Use Image.asset() to display local images'),
                      _buildLearningPoint('3. Use AssetImage() for background decorations'),
                      _buildLearningPoint('4. Flutter provides 1000+ Material Icons built-in'),
                      _buildLearningPoint('5. Cupertino Icons provide iOS-style icons'),
                      _buildLearningPoint('6. Run "flutter pub get" after adding new assets'),
                      _buildLearningPoint('7. Proper YAML indentation (2 spaces) is critical'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Section 8: Common Errors
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red[300]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.warning, color: Colors.red[700]),
                          const SizedBox(width: 8),
                          Text(
                            'Common Errors to Avoid',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red[900],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildErrorPoint('❌ Incorrect file paths - ensure exact matches'),
                      _buildErrorPoint('❌ Improper YAML indentation (use 2 spaces)'),
                      _buildErrorPoint('❌ Unregistered folders in pubspec.yaml'),
                      _buildErrorPoint('❌ Hot reload not refreshing new assets'),
                      _buildErrorPoint('❌ Missing file extensions in paths'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Section 9: Best Practices
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue[300]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.lightbulb, color: Colors.blue[700]),
                          const SizedBox(width: 8),
                          Text(
                            'Best Practices',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildPracticePoint('✓ Organize assets in logical folders (images/, icons/, fonts/)'),
                      _buildPracticePoint('✓ Use descriptive file names for easy identification'),
                      _buildPracticePoint('✓ Provide multiple image sizes for different screen densities'),
                      _buildPracticePoint('✓ Use appropriate file formats (PNG for icons, JPG for photos)'),
                      _buildPracticePoint('✓ Register entire folders in pubspec.yaml for scalability'),
                      _buildPracticePoint('✓ Always run "flutter pub get" after asset changes'),
                      _buildPracticePoint('✓ Test assets on different device sizes and orientations'),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageWidget(String imagePath) {
    return Image.asset(
      imagePath,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Make the error UI small and flexible to avoid RenderFlex overflow
        return Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.image_not_supported, color: Colors.grey, size: 36),
                const SizedBox(height: 6),
                Text(
                  'Image not loaded\n$imagePath',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLearningPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check, color: Colors.green[700], size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: Colors.green[900],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          color: Colors.red[900],
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildPracticePoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          color: Colors.blue[900],
          height: 1.4,
        ),
      ),
    );
  }
}

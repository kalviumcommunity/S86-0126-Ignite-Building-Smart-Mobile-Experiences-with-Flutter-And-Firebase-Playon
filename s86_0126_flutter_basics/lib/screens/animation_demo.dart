import 'package:flutter/material.dart';

class AnimationDemoScreen extends StatefulWidget {
  const AnimationDemoScreen({super.key});

  @override
  State<AnimationDemoScreen> createState() => _AnimationDemoScreenState();
}

class _AnimationDemoScreenState extends State<AnimationDemoScreen>
    with TickerProviderStateMixin {
  // Implicit Animation Variables
  bool _containerToggled = false;
  bool _opacityToggled = false;

  // Explicit Animation Controllers
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    debugPrint('🎬 [ANIMATION] AnimationDemoScreen initialized');

    // Initialize all animation controllers
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _slideController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _toggleContainer() {
    setState(() {
      _containerToggled = !_containerToggled;
    });
    debugPrint('🎨 [ANIMATION] Container toggled: $_containerToggled');
  }

  void _toggleOpacity() {
    setState(() {
      _opacityToggled = !_opacityToggled;
    });
    debugPrint('👻 [ANIMATION] Opacity toggled: $_opacityToggled');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animations & Transitions'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple[400]!, Colors.purple[600]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Animations & Transitions',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Explore implicit and explicit animations for smoother UX',
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

                // Section 1: Implicit Animations
                Text(
                  '1. Implicit Animations (Automatic)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[800],
                  ),
                ),
                const SizedBox(height: 12),

                // AnimatedContainer Demo
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'AnimatedContainer - Size & Color Change',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOut,
                          width: _containerToggled ? 200 : 100,
                          height: _containerToggled ? 100 : 200,
                          decoration: BoxDecoration(
                            color:
                                _containerToggled ? Colors.teal : Colors.orange,
                            borderRadius: BorderRadius.circular(
                                _containerToggled ? 20 : 10),
                            boxShadow: [
                              BoxShadow(
                                color: (_containerToggled
                                        ? Colors.teal
                                        : Colors.orange)
                                    .withOpacity(0.5),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              _containerToggled ? 'Changed!' : 'Tap Me!',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _toggleContainer,
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Animate Container'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // AnimatedOpacity Demo
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'AnimatedOpacity - Fade In/Out',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: AnimatedOpacity(
                          opacity: _opacityToggled ? 1.0 : 0.2,
                          duration: const Duration(milliseconds: 800),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.blue),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.favorite,
                                  size: 48,
                                  color: Colors.red,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _opacityToggled
                                      ? 'Fully Visible'
                                      : 'Faded Out',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _toggleOpacity,
                        icon: const Icon(Icons.visibility),
                        label: const Text('Toggle Opacity'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Section 2: Explicit Animations
                Text(
                  '2. Explicit Animations (Controlled)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[800],
                  ),
                ),
                const SizedBox(height: 12),

                // RotationTransition Demo
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'RotationTransition - Continuous Rotation',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: RotationTransition(
                          turns: _rotationController,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.cyan[400]!, Colors.cyan[700]!],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.sports,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Rotating at 2x per second',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // ScaleTransition Demo
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'ScaleTransition - Pulsing Effect',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: ScaleTransition(
                          scale: Tween<double>(begin: 0.5, end: 1.0)
                              .animate(_scaleController),
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.green[400],
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green[400]!.withOpacity(0.5),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.star,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Pulsing in and out',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // SlideTransition Demo
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'SlideTransition - Horizontal Slide',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(-1, 0),
                            end: const Offset(1, 0),
                          ).animate(_slideController),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.pink[400],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.rocket_launch,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Sliding left and right',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // PulseTransition Demo (Custom with opacity and scale)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Combined Animation - Pulse with Glow',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: ScaleTransition(
                          scale: Tween<double>(begin: 0.8, end: 1.2)
                              .animate(_pulseController),
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.indigo[400],
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.indigo[400]!.withOpacity(0.7),
                                  blurRadius: 30,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.notifications,
                                size: 60,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Growing and shrinking continuously',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Section 3: Page Transitions
                Text(
                  '3. Page Transitions & Navigation',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[800],
                  ),
                ),
                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Try Different Page Transitions',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              _navigateWithSlideTransition();
                            },
                            icon: const Icon(Icons.arrow_forward),
                            label: const Text('Slide'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              _navigateWithFadeTransition();
                            },
                            icon: const Icon(Icons.opacity),
                            label: const Text('Fade'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              _navigateWithScaleTransition();
                            },
                            icon: const Icon(Icons.zoom_in),
                            label: const Text('Scale'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              _navigateWithRotateTransition();
                            },
                            icon: const Icon(Icons.rotate_right),
                            label: const Text('Rotate'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Section 4: Animation Best Practices
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
                      _buildPracticePoint(
                          '✓ Keep animations between 200-800ms for responsiveness'),
                      _buildPracticePoint(
                          '✓ Use Curves.easeInOut or Curves.fastOutSlowIn for natural motion'),
                      _buildPracticePoint(
                          '✓ Avoid excessive or flashy effects that distract users'),
                      _buildPracticePoint(
                          '✓ Always test animations on multiple devices for performance'),
                      _buildPracticePoint(
                          '✓ Dispose of AnimationControllers in dispose() method'),
                      _buildPracticePoint(
                          '✓ Use implicit animations for simple property changes'),
                      _buildPracticePoint(
                          '✓ Use explicit animations for complex or custom effects'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Section 5: Why Animations Matter
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
                            'Why Animations Matter',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[900],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildBenefitPoint(
                          '🎯 Guide user attention to important elements'),
                      _buildBenefitPoint(
                          '🎨 Make transitions feel natural and polished'),
                      _buildBenefitPoint(
                          '✋ Provide visual feedback to interactions'),
                      _buildBenefitPoint(
                          '⚡ Increase perceived performance and responsiveness'),
                      _buildBenefitPoint(
                          '😊 Improve overall user experience and engagement'),
                      _buildBenefitPoint(
                          '🏆 Create professional, production-ready apps'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Section 6: Animation Types Reference
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.amber[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.amber[300]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info, color: Colors.amber[700]),
                          const SizedBox(width: 8),
                          Text(
                            'Animation Types Reference',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber[900],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildTypePoint('Implicit Animations',
                          'AnimatedContainer, AnimatedOpacity, AnimatedAlign\n- No manual controller needed\n- Simple property changes'),
                      const SizedBox(height: 12),
                      _buildTypePoint('Explicit Animations',
                          'AnimationController + RotationTransition, ScaleTransition\n- Full control over animation\n- Complex custom effects'),
                      const SizedBox(height: 12),
                      _buildTypePoint('Page Transitions',
                          'PageRouteBuilder with transitions\n- Slide, Fade, Scale, Rotate effects\n- Navigate with style'),
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

  void _navigateWithSlideTransition() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _AnimatedPage(title: 'Slide Transition'),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            )),
            child: child,
          );
        },
      ),
    );
  }

  void _navigateWithFadeTransition() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _AnimatedPage(title: 'Fade Transition'),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  void _navigateWithScaleTransition() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _AnimatedPage(title: 'Scale Transition'),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
      ),
    );
  }

  void _navigateWithRotateTransition() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _AnimatedPage(title: 'Rotate Transition'),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return RotationTransition(
            turns: animation,
            child: child,
          );
        },
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

  Widget _buildBenefitPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          color: Colors.green[900],
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildTypePoint(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.amber[900],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            fontSize: 12,
            color: Colors.amber[800],
            height: 1.3,
          ),
        ),
      ],
    );
  }
}

// Animated Page Demo
class _AnimatedPage extends StatelessWidget {
  final String title;

  const _AnimatedPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple[400]!, Colors.purple[700]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple[400]!.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.favorite,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Page animated with smooth transition!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResponsiveWelcomeScreen(),
    );
  }
}

class ResponsiveWelcomeScreen extends StatefulWidget {
  const ResponsiveWelcomeScreen({super.key});

  @override
  State<ResponsiveWelcomeScreen> createState() =>
      _ResponsiveWelcomeScreenState();
}

class _ResponsiveWelcomeScreenState extends State<ResponsiveWelcomeScreen> {
  bool clicked = false;

  void toggleText() {
    setState(() {
      clicked = !clicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Welcome'),
      ),
      body: Padding(
        padding: EdgeInsets.all(isTablet ? 24 : 16),
        child: isTablet ? tabletLayout() : mobileLayout(),
      ),
    );
  }

  /// Layout for mobile screens
  Widget mobileLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        welcomeText(),
        const SizedBox(height: 20),
        const Icon(Icons.flutter_dash, size: 80),
        const SizedBox(height: 20),
        actionButton(),
      ],
    );
  }

  /// Layout for larger screens / tablets
  Widget tabletLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: const Icon(Icons.flutter_dash, size: 120),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              welcomeText(),
              const SizedBox(height: 20),
              actionButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget welcomeText() {
    return Text(
      clicked ? 'Button Clicked!' : 'Hello Flutter',
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget actionButton() {
    return ElevatedButton(
      onPressed: toggleText,
      child: const Text('Click Me'),
    );
  }
}
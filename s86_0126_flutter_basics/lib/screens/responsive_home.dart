import 'package:flutter/material.dart';

class ResponsiveHome extends StatefulWidget {
  const ResponsiveHome({super.key});

  @override
  State<ResponsiveHome> createState() => _ResponsiveHomeState();
}

class _ResponsiveHomeState extends State<ResponsiveHome> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    // MediaQuery to get screen size
    final double screenWidth = MediaQuery.of(context).size.width;
    // final double screenHeight = MediaQuery.of(context).size.height;

    // Check if device is tablet
    final bool isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Home'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(isTablet ? 24 : 16),
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                isTablet ? 'Tablet Layout' : 'Mobile Layout',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isTablet ? 28 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Main Content Section
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Tablet: two-column layout
                  if (isTablet) {
                    return Row(
                      children: [
                        Expanded(child: buildCard('Section 1')),
                        const SizedBox(width: 16),
                        Expanded(child: buildCard('Section 2')),
                      ],
                    );
                  }

                  // Mobile: single-column layout
                  return Column(
                    children: [
                      Expanded(child: buildCard('Section 1')),
                      const SizedBox(height: 16),
                      Expanded(child: buildCard('Section 2')),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Footer / Button Section
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isClicked = !isClicked;
                  });
                },
                child: Text(
                  isClicked ? 'Clicked' : 'Click Me',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Card Widget
  Widget buildCard(String title) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: FittedBox(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

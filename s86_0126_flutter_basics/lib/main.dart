import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

import 'screens/auth_screen.dart';
import 'screens/hot_reload_demo.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/second_screen.dart';
import 'screens/stateless_stateful_demo.dart';
import 'screens/responsive_layout.dart';
import 'screens/scrollable_views.dart';
import 'screens/user_input_form.dart';
import 'screens/state_management_demo.dart';
import 'screens/asset_demo.dart';
import 'screens/animation_demo.dart';
import 'screens/tasks_screen.dart';
import 'screens/query_demo_screen.dart';
// import 'screens/widget_tree_demo.dart';
// import 'screens/responsive_home.dart'; // keep for later use if needed

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Fundamentals Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Connection state handling
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          // If user is logged in, show HomeScreen
          if (snapshot.hasData) {
            return const HomeScreen();
          }

          // If user is not logged in, show AuthScreen
          return const AuthScreen();
        },
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/hot-reload': (context) => const HotReloadDemoScreen(),
        '/stateless-stateful': (context) => const StatelessStatefulDemo(),
        '/second': (context) => const SecondScreen(),
        '/responsive-layout': (context) => const ResponsiveLayout(),
        '/scrollable-views': (context) => const ScrollableViews(),
        '/user-input': (context) => const UserInputForm(),
        '/state-management': (context) => const StateManagementDemo(),
        '/asset-demo': (context) => const AssetDemoScreen(),
        '/animation-demo': (context) => const AnimationDemoScreen(),
        '/tasks': (context) => const TasksScreen(),
        '/queries': (context) => const QueryDemoScreen(),
      },
    );
  }
}

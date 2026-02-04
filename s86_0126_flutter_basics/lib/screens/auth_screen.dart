import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

/// Auth Screen that toggles between Login and Signup screens
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoginMode = true;

  void _toggleMode() {
    setState(() {
      _isLoginMode = !_isLoginMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoginMode
        ? LoginScreen(onToggleMode: _toggleMode)
        : SignupScreen(onToggleMode: _toggleMode);
  }
}

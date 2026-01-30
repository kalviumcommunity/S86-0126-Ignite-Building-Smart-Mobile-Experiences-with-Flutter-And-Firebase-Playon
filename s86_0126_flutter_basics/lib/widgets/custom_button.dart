import 'package:flutter/material.dart';

/// A reusable custom button widget with customizable label, color, and callback.
/// This widget reduces code duplication across multiple screens.
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final double borderRadius;
  final double padding;
  final bool isOutlined;
  final IconData? icon;

  const CustomButton({
    required this.label,
    required this.onPressed,
    this.color = Colors.teal,
    this.borderRadius = 12.0,
    this.padding = 16.0,
    this.isOutlined = false,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return OutlinedButton.icon(
        onPressed: onPressed,
        icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          padding: EdgeInsets.symmetric(
            horizontal: padding,
            vertical: padding / 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      );
    }

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: padding,
          vertical: padding / 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

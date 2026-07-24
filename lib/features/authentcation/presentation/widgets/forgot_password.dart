import 'package:flutter/material.dart';
import 'auth_colors.dart';

/// Right-aligned "Forgot Password?" link shown under the password field.
class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 32),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            color: AuthColors.primary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
            decorationColor: AuthColors.primary,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'auth_colors.dart';

/// "Don't have an account? Sign Up" prompt with a tappable "Sign Up".
class SignUpText extends StatelessWidget {
  const SignUpText({super.key, required this.onSignUpTap});

  final VoidCallback onSignUpTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: AuthColors.textSecondary,
            fontSize: 13,
          ),
          children: [
            const TextSpan(text: "Don't have an account? "),
            TextSpan(
              text: 'Sign Up',
              style: const TextStyle(
                color: AuthColors.primary,
                fontWeight: FontWeight.w700,
              ),
              recognizer: TapGestureRecognizer()..onTap = onSignUpTap,
            ),
          ],
        ),
      ),
    );
  }
}

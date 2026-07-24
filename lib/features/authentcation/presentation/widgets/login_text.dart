import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'auth_colors.dart';

class LoginText extends StatelessWidget {
  const LoginText({
    super.key,
    required this.onLoginTap,
  });

  final VoidCallback onLoginTap;

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
            const TextSpan(
              text: "Already have an account? ",
            ),
            TextSpan(
              text: "Login",
              style: const TextStyle(
                color: AuthColors.primary,
                fontWeight: FontWeight.w700,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = onLoginTap,
            ),
          ],
        ),
      ),
    );
  }
}
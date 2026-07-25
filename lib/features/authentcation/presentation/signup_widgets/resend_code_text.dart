import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'auth_colors.dart';

/// "Didn't receive the code? Resend Code" prompt.
class ResendCodeText extends StatelessWidget {
  const ResendCodeText({super.key, required this.onResendTap});

  final VoidCallback onResendTap;

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
            const TextSpan(text: "Didn't receive the code? "),
            TextSpan(
              text: 'Resend Code',
              style: const TextStyle(
                color: AuthColors.primary,
                fontWeight: FontWeight.w700,
              ),
              recognizer: TapGestureRecognizer()..onTap = onResendTap,
            ),
          ],
        ),
      ),
    );
  }
}

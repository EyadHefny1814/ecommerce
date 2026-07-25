import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'auth_colors.dart';
import 'social_login.dart';

/// Bottom section shared by the auth screens: a labeled divider,
/// the social sign-in buttons, and a prompt with a tappable action
/// (e.g. "Already have an account? Login").
class AuthFooter extends StatelessWidget {
  const AuthFooter({
    super.key,
    this.dividerLabel = 'OR SIGN UP WITH',
    required this.onGooglePressed,
    required this.onApplePressed,
    required this.promptText,
    required this.actionText,
    required this.onActionTap,
  });

  final String dividerLabel;
  final VoidCallback onGooglePressed;
  final VoidCallback onApplePressed;

  /// e.g. "Already have an account? "
  final String promptText;

  /// e.g. "Login"
  final String actionText;
  final VoidCallback onActionTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Expanded(
              child: Divider(color: AuthColors.surfaceBorder, thickness: 1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                dividerLabel,
                style: const TextStyle(
                  color: AuthColors.textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const Expanded(
              child: Divider(color: AuthColors.surfaceBorder, thickness: 1),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SocialLogin(
          onGooglePressed: onGooglePressed,
          onApplePressed: onApplePressed,
        ),
        const SizedBox(height: 20),
        Center(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: AuthColors.textSecondary,
                fontSize: 13,
              ),
              children: [
                TextSpan(text: promptText),
                TextSpan(
                  text: actionText,
                  style: const TextStyle(
                    color: AuthColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onActionTap,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

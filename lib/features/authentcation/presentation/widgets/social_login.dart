import 'package:flutter/material.dart';
import 'auth_colors.dart';

/// Row of social sign-in options (Google, Apple).
class SocialLogin extends StatelessWidget {
  const SocialLogin({
    super.key,
    required this.onGooglePressed,
    required this.onApplePressed,
  });

  final VoidCallback onGooglePressed;
  final VoidCallback onApplePressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SocialButton(
            label: 'Google',
            icon: _GoogleIcon(),
            onPressed: onGooglePressed,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _SocialButton(
            label: 'Apple',
            icon: const Icon(Icons.apple, color: Colors.white, size: 22),
            onPressed: onApplePressed,
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: AuthColors.surface,
        padding: const EdgeInsets.symmetric(vertical: 14),
        side: const BorderSide(color: AuthColors.surfaceBorder),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: AuthColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Minimal "G" mark so this widget has no external asset/package dependency.
/// Replace with the official multi-color Google "G" asset if desired.
class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
      width: 20,
      child: Icon(Icons.g_mobiledata, color: Colors.white, size: 26),
    );
  }
}

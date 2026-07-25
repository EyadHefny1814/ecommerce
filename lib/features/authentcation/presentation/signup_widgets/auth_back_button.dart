import 'package:flutter/material.dart';
import 'auth_colors.dart';
import 'package:go_router/go_router.dart';

/// Top-left back arrow used across the auth flow (signup, OTP, etc.).
class AuthBackButton extends StatelessWidget {
  const AuthBackButton({super.key, this.onPressed});

  /// Defaults to [Navigator.pop] when null.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.go('/login'),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
      icon: const Icon(
        Icons.arrow_back,
        color: AuthColors.textPrimary,
        size: 24,
      ),
    );
  }
}

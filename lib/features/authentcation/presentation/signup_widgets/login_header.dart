import 'package:flutter/material.dart';
import 'auth_colors.dart';

/// Tagline shown beneath the logo, e.g. "EQUIP. PERFORM. CONQUER."
class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
    this.tagline = 'EQUIP. PERFORM. CONQUER.',
  });

  final String tagline;

  @override
  Widget build(BuildContext context) {
    return Text(
      tagline,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: AuthColors.textSecondary,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 3,
      ),
    );
  }
}

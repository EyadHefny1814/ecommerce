import 'package:flutter/material.dart';
import 'auth_colors.dart';

/// Horizontal divider with centered label, e.g. "OR CONTINUE WITH".
class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key, this.label = 'OR CONTINUE WITH'});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: AuthColors.surfaceBorder, thickness: 1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
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
    );
  }
}

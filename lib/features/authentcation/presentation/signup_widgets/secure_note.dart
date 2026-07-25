import 'package:flutter/material.dart';
import 'auth_colors.dart';

/// Small reassurance line with a shield icon, e.g. "Your data is 100% secure".
class SecureNote extends StatelessWidget {
  const SecureNote({super.key, this.text = 'Your data is 100% secure'});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.verified_user_outlined,
          color: AuthColors.textSecondary,
          size: 15,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            color: AuthColors.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

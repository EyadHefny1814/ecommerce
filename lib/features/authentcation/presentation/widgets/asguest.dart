import 'package:flutter/material.dart';

class ContinueAsGuest extends StatelessWidget {
  final VoidCallback onTap;

  const ContinueAsGuest({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: onTap,
        icon: const Icon(
          Icons.person_outline,
          color: Colors.white,
          size: 22,
        ),
        label: const Text(
          "Continue as Guest",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
          backgroundColor: Colors.white.withOpacity(0.12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
              color: Colors.white.withOpacity(0.25),
            ),
          ),
        ),
      ),
    );
  }
}
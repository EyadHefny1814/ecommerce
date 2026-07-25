import 'package:flutter/material.dart';
import 'auth_colors.dart';

/// "Verify Your Email" title with the accent word in orange.
class OtpTitle extends StatelessWidget {
  const OtpTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: AuthColors.textPrimary,
        ),
        children: [
          TextSpan(text: 'Verify Your '),
          TextSpan(
            text: 'Email',
            style: TextStyle(color: AuthColors.primary),
          ),
        ],
      ),
    );
  }
}

/// Explains where the code was sent and what to do with it.
/// The [email] is highlighted in the brand orange.
class OtpSubtitle extends StatelessWidget {
  const OtpSubtitle({
    super.key,
    required this.email,
    this.instruction = 'Enter the code below to verify your email address.',
  });

  final String email;
  final String instruction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(
              color: AuthColors.textSecondary,
              fontSize: 14,
              height: 1.4,
            ),
            children: [
              const TextSpan(text: "We've sent a 6-digit code to\n"),
              TextSpan(
                text: email,
                style: const TextStyle(
                  color: AuthColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          instruction,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AuthColors.textSecondary,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

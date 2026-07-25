import 'package:flutter/material.dart';
import 'auth_colors.dart';

/// Glowing shield-and-lock icon shown at the top of the OTP screen.
class OtpShieldIcon extends StatelessWidget {
  const OtpShieldIcon({super.key, this.size = 110});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AuthColors.primary.withOpacity(0.18),
            AuthColors.primary.withOpacity(0.0),
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.shield_outlined,
            color: AuthColors.primary,
            size: size * 0.62,
          ),
          Icon(
            Icons.lock_outline,
            color: AuthColors.primary,
            size: size * 0.26,
          ),
        ],
      ),
    );
  }
}

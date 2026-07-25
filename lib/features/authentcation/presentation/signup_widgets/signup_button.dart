import 'package:flutter/material.dart';
import 'auth_colors.dart';

/// Filled orange "SIGN UP" button. Shows a spinner when [isLoading] is true.
class SignupButton extends StatelessWidget {
  const SignupButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.label = 'SIGN UP',
  });

  final VoidCallback? onPressed;
  final bool isLoading;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AuthColors.primary,
          disabledBackgroundColor: AuthColors.primary.withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
      ),
    );
  }
}

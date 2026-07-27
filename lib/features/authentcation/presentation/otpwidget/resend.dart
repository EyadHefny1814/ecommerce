import 'package:flutter/material.dart';

class ResendCode extends StatelessWidget {
  final VoidCallback onTap;

  const ResendCode({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Didn't receive the code? ",
          style: TextStyle(
            color: Colors.white60,
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: const Text(
            "Resend Code",
            style: TextStyle(
              color: Color(0xFFFF5B00),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
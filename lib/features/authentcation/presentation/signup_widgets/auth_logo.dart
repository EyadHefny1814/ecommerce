import 'package:flutter/material.dart';
import 'auth_colors.dart';

/// The ATHRYX brand mark: a triangular "A" icon above the wordmark.
class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key, this.size = 64});

  /// Height of the triangle mark; the wordmark scales with it.
  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(
          size: Size(size, size),
          painter: _AthryxMarkPainter(color: AuthColors.primary),
        ),
        const SizedBox(height: 12),
        Text(
          'ATHRYX',
          style: TextStyle(
            color: AuthColors.textPrimary,
            fontSize: size * 0.42,
            fontWeight: FontWeight.w800,
            letterSpacing: 6,
          ),
        ),
      ],
    );
  }
}

/// Simple triangular "A" mark drawn to avoid depending on an asset file.
/// Swap this out for an SVG/Image asset if you have the real logo file.
class _AthryxMarkPainter extends CustomPainter {
  _AthryxMarkPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width * 0.5, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width * 0.72, size.height)
      ..lineTo(size.width * 0.5, size.height * 0.45)
      ..lineTo(size.width * 0.28, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _AthryxMarkPainter oldDelegate) =>
      oldDelegate.color != color;
}

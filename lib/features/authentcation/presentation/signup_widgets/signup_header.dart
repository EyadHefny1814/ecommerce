import 'package:flutter/material.dart';
import 'auth_back_button.dart';
import 'auth_colors.dart';

/// Everything shown above the form on the signup screen:
/// the hero photo, back button, ATHRYX logo, and the
/// "Create Account" title with its subtitle.
class SignupHeader extends StatelessWidget {
  const SignupHeader({
    super.key,
    this.heroImagePath = 'assets/images/athelete.png',
    this.subtitle = 'Join Athryx and start your journey',
  });

  final String heroImagePath;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Hero photo (top-right) with the back button and logo overlaid.
        SizedBox(
          height: 220,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  height: 220,
                  width: 260,
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [Colors.black, Colors.black.withOpacity(0)],
                        stops: const [0.55, 1.0],
                      ).createShader(rect);
                    },
                    blendMode: BlendMode.dstIn,
                    child: Image.asset(
                      heroImagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const DecoratedBox(
                          decoration: BoxDecoration(color: AuthColors.surface),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 4,
                left: 8,
                child: AuthBackButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              ),
              Positioned(
                left: 20,
                bottom: 24,
                child: _Logo(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AuthColors.textPrimary,
            ),
            children: [
              TextSpan(text: 'Create '),
              TextSpan(
                text: 'Account',
                style: TextStyle(color: AuthColors.primary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            color: AuthColors.textSecondary,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

/// Small ATHRYX mark + wordmark used at the top of the signup header.
class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomPaint(
          size: const Size(44, 44),
          painter: _MarkPainter(color: AuthColors.primary),
        ),
        const SizedBox(height: 6),
        const Text(
          'ATHRYX',
          style: TextStyle(
            color: AuthColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'EQUIP. PERFORM. CONQUER.',
          style: TextStyle(
            color: AuthColors.textSecondary,
            fontSize: 9,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}

class _MarkPainter extends CustomPainter {
  _MarkPainter({required this.color});

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
  bool shouldRepaint(covariant _MarkPainter oldDelegate) =>
      oldDelegate.color != color;
}

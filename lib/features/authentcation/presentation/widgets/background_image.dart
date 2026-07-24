import 'package:flutter/material.dart';

/// Full-bleed background image with a dark gradient overlay,
/// used behind the auth (login/signup) screens.
class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    super.key,
    this.imagePath = 'assets/images/athelete.png',
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.fitWidth,
alignment: Alignment.topCenter,
            errorBuilder: (context, error, stackTrace) {
              // Fallback so the screen still renders if the asset is missing.
              return Container(color: const Color(0xFF0A0A0A));
            },
          ),
          // Dark gradient so the form stays readable over the photo.
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.35),
                  Colors.black.withOpacity(0.55),
                  const Color(0xFF0A0A0A),
                  const Color(0xFF0A0A0A),
                ],
                stops: const [0.0, 0.35, 0.6, 1.0],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

class PremiumBackground extends StatefulWidget {
  final Widget child;
  const PremiumBackground({super.key, required this.child});

  @override
  State<PremiumBackground> createState() => _PremiumBackgroundState();
}

class _PremiumBackgroundState extends State<PremiumBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 20))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        // 1. Solid Base
        Positioned.fill(
          child: Container(
            color: isDark ? const Color(0xFF020410) : const Color(0xFFF0F2F8),
          ),
        ),

        // 2 & 3. The "Animated 3D World" + "Glass" Layer
        // We wrap these in a RepaintBoundary to isolate the animation from the content
        Positioned.fill(
          child: RepaintBoundary(
            child: Stack(
              children: [
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: _Living3DObjectsPainter(
                          progress: _controller.value,
                          isDark: isDark,
                        ),
                      );
                    },
                  ),
                ),
                // Шар "Матового скла" (Frosted Glass) у стилі Antigravity
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                    child: Container(
                      color: (isDark ? Colors.black : Colors.white).withOpacity(0.1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // 4. Subtle Material Texture (Static)
        const Positioned.fill(child: IgnorePointer(child: _MaterialGrain())),

        // 5. Content
        widget.child,
      ],
    );
  }
}

class _Living3DObjectsPainter extends CustomPainter {
  final double progress;
  final bool isDark;

  _Living3DObjectsPainter({required this.progress, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final double t = progress * 2 * math.pi;

    // СТИЛЬ FLOWLISH: Живий рух та пульсація
    
    // 1. Blue Glow (Активний рух у верхній частині)
    _drawAmbientGlow(
      canvas, size, t,
      color: const Color(0xFF2563EB), 
      centerX: 0.4 + 0.3 * math.sin(t), // Збільшена амплітуда
      centerY: 0.25 + 0.15 * math.cos(t),
      radius: size.width * (0.6 + 0.2 * math.sin(t * 2)), // ПУЛЬСАЦІЯ РОЗМІРУ
      opacity: isDark ? 0.35 : 0.25,
    );

    // 2. Cyan Glow (Центральний акцент)
    _drawAmbientGlow(
      canvas, size, t + math.pi * 0.6,
      color: const Color(0xFF06B6D4), 
      centerX: 0.7 + 0.2 * math.cos(t * 2), // ЦІЛИЙ МНОЖНИК 2
      centerY: 0.5 + 0.2 * math.sin(t),
      radius: size.width * (0.5 + 0.25 * math.cos(t)), // ПУЛЬСАЦІЯ РОЗМІРУ
      opacity: isDark ? 0.3 : 0.2,
    );

    // 3. Emerald Glow (Нижня частина)
    _drawAmbientGlow(
      canvas, size, t + math.pi * 1.3,
      color: const Color(0xFF10B981), 
      centerX: 0.3 + 0.2 * math.sin(t * 1), // ЦІЛИЙ МНОЖНИК 1
      centerY: 0.8 + 0.1 * math.cos(t * 2), // ЦІЛИЙ МНОЖНИК 2
      radius: size.width * (0.7 + 0.15 * math.sin(t)), // ПУЛЬСАЦІЯ РОЗМІРУ
      opacity: isDark ? 0.4 : 0.25,
    );
  }

  void _drawAmbientGlow(
    Canvas canvas, 
    Size size, 
    double t, {
    required Color color,
    required double centerX,
    required double centerY,
    required double radius,
    required double opacity,
  }) {
    final center = Offset(size.width * centerX, size.height * centerY);
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          color.withOpacity(opacity),
          color.withOpacity(opacity * 0.5),
          color.withOpacity(0),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _Living3DObjectsPainter oldDelegate) => true;
}

class _MaterialGrain extends StatelessWidget {
  const _MaterialGrain();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _GrainPainter(), size: Size.infinite);
  }
}

class _GrainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(42);
    final paint = Paint()..strokeWidth = 1.0;

    // Optimized: Reduced points from 30,000 to 5,000 to reduce initial paint load
    for (int i = 0; i < 5000; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final opacity = random.nextDouble() * 0.05;
      canvas.drawPoints(PointMode.points, [
        Offset(x, y),
      ], paint..color = Colors.grey.withOpacity(opacity));
    }
  }

  @override
  bool shouldRepaint(covariant _GrainPainter oldDelegate) => false;
}

import 'package:flutter/material.dart';
import 'dart:math' as math;

class NeonBackground extends StatefulWidget {
  final Widget child;
  const NeonBackground({super.key, required this.child});

  @override
  State<NeonBackground> createState() => _NeonBackgroundState();
}

class _NeonBackgroundState extends State<NeonBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final double shift = math.sin(_controller.value * 2 * math.pi);
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                const Color(0xFF0A001F),
                Color.lerp(const Color(0xFF0A001F), const Color(0xFF220066), (shift + 1) / 2)!,
              ],
              radius: 1.2,
              center: Alignment(shift, -shift),
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}

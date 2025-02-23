import 'package:flutter/material.dart';
import 'package:real_estate_app_mp/widgets/app_text.dart';

class AnimatedText extends StatefulWidget {
  const AnimatedText({super.key, required this.text, this.color = Colors.white});

  final double text;
  final Color color;

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animation = Tween<double>(begin: 0, end: widget.text).animate(
      CurvedAnimation(parent: _controller, curve: Curves.decelerate),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return AppText(
          _animation.value.toInt().toString(),
          size: 40,
          weight: FontWeight.bold,
          color: widget.color,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

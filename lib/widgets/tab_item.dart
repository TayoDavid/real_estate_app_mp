import 'package:flutter/material.dart';
import 'package:real_estate_app_mp/utils/extensions.dart';

class TabItem extends StatefulWidget {
  const TabItem({
    super.key,
    this.selected = false,
    required this.icon,
    this.onTap,
  });

  final bool selected;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  State<TabItem> createState() => _TabItemState();
}

class _TabItemState extends State<TabItem> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0.1, end: 1.0).animate(_animationController);
  }

  Widget get body {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.selected ? Colors.orange : Colors.black87,
      ),
      child: Icon(widget.icon, color: Colors.white, size: 18),
    ).onTap(execute: widget.onTap);
  }

  @override
  Widget build(BuildContext context) {
    _animationController
      ..reset()
      ..forward();
    if (!widget.selected) return body;
    return FadeTransition(
      opacity: _animation,
      child: AnimatedContainer(
        width: widget.selected ? 42 : 36,
        height: widget.selected ? 42 : 36,
        onEnd: () {},
        duration: Duration(milliseconds: 100),
        child: body,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

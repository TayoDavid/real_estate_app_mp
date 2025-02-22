import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatefulWidget {
  const ImageContainer({super.key, required this.img, this.width = 0.0});

  final String img;
  final double width;

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> with TickerProviderStateMixin {
  double _buttonSliderPosition = 0.0;

  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _buttonSliderPosition = widget.width - 76;
      });
    });

    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween<double>(begin: -40, end: 16).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: Image.asset(widget.img, fit: BoxFit.cover)),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: LayoutBuilder(
              builder: (context, constraint) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(44),
                            color: Colors.white.withOpacity(0.6),
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.6),
                                Colors.white.withOpacity(0.4),
                              ],
                            ),
                          ),
                          alignment: Alignment.center,
                          child: AnimatedBuilder(
                              animation: _animation,
                              builder: (context, child) {
                                return Text(
                                  "Gladkova St., 25",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 400),
                      left: _buttonSliderPosition,
                      child: Container(
                        width: 36,
                        height: 36,
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 5),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Icon(CupertinoIcons.chevron_right, color: Colors.grey, size: 16),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

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
  late AnimationController _animationController;
  late Animation<double> _animation;

  var _width = 44.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _width = widget.width;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
                    AnimatedContainer(
                      width: _width,
                      duration: Duration(seconds: 1),
                      onEnd: () {
                        _animationController
                          ..reset()
                          ..forward();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(44),
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
                            child: Stack(
                              children: [
                                FadeTransition(
                                  opacity: _animation,
                                  child: Center(
                                    child: Text(
                                      "Gladkova St., 25",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
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
                                )
                              ],
                            ),
                          ),
                        ),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_app_mp/utils/extensions.dart';
import 'package:real_estate_app_mp/utils/resource.dart';
import 'package:real_estate_app_mp/widgets/app_text.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.linearToEaseOut);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(Assets.map),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    cursorHeight: 18,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: 'Saint Petersburg',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(CupertinoIcons.search),
                      border: borderless,
                      contentPadding: EdgeInsets.symmetric(vertical: 4),
                    ),
                  ).height(44),
                ),
                Container(
                  width: 44,
                  height: 44,
                  margin: EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(Icons.tune),
                )
              ],
            ).paddingSymmetric(x: 20),
            Positioned(
              bottom: 80,
              left: 32,
              right: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: CircleIconButton(
                                icon: Icons.reorder,
                                onTap: () {
                                  _animationController
                                    ..reset()
                                    ..forward();
                                },
                              ),
                            ),
                          ),
                          ScaleTransition(
                            scale: _animation,
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              width: 132,
                              height: 132,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xB6F9F8F6),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  ContextOptionItem(
                                    icon: Icons.beenhere_outlined,
                                    text: 'Cosy areas',
                                    onTap: () {
                                      _animationController.reset();
                                    },
                                  ),
                                  ContextOptionItem(
                                    icon: Icons.wallet_outlined,
                                    text: 'Price',
                                    selected: true,
                                    onTap: () {
                                      _animationController.reset();
                                    },
                                  ),
                                  ContextOptionItem(
                                    icon: CupertinoIcons.trash,
                                    text: 'Ubfrastructure',
                                    onTap: () {
                                      _animationController.reset();
                                    },
                                  ),
                                  ContextOptionItem(
                                    icon: Icons.reorder,
                                    text: 'Without any layer',
                                    onTap: () {
                                      _animationController.reset();
                                    },
                                  ),
                                ],
                              ),
                            ).onTap(
                              execute: () {
                                _animationController.reset();
                              },
                            ),
                          ),
                        ],
                      ),
                      CircleIconButton(icon: Icons.near_me_outlined).padOnly(top: 4),
                    ],
                  ),
                  Container(
                    width: 144,
                    height: 44,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.sort, size: 16, color: Colors.white).padOnly(right: 4),
                        AppText('List of variants', color: Colors.white, size: 12),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ).paddingAll(16),
      ),
    );
  }

  OutlineInputBorder get borderless {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide.none,
    );
  }
}

class ContextOptionItem extends StatelessWidget {
  const ContextOptionItem({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
    this.selected = false,
  });

  final IconData icon;
  final String text;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 14, color: selected ? Color(0xFFBA770B) : Color(0xFF5C5B5B)),
          AppText(
            text,
            size: 10,
            weight: FontWeight.w500,
            color: selected ? Color(0xFFBA770B) : Color(0xFF5C5B5B),
          ).padOnly(left: 8),
        ],
      ).onTap(execute: onTap),
    );
  }
}

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    this.onTap,
  });

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.black87,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 16,
        color: Colors.white,
      ).center,
    ).onTap(execute: onTap);
  }
}

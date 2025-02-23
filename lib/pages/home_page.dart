import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:real_estate_app_mp/utils/animated_text.dart';
import 'package:real_estate_app_mp/utils/circle_path.dart';
import 'package:real_estate_app_mp/utils/extensions.dart';
import 'package:real_estate_app_mp/utils/resource.dart';
import 'package:real_estate_app_mp/widgets/app_text.dart';
import 'package:real_estate_app_mp/widgets/image_container.dart';
import 'package:real_estate_app_mp/widgets/tab_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final tabOptions = [
    Icons.search_rounded,
    CupertinoIcons.bubble_middle_bottom_fill,
    CupertinoIcons.house_fill,
    CupertinoIcons.heart_fill,
    CupertinoIcons.person_fill
  ];

  IconData? _selectedTabIcon;

  late AnimationController _avatarAnimationController;
  late Animation<double> _avatarAnimation;

  late AnimationController _locationContainerAnimationController;
  late Animation<double> _locationControllerAnimation;

  late AnimationController _fadeAnimationController;
  late Animation<double> _fadeAnimation;

  late AnimationController _captionAnimationController;
  late Animation<double> _captionAnimation;

  late AnimationController _numbersAnimationController;
  late Animation<double> _numbersAnimation;

  late AnimationController _imageListAnimationController;
  late Animation<double> _imageListAnimation;

  late AnimationController _tabAnimationController;
  late Animation<double> _tabAnimation;

  bool _hideNumbers = false;

  @override
  void initState() {
    _selectedTabIcon = tabOptions[2];

    _avatarAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _avatarAnimation = CurvedAnimation(parent: _avatarAnimationController, curve: Curves.fastOutSlowIn);

    _locationContainerAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _locationControllerAnimation = CurvedAnimation(
      parent: _locationContainerAnimationController,
      curve: Curves.fastOutSlowIn,
    );

    _fadeAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _fadeAnimation = CurvedAnimation(parent: _fadeAnimationController, curve: Curves.easeInOut);

    _captionAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _captionAnimation = Tween<double>(begin: 30, end: 0).animate(_captionAnimationController);

    _numbersAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _numbersAnimation = CurvedAnimation(parent: _numbersAnimationController, curve: Curves.fastOutSlowIn);

    _imageListAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _imageListAnimation = Tween<double>(begin: 1000, end: 0).animate(_imageListAnimationController);

    _tabAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _tabAnimation = Tween<double>(begin: 100, end: 0).animate(_tabAnimationController);

    _avatarAnimationController.forward();
    _locationContainerAnimationController.forward();

    _captionAnimationController.forward();

    _locationContainerAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fadeAnimationController.forward();
        _numbersAnimationController.forward();
      }
    });

    _numbersAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(seconds: 1), () => _imageListAnimationController.forward());
        Future.delayed(Duration(milliseconds: 1400), () {
          setState(() {
            _hideNumbers = true;
          });
        });
      }
    });

    _imageListAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(seconds: 2), () => _tabAnimationController.forward());
      }
    });

    super.initState();
  }

  Widget get numbersCards {
    var width = MediaQuery.sizeOf(context).width;
    var height = (width - 8) / 2.2;
    return Row(
      children: [
        Expanded(
          child: ScaleTransition(
            scale: _numbersAnimation,
            child: ClipPath(
              clipper: CirclePath(),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.orange),
                child: Column(
                  children: [
                    AppText('BUY', size: 12, color: Colors.white),
                    Spacer(),
                    AnimatedText(text: 1034),
                    AppText('offers', size: 12, color: Colors.white),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: ScaleTransition(
            scale: _numbersAnimation,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  AppText('RENT', size: 12, color: Colors.grey),
                  Spacer(),
                  AnimatedText(text: 2212, color: Colors.grey),
                  AppText('offers', size: 12, color: Colors.grey),
                  Spacer(),
                ],
              ),
            ),
          ),
        )
      ],
    ).size(width, height);
  }

  Widget get imageLists {
    return AnimatedBuilder(
      animation: _imageListAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _imageListAnimation.value),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            margin: EdgeInsets.only(bottom: 32),
            padding: EdgeInsets.only(left: 8, right: 8),
            child: StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 8,
              children: [
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 1,
                  child: LayoutBuilder(builder: (context, constraint) {
                    return ImageContainer(img: Assets.home1, width: constraint.maxWidth);
                  }),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 2,
                  child: LayoutBuilder(builder: (context, constraint) {
                    return ImageContainer(img: Assets.home2, width: constraint.maxWidth);
                  }),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: LayoutBuilder(builder: (context, constraint) {
                    return ImageContainer(img: Assets.home3, width: constraint.maxWidth);
                  }),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: LayoutBuilder(builder: (context, constraint) {
                    return ImageContainer(img: Assets.home4, width: constraint.maxWidth);
                  }),
                ),
              ],
            ).paddingSymmetric(y: 8),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: [0.0, 0.35, 1.0],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.white70,
            Colors.white54,
            const Color(0x76F7D4A8),
          ],
        ),
      ),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              stops: [0.0, 0.35, 1.0],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.white70,
                Colors.white54,
                const Color(0x76F7D4A8),
              ],
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ScaleTransition(
                                scale: _locationControllerAnimation,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: FadeTransition(
                                    opacity: _fadeAnimation,
                                    child: Row(
                                      children: [
                                        Icon(Icons.location_pin, color: Colors.grey, size: 16),
                                        AppText(
                                          "Saint Petersburg",
                                          size: 12,
                                          weight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              ScaleTransition(
                                scale: _avatarAnimation,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  clipBehavior: Clip.hardEdge,
                                  margin: EdgeInsets.only(right: 16),
                                  decoration: BoxDecoration(shape: BoxShape.circle),
                                  child: Image.asset(Assets.avatar, fit: BoxFit.cover),
                                ),
                              ),
                            ],
                          ).padOnly(bottom: 24),
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: AppText('Hi, Marina', size: 15, weight: FontWeight.w500, color: Colors.grey),
                          ).paddingSymmetric(x: 16),
                          AnimatedBuilder(
                            animation: _captionAnimation,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(0, _captionAnimation.value),
                                child: AppText(
                                  "let's select your perfect place",
                                  size: 32,
                                  height: 1.1,
                                ).padOnly(right: 100, top: 8, bottom: 32),
                              );
                            },
                          ).paddingSymmetric(x: 16),
                          Stack(
                            children: [
                              AnimatedSwitcher(
                                duration: Duration(milliseconds: 600),
                                transitionBuilder: (child, animation) =>
                                    ScaleTransition(scale: animation, child: child),
                                child: _hideNumbers ? SizedBox.shrink() : numbersCards,
                              ),
                              imageLists,
                            ],
                          ).paddingSymmetric(x: 16),
                        ],
                      ),
                    ],
                  ).padOnly(bottom: 100),
                ),
                Positioned(
                  bottom: 32,
                  left: 0,
                  right: 0,
                  child: AnimatedBuilder(
                      animation: _tabAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _tabAnimation.value),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 52,
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(52),
                                ),
                                child: Row(
                                  children: [
                                    for (var i = 0; i < tabOptions.length; i++) ...[
                                      TabItem(
                                        icon: tabOptions[i],
                                        selected: _selectedTabIcon == tabOptions[i],
                                        onTap: () {
                                          setState(() => _selectedTabIcon = tabOptions[i]);
                                        },
                                      ).padOnly(left: (i != 0) ? 8 : 0)
                                    ]
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

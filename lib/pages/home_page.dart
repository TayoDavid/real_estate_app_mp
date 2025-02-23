import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:real_estate_app_mp/utils/animated_text.dart';
import 'package:real_estate_app_mp/utils/circle_path.dart';
import 'package:real_estate_app_mp/utils/extensions.dart';
import 'package:real_estate_app_mp/utils/resource.dart';
import 'package:real_estate_app_mp/widgets/app_text.dart';
import 'package:real_estate_app_mp/widgets/image_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _avatarAnimationController;
  late Animation<double> _avatarAnimation;

  late AnimationController _locationContainerAnimationController;
  late Animation<double> _locationContainerAnimation;

  late AnimationController _fadeAnimationController;
  late Animation<double> _fadeAnimation;

  late AnimationController _captionAnimationController;
  late Animation<double> _captionAnimation;

  late AnimationController _captionOpacityAnimationController;
  late Animation<double> _captionOpacityAnimation;

  late AnimationController _numbersAnimationController;
  late Animation<double> _numbersAnimation;

  late AnimationController _imageListAnimationController;
  late Animation<double> _imageListAnimation;

  bool _hideNumbers = false;

  @override
  void initState() {
    _avatarAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1500));
    _avatarAnimation = CurvedAnimation(parent: _avatarAnimationController, curve: Curves.fastOutSlowIn);

    _locationContainerAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1500));
    _locationContainerAnimation = CurvedAnimation(
      parent: _locationContainerAnimationController,
      curve: Curves.fastOutSlowIn,
    );

    _fadeAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _fadeAnimation = CurvedAnimation(parent: _fadeAnimationController, curve: Curves.easeInOut);

    _captionOpacityAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _captionOpacityAnimation = CurvedAnimation(parent: _captionOpacityAnimationController, curve: Curves.easeInOut);

    _captionAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _captionAnimation = Tween<double>(begin: 30, end: 0).animate(_captionAnimationController);

    _numbersAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _numbersAnimation = CurvedAnimation(parent: _numbersAnimationController, curve: Curves.fastOutSlowIn);

    _imageListAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _imageListAnimation = Tween<double>(begin: 1000, end: 0).animate(_imageListAnimationController);

    _avatarAnimationController.forward();
    _locationContainerAnimationController.forward();

    _avatarAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _captionOpacityAnimationController.forward();

        Future.delayed(Duration(milliseconds: 600), () => _captionAnimationController.forward());
      }
    });

    _locationContainerAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fadeAnimationController.forward();
        _numbersAnimationController.forward();
      }
    });

    _numbersAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(seconds: 1), () => _imageListAnimationController.forward());
        Future.delayed(Duration(milliseconds: 2400), () {
          WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
            if (mounted) {
              setState(() => _hideNumbers = true);
            }
          });
        });
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
    ).paddingSymmetric(x: 16).size(width, height);
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
                    return ImageContainer(img: Assets.home1, address: 'Gladkova St., 25', width: constraint.maxWidth);
                  }),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 2,
                  child: LayoutBuilder(builder: (context, constraint) {
                    return ImageContainer(img: Assets.home2, address: 'Gubina St., 11', width: constraint.maxWidth);
                  }),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: LayoutBuilder(builder: (context, constraint) {
                    return ImageContainer(img: Assets.home3, address: 'Trefoleva St., 43', width: constraint.maxWidth);
                  }),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: LayoutBuilder(builder: (context, constraint) {
                    return ImageContainer(img: Assets.home4, address: 'Sedova St., 22', width: constraint.maxWidth);
                  }),
                ),
              ],
            ).paddingSymmetric(y: 8),
          ),
        );
      },
    );
  }

  Widget get homeWidget {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ScaleTransition(
                scale: _locationContainerAnimation,
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 16),
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
          FadeTransition(
            opacity: _captionOpacityAnimation,
            child: AnimatedBuilder(
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
          ),
          Stack(
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 600),
                transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                child: _hideNumbers ? SizedBox.shrink() : numbersCards,
              ),
              imageLists,
            ],
          )
        ],
      ).padOnly(bottom: 100),
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
            Color(0x76F7EFE5),
            Color(0xB6F9F8F6),
            Color(0x76F7D4A8),
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: homeWidget,
      ),
    );
  }

  @override
  void dispose() {
    _avatarAnimationController.dispose();
    _locationContainerAnimationController.dispose();
    _fadeAnimationController.dispose();
    _captionAnimationController.dispose();
    _captionOpacityAnimationController.dispose();
    _numbersAnimationController.dispose();
    _imageListAnimationController.dispose();
    super.dispose();
  }
}

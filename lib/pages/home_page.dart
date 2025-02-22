import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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

class _HomePageState extends State<HomePage> {
  final tabOptions = [
    Icons.search_rounded,
    CupertinoIcons.bubble_middle_bottom_fill,
    CupertinoIcons.house_fill,
    CupertinoIcons.heart_fill,
    CupertinoIcons.person_fill
  ];

  IconData? _selectedTabIcon;

  @override
  void initState() {
    _selectedTabIcon = tabOptions[2];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = (width - 8) / 2;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: [0.0, 0.35, 1.0],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.white,
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
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.location_pin, color: Colors.grey, size: 16),
                                  AppText("Saint Petersburg", size: 12, weight: FontWeight.w500, color: Colors.grey),
                                ],
                              ),
                            ),
                            Image.asset(Assets.avatar, fit: BoxFit.cover).circular.size(40, 40),
                          ],
                        ).padOnly(bottom: 24),
                        AppText('Hi, Marina', size: 15, weight: FontWeight.w500, color: Colors.grey),
                        AppText(
                          "let's select your perfect place",
                          size: 32,
                          height: 1.1,
                        ).padOnly(right: 100, top: 8, bottom: 32),
                        Row(
                          children: [
                            Expanded(
                              child: ClipPath(
                                clipper: CirclePath(),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.orange),
                                  child: Column(
                                    children: [
                                      AppText(
                                        'BUY',
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                      Spacer(),
                                      AppText('1034', size: 40, weight: FontWeight.bold, color: Colors.white),
                                      AppText('offers', size: 12, color: Colors.white),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  children: [
                                    AppText(
                                      'RENT',
                                      size: 12,
                                      color: Colors.grey,
                                    ),
                                    Spacer(),
                                    AppText('2212', size: 40, weight: FontWeight.bold, color: Colors.grey),
                                    AppText('offers', size: 12, color: Colors.grey),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ).size(width, height),
                      ],
                    ).paddingSymmetric(x: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      margin: EdgeInsets.only(top: 20, bottom: 32),
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
                  ],
                ),
              ),
              Positioned(
                bottom: 32,
                left: 0,
                right: 0,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_app_mp/pages/home_page.dart';
import 'package:real_estate_app_mp/pages/search_page.dart';
import 'package:real_estate_app_mp/utils/extensions.dart';
import 'package:real_estate_app_mp/widgets/tab_item.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  final _tabOptions = [
    Icons.search_rounded,
    CupertinoIcons.bubble_middle_bottom_fill,
    CupertinoIcons.house_fill,
    CupertinoIcons.heart_fill,
    CupertinoIcons.person_fill
  ];

  IconData? _selectedTabIcon;

  int _currentPage = 1;

  late AnimationController _tabAnimationController;
  late Animation<double> _tabAnimation;

  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPage);
    _selectedTabIcon = _tabOptions[2];

    _tabAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _tabAnimation = Tween<double>(begin: 100, end: 0).animate(_tabAnimationController);

    Future.delayed(Duration(seconds: 6), () => _tabAnimationController.forward());
    super.initState();
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
            const Color(0xB6F9F8F6),
            const Color(0x76F7D4A8),
          ],
        ),
      ),
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              children: [
                SearchPage(),
                HomePage(),
              ],
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
                              for (var i = 0; i < _tabOptions.length; i++) ...[
                                TabItem(
                                  icon: _tabOptions[i],
                                  selected: _selectedTabIcon == _tabOptions[i],
                                  onTap: () {
                                    setState(() {
                                      _selectedTabIcon = _tabOptions[i];
                                      if (i == 0) {
                                        _currentPage = 0;
                                      } else if (i == 2) {
                                        _currentPage = 1;
                                      }
                                    });

                                    _pageController.animateToPage(
                                      _currentPage,
                                      duration: Duration(milliseconds: 2),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                    );
                                  },
                                ).padOnly(left: (i != 0) ? 8 : 0)
                              ]
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

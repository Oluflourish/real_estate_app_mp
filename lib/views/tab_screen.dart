import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_estate_app_mp/models/nav_item_model.dart';
import 'package:real_estate_app_mp/providers/provider.dart';
import 'package:real_estate_app_mp/utils/app_colors.dart';
import 'package:real_estate_app_mp/utils/svg_paths.dart';
import 'package:real_estate_app_mp/views/tabs/home/home_tab.dart';
import 'package:real_estate_app_mp/views/tabs/search_tab.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({
    super.key,
  });

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

bool _navBarAnimation = false;

List<NavItemModel> pages = <NavItemModel>[
  NavItemModel(
    icon: SvgPaths.search,
    page: SearchTab(),
  ),
  NavItemModel(
    icon: SvgPaths.chat,
    page: Container(),
  ),
  NavItemModel(
    icon: SvgPaths.home,
    page: HomeTab(),
  ),
  NavItemModel(
    icon: SvgPaths.heart,
    page: Container(),
  ),
  NavItemModel(
    icon: SvgPaths.profile,
    page: Container(),
  ),
];

class _TabScreenState extends ConsumerState<TabScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (!mounted) return;
      await Future.delayed(Duration(milliseconds: 3600));
      setState(() => _navBarAnimation = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appNavProvider = ref.watch(RiverpodProvider.appNavProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.white, AppColors.primaryBg],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.9],
          ),
        ),
        child: Stack(
          children: [
            pages[appNavProvider.currentTabIndex].page,
            // IndexedStack(
            //   // IndexedStack is used to keep the state of the current tab
            //   index: appNavProvider.currentTabIndex,
            //   children: pages.map((e) => e.page).toList(),
            // ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedSlide(
                offset: _navBarAnimation ? Offset.zero : Offset(0, 1),
                duration: Duration(milliseconds: 500),
                child: SafeArea(
                  child: Card(
                    shape: StadiumBorder(),
                    elevation: 16,
                    margin: EdgeInsets.only(bottom: Platform.isIOS ? 2 : 8),
                    color: AppColors.black2.withOpacity(0.95),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: pages.indexed.map(
                        (e) {
                          final selected =
                              e.$1 == appNavProvider.currentTabIndex;
                          return GestureDetector(
                            onTap: () =>
                                appNavProvider.setCurrentTabIndex(e.$1),
                            child: Container(
                              padding: EdgeInsets.all(12),
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 5),
                              decoration: BoxDecoration(
                                color: selected
                                    ? AppColors.primaryColor
                                    : AppColors.black,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                e.$2.icon,
                                colorFilter: ColorFilter.mode(
                                    AppColors.white, BlendMode.srcIn),
                                // size: 24,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

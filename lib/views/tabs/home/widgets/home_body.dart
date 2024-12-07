import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:real_estate_app_mp/utils/app_colors.dart';
import 'package:real_estate_app_mp/utils/app_theme.dart';
import 'package:real_estate_app_mp/utils/image_paths.dart';
import 'package:real_estate_app_mp/views/tabs/home/widgets/box_counter.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  bool _animateLocation = false;
  bool _animateLocationContent = false;
  bool _animateAvatar = false;
  bool _animateName = false;
  bool _animateSubText = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final delays = [200, 300, 900, 300, 300];
      final animations = [
        () => _animateAvatar = true,
        () => _animateLocation = true,
        () => _animateLocationContent = true,
        () => _animateName = true,
        () => _animateSubText = true,
      ];

      for (int i = 0; i < delays.length; i++) {
        await Future.delayed(Duration(milliseconds: delays[i]));
        if (mounted) {
          setState(animations[i]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 18, right: 18, top: 10),
      child: Column(
        children: [
          SafeArea(
            child: Stack(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: LayoutBuilder(builder: (context, constraints) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 900),
                      width: _animateLocation ? constraints.maxWidth : 0,
                      height: 50,
                      constraints: BoxConstraints(maxWidth: 180),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12.0),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.greyText.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: _animateLocationContent == false
                            ? Container()
                            : Row(
                                children: [
                                  AnimatedOpacity(
                                    duration: Duration(milliseconds: 500),
                                    opacity: _animateLocationContent ? 1 : 0,
                                    child: Icon(
                                      Iconsax.location5,
                                      color: AppColors.greyText,
                                      size: 18.sp,
                                    ),
                                  ),
                                  Gap(8.0),
                                  AnimatedOpacity(
                                    duration: Duration(milliseconds: 500),
                                    opacity: _animateLocationContent ? 1 : 0,
                                    child: Text(
                                      'Lekki Phase 1',
                                      style: AppTheme.textTheme.bodyMedium
                                          ?.copyWith(
                                        color: AppColors.greyText,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    );
                  }),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: AnimatedScale(
                    duration: Duration(milliseconds: 500),
                    scale: _animateAvatar ? 1 : 0,
                    child: SizedBox(
                      height: 48,
                      width: 48,
                      child: ClipOval(
                        child: Image.asset(
                          ImagePaths.flourish,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Gap(24),
          Align(
            alignment: Alignment.topLeft,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: _animateName ? 1 : 0,
              child: Text(
                'Hi, Flourish',
                style: TextStyle(
                  color: AppColors.greyText,
                  fontSize: 23.sp,
                ),
              ),
            ),
          ),
          Gap(4),
          ClipRRect(
            child: Align(
              alignment: Alignment.topLeft,
              child: AnimatedSlide(
                duration: Duration(milliseconds: 500),
                offset: _animateSubText ? Offset.zero : Offset(0, 1),
                child: Text(
                  "let's select your \nperfect place",
                  style: TextStyle(
                    fontSize: 36.sp,
                    height: 1.2,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
          ),
          Gap(36),
          Row(
            children: [
              Expanded(
                child: BoxCounterWidget(
                  title: 'BUY',
                  count: 1034,
                  shape: BoxShape.circle,
                ),
              ),
              Gap(6),
              Expanded(
                child: BoxCounterWidget(
                  title: 'RENT',
                  count: 2212,
                  color: AppColors.white,
                  textColor: AppColors.greyText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

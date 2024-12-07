import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app_mp/utils/app_colors.dart';

class SlidingButton extends StatefulWidget {
  const SlidingButton(
      {super.key, required this.address, required this.alignment});

  final String address;
  final AlignmentGeometry alignment;

  @override
  State<SlidingButton> createState() => _SlidingButtonState();
}

class _SlidingButtonState extends State<SlidingButton> {
  bool _animateButton = false;
  bool _animateAddress = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (!mounted) return;
      await Future.delayed(Duration(milliseconds: 3000));
      setState(() => _animateButton = true);
      await Future.delayed(Duration(milliseconds: 400));
      setState(() => _animateAddress = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 600),
        height: 50,
        width: _animateButton ? constraints.maxWidth : 40,
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: AppColors.greyText.withOpacity(0.3),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
            child: LayoutBuilder(builder: (context, constraints) {
              return Stack(
                children: [
                  Container(
                    alignment: widget.alignment,
                    color: AppColors.primaryBgLight.withOpacity(0.4),
                    child: AnimatedOpacity(
                      opacity: _animateAddress ? 1 : 0,
                      duration: Duration(milliseconds: 300),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          widget.address,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    right: _animateButton ? 0 : constraints.maxWidth - 40,
                    duration: Duration(milliseconds: 400),
                    child: Container(
                      padding: EdgeInsets.only(right: 2, top: 4),
                      height: 46,
                      width: 46,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.white,
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          color: AppColors.black,
                          size: 18,
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      );
    });
  }
}

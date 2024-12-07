import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:real_estate_app_mp/utils/app_colors.dart';

class BoxCounterWidget extends StatefulWidget {
  const BoxCounterWidget({
    super.key,
    required this.title,
    required this.count,
    this.shape,
    this.color,
    this.textColor,
  });

  final String title;
  final int count;
  final BoxShape? shape;
  final Color? color;
  final Color? textColor;

  @override
  State<BoxCounterWidget> createState() => _BoxCounterWidgetState();
}

class _BoxCounterWidgetState extends State<BoxCounterWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<int> _animateCount;

  bool _animateSize = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

    _animateCount = IntTween(
      begin: 0,
      end: widget.count,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Future.delayed(Duration(milliseconds: 300)).then((_) {
          setState(() => _animateSize = true);
          _animationController.forward();
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: Duration(milliseconds: 500),
      scale: _animateSize ? 1 : 0,
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          shape: widget.shape ?? BoxShape.rectangle,
          color: widget.color ?? AppColors.primaryColor,
          borderRadius: widget.shape != BoxShape.circle
              ? BorderRadius.circular(20)
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: 18, left: 16, right: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 16,
                  color: widget.textColor ?? AppColors.white,
                ),
              ),
              Gap(24),
              AnimatedBuilder(
                  animation: _animateCount,
                  builder: (context, child) {
                    return FittedBox(
                      child: Text(
                        '${_animateCount.value}',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: widget.textColor ?? AppColors.white,
                        ),
                      ),
                    );
                  }),
              Text(
                'offers',
                style: TextStyle(
                  color: widget.textColor ?? AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app_mp/models/property_model.dart';
import 'package:real_estate_app_mp/utils/app_colors.dart';
import 'package:real_estate_app_mp/utils/custom_refresh.dart';
import 'package:real_estate_app_mp/utils/image_paths.dart';
import 'package:real_estate_app_mp/views/tabs/home/widgets/property_item.dart';

class PropertyListings extends ConsumerStatefulWidget {
  const PropertyListings({
    super.key,
  });

  @override
  ConsumerState<PropertyListings> createState() => _PropertyListingsState();
}

class _PropertyListingsState extends ConsumerState<PropertyListings> {
  bool _animatePropertyList = false;

  final List<PropertyModel> propertyList = [
    PropertyModel(
        address: 'Gladkova St., 25',
        image: ImagePaths.image1,
        mainAxis: 2,
        crossAxis: 1),
    PropertyModel(
        address: 'Gubina St., 11',
        image: ImagePaths.image2,
        mainAxis: 1,
        crossAxis: 2),
    PropertyModel(
        address: 'Trefoleva St., 43',
        image: ImagePaths.image3,
        mainAxis: 1,
        crossAxis: 1),
    PropertyModel(
        address: 'Sedova St., 22',
        image: ImagePaths.image4,
        mainAxis: 1,
        crossAxis: 1)
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (!mounted) return;
      await Future.delayed(Duration(milliseconds: 2500));
      setState(() => _animatePropertyList = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
        offset: _animatePropertyList ? Offset.zero : Offset(0, 1),
        duration: Duration(milliseconds: 500),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            color: AppColors.white,
          ),
          child: CustomRefresh(
            refreshAction: () async {
              await Future.delayed(Duration(seconds: 1), () {});
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: StaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: propertyList
                          .map(
                            (listing) => StaggeredGridTile.count(
                              crossAxisCellCount: listing.mainAxis,
                              mainAxisCellCount: listing.crossAxis,
                              child: PropertyItem(
                                image: listing.image,
                                address: listing.address,
                                alignment: listing.mainAxis > listing.crossAxis
                                    ? Alignment.center
                                    : Alignment.centerLeft,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

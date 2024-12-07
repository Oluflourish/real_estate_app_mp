import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:real_estate_app_mp/models/map_menu_options_model.dart';
import 'package:real_estate_app_mp/models/marker_model.dart';
import 'package:real_estate_app_mp/providers/provider.dart';
import 'package:real_estate_app_mp/utils/app_colors.dart';
import 'package:real_estate_app_mp/utils/constants.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class SearchTab extends ConsumerStatefulWidget {
  const SearchTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchTabState();
}

class _SearchTabState extends ConsumerState<SearchTab> {
  final _mapController = Completer<GoogleMapController>();
  bool _animateItems = false;
  bool _animateOptions = false;

  final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(6.4519, 3.4730),
    zoom: 16,
  );

  Set<Marker> _markers = {};

  final List<MapOptionsModel> mapMenuOptions = [
    MapOptionsModel(
      icon: Iconsax.shield_tick,
      name: 'Cosy areas',
      menuOption: MenuOptions.cosyAreas,
    ),
    MapOptionsModel(
      icon: Iconsax.empty_wallet,
      name: 'Price',
      menuOption: MenuOptions.price,
    ),
    MapOptionsModel(
      icon: Iconsax.bag,
      name: 'Infrastructure',
      menuOption: MenuOptions.infrastucture,
    ),
    MapOptionsModel(
      icon: Iconsax.layer,
      name: 'Without any layer',
      menuOption: MenuOptions.withoutAnyLayer,
    ),
  ];

  Future<void> loadCustomMarkers(MenuOptions menuOption) async {
    _markers = {};

    if (menuOption == MenuOptions.withoutAnyLayer) {
      setState(() {});
      return;
    }

    List<MarkerModel> markerData = [
      MarkerModel(
        id: '1',
        title: 'MP Headquaters',
        price: 'N200k - N500k',
        position: LatLng(6.4580, 3.4712),
      ),
      MarkerModel(
        id: '2',
        title: 'Circa Lagos',
        price: 'N350k - N450k',
        position: LatLng(6.4501, 3.4736),
      ),
      MarkerModel(
        id: '3',
        title: 'Blackbell',
        price: 'N300k - N400k',
        position: LatLng(6.4482, 3.4753),
      ),
      MarkerModel(
        id: '4',
        title: 'Ellyxville',
        price: 'N250k - N350k',
        position: LatLng(6.4557, 3.4723),
      ),
      MarkerModel(
        id: '5',
        title: 'Ogidi Studio',
        price: 'N200k - N300k',
        position: LatLng(6.4540, 3.4746),
      ),
      MarkerModel(
        id: '6',
        title: 'Sailors Lounge',
        price: 'N400k - N600k',
        position: LatLng(6.4517, 3.4699),
      ),
      // MarkerModel(id: '7', title: 'Rooken', position: LatLng(6.4551, 3.4795)),
      // MarkerModel(id: '8', title: 'Renee', position: LatLng(6.4499, 3.4819)),
      // MarkerModel(id: '9', title: 'Belleview', position: LatLng(6.4485, 3.4785)),
      // MarkerModel(id: '10', title: 'Upbeat', position: LatLng(6.4529, 3.4701)),
    ];

    for (var data in markerData) {
      final marker = Marker(
        markerId: MarkerId(data.id),
        position: data.position,
        icon: await buildTextMaker(data, menuOption),
      );
      _markers.add(marker);
    }

    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      setState(() => _animateItems = true);
      await loadCustomMarkers(MenuOptions.cosyAreas);
    });
    super.initState();
  }

  buildTextMaker(MarkerModel data, MenuOptions menuOption) async {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: menuOption == MenuOptions.infrastucture ? 18 : 8),
        child: menuOption == MenuOptions.infrastucture
            ? Icon(
                Icons.apartment,
                color: AppColors.white,
                size: 40,
              )
            : Text(
                menuOption == MenuOptions.price ? data.price : data.title,
                style: TextStyle(fontSize: 24.sp),
              ),
      ),
    ).toBitmapDescriptor(imageSize: Size(750, 300));
  }

  @override
  Widget build(BuildContext context) {
    final appNavProvider = ref.watch(RiverpodProvider.appNavProvider);
    final selectedMenuIndex = appNavProvider.currentMenuIndex;

    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _initialCameraPosition,
          style: jsonEncode(darkMapStyle),
          markers: _markers,
          onMapCreated: (GoogleMapController controller) {
            _mapController.complete(controller);
          },
          compassEnabled: false,
          mapToolbarEnabled: false,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 16, left: 32, right: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AnimatedScale(
                        scale: _animateItems ? 1 : 0,
                        duration: Duration(milliseconds: 800),
                        child: Container(
                            height: 45,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Row(
                              children: [
                                Gap(10),
                                Icon(Iconsax.search_normal_1),
                                Gap(10),
                                Text(
                                  'Lekki Phase 1',
                                  style: TextStyle(
                                    color: AppColors.black,
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                    Gap(10),
                    AnimatedScale(
                      scale: _animateItems ? 1 : 0,
                      duration: Duration(milliseconds: 800),
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            color: AppColors.white, shape: BoxShape.circle),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(
                            Iconsax.candle_24,
                            color: AppColors.black,
                            size: 16,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Spacer(),
                Stack(
                  children: [
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: AnimatedScale(
                        scale: _animateItems ? 1 : 0,
                        duration: Duration(milliseconds: 700),
                        child: GestureDetector(
                          onTap: () async {
                            setState(() => _animateOptions = true);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.darkGrey.withOpacity(0.7),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Icon(
                                  mapMenuOptions[selectedMenuIndex].icon,
                                  color: AppColors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, 0),
                      child: AnimatedScale(
                        alignment: Alignment.bottomLeft,
                        scale: _animateOptions ? 1 : 0,
                        duration: Duration(milliseconds: 700),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(24)),
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: mapMenuOptions.indexed.map((item) {
                                final selected =
                                    item.$1 == appNavProvider.currentMenuIndex;

                                return GestureDetector(
                                  onTap: () async {
                                    // If there are no changes
                                    if (item.$1 ==
                                        appNavProvider.currentMenuIndex) {
                                      setState(() => _animateOptions = false);
                                      return;
                                    } else {
                                      _animateOptions = false;
                                      appNavProvider
                                          .setCurrentMenuIndex(item.$1);
                                      await loadCustomMarkers(
                                          item.$2.menuOption);
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          item.$2.icon,
                                          color: selected
                                              ? AppColors.primaryColor
                                              : AppColors.darkGrey,
                                        ),
                                        Gap(12),
                                        Text(
                                          item.$2.name,
                                          style: TextStyle(
                                              color: selected
                                                  ? AppColors.primaryColor
                                                  : AppColors.darkGrey),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Gap(4),
                        AnimatedScale(
                          scale: _animateItems ? 1 : 0,
                          duration: Duration(milliseconds: 700),
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.darkGrey.withOpacity(0.7),
                                shape: BoxShape.circle),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child:
                                  Icon(Iconsax.send_24, color: AppColors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                    AnimatedScale(
                      scale: _animateItems ? 1 : 0,
                      duration: Duration(milliseconds: 700),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.darkGrey.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(28)),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 12, bottom: 12, left: 18, right: 18),
                          child: Row(
                            children: [
                              Icon(
                                Icons.format_align_left_outlined,
                                color: AppColors.white,
                                size: 16,
                              ),
                              Gap(8),
                              Text(
                                'List of variants',
                                style: TextStyle(color: AppColors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Gap(kBottomNavigationBarHeight * 1.4),
              ],
            ),
          ),
        )
      ],
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:real_estate_app_mp/views/tabs/home/widgets/home_body.dart';
import 'package:real_estate_app_mp/views/tabs/home/widgets/property_list.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext headerContext, bool boolean) {
        return [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: Platform.isIOS ? 470 : 420,
            flexibleSpace: FlexibleSpaceBar(
              background: HomeBody(),
            ),
          )
        ];
      },
      body: PropertyListings(),
    );
  }
}

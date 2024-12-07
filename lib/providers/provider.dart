import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app_mp/providers/app_nav_notifier.dart';

class RiverpodProvider {
  static final appNavProvider =
      ChangeNotifierProvider.autoDispose<AppNavProvider>(
    (ref) => AppNavProvider(),
  );
}

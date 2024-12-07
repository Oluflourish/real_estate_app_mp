import 'package:flutter/material.dart';

class AppNavProvider extends ChangeNotifier {
  int _currentTabIndex = 2;
  int get currentTabIndex => _currentTabIndex;

  int _currentMenuIndex = 0;
  int get currentMenuIndex => _currentMenuIndex;

  // TODO: Create enums for tabs instead of using integers

  setCurrentTabIndex(int index) {
    _currentTabIndex = index;
    notifyListeners();
  }

  setCurrentMenuIndex(int index) {
    _currentMenuIndex = index;
    notifyListeners();
  }
}

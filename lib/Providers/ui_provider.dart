import 'package:flutter/foundation.dart';

class UiProvider extends ChangeNotifier {
  bool _isOnline = true;

  bool get isOnline => _isOnline;

  set isOnline(bool value) {
    _isOnline = value;
    notifyListeners();
  }
}
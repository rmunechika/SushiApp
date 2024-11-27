import 'package:flutter/material.dart';

class SushiCounter extends ChangeNotifier {
  int _sushiCount = 0;
  double _sumPrice = 0.0;

  int get sushiCount => _sushiCount;
  double get sumPrice => _sumPrice;

  int getSushiCount() {
    return _sushiCount;
  }

  void addItem(double price) {
    _sushiCount++;
    _sumPrice += price;
    notifyListeners();
  }

  void removeItem(double price) {
    if (_sushiCount > 0) {
      _sushiCount--;
      _sumPrice -= price;
      notifyListeners();
    }
  }

  void reset() {
    _sushiCount = 0;
    _sumPrice = 0;
    notifyListeners();
  }
}

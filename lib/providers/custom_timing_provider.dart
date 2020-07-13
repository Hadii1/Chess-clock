import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:Cheska/models/custom_timing_podo.dart';
import 'dart:math';

class CustomTimingProvider with ChangeNotifier {
  bool _equalTiming = true;
  String _clockName;
  Box customTimingsBox = Hive.box<CustomTiming>('Custom Timings');

  void saveData() {
    if (clockName == null) {
      Random rnd = Random();
      clockName = 'chess${rnd.nextInt(999)}';
    }

    CustomTiming customTiming = CustomTiming(
        clockName: clockName,
        atimeHours: atimeHours,
        atimeMins: atimeMins,
        atimeSec: atimeSec,
        aInc: aincSec,
        aDelay: adelaySec,
        btimeHours: btimeHours,
        btimeMins: btimeMins,
        btimeSec: btimeSec,
        bInc: bincSec,
        bDelay: bdelaySec);

    customTimingsBox.add(customTiming);
  }

  _equalizeValues() {
    btimeHours = atimeHours;
    btimeMins = atimeMins;
    btimeSec = atimeSec;
    bincSec = aincSec;
    bdelaySec = adelaySec;
  }

  get clockName => _clockName;

  set clockName(String value) {
    _clockName = value;
    notifyListeners();
  }

  bool get equalTiming => _equalTiming;

  set equalTiming(bool value) {
    _equalTiming = value;
    if (equalTiming) {
      _equalizeValues();
    }
    notifyListeners();
  }

  int _atimeHours = 0;
  int _atimeMins = 0;
  int _atimeSec = 0;
  int _aincSec = 0;
  int _adelaySec = 0;

  int _btimeHours = 0;
  int _btimeMins = 0;
  int _btimeSec = 0;
  int _bincSec = 0;
  int _bdelaySec = 0;

  bool isRightFormat() {
    if (_atimeHours == 0 && _atimeMins == 0 && _atimeSec == 0 ||
        _btimeHours == 0 && _btimeMins == 0 && _btimeSec == 0) return false;

    return true;
  }

  String convertToTextFormat(int number) {
    if (number.toString().length == 1) {
      return '0$number';
    }
    return '$number';
  }

  int get atimeHours => _atimeHours;
  int get atimeMins => _atimeMins;
  int get atimeSec => _atimeSec;
  int get aincSec => _aincSec;
  int get adelaySec => _adelaySec;

  int get btimeHours => _btimeHours;
  int get btimeMins => _btimeMins;
  int get btimeSec => _btimeSec;
  int get bincSec => _bincSec;
  int get bdelaySec => _bdelaySec;

  set atimeHours(int value) {
    _atimeHours = value;
    if (equalTiming) _btimeHours = value;
    notifyListeners();
  }

  set atimeMins(int value) {
    _atimeMins = value;

    if (equalTiming) _btimeMins = value;
    notifyListeners();
  }

  set atimeSec(int value) {
    _atimeSec = value;
    if (equalTiming) _btimeSec = value;
    notifyListeners();
  }

  set aincSec(int value) {
    _aincSec = value;
    if (equalTiming) _bincSec = value;
    notifyListeners();
  }

  set adelaySec(int value) {
    _adelaySec = value;
    if (equalTiming) _bdelaySec = value;
    notifyListeners();
  }

  set btimeHours(int value) {
    _btimeHours = value;
    if (equalTiming) _atimeHours = value;
    notifyListeners();
  }

  set btimeMins(int value) {
    _btimeMins = value;
    if (equalTiming) _atimeMins = value;
    notifyListeners();
  }

  set btimeSec(int value) {
    _btimeSec = value;
    if (equalTiming) _atimeSec = value;
    notifyListeners();
  }

  set bincSec(int value) {
    _bincSec = value;
    if (equalTiming) _aincSec = value;
    notifyListeners();
  }

  set bdelaySec(int value) {
    _bdelaySec = value;
    if (equalTiming) _adelaySec = value;
    notifyListeners();
  }
}

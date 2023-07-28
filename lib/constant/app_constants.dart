import 'dart:io';

import 'package:flutter/material.dart';

class AppConstants {
  static const double marginLarge = 40;
  static const double marginNormal = 20;
  static const double marginSmall = 10;

  static const double fontSizeLarge = 60;
  static const double fontSizeNormal = 48;
  static const double fontSizeSmall = 32;

  static const MaterialColor historyColor = Colors.green;
  static const Color latestResultColor = Colors.brown;
  static const Color luckyDrawColor = Colors.orange;

  static const int lotto6Numbers = 43;
  static const int lotto7Numbers = 37;
  static const int lottoMNumbers = 31;

  static const int interAdFrequency = 3;

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1139352776311243/4879784090';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1139352776311243/5368020639';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}

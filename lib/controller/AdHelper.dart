import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5004690584510642/5608584784';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-5004690584510642/5608584784';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5004690584510642/3992250788';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-5004690584510642/3992250788';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}


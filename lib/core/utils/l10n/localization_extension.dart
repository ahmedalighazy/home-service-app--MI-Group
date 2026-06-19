import 'package:flutter/material.dart';

import 'app_locallization_setting.dart';

extension LocalizationExtension on BuildContext {
  String tr(String key) {
    return AppLocalizationsSetting.of(this)?.translate(key) ?? key;
  }

  bool get isRtl => Directionality.of(this) == TextDirection.rtl;
}

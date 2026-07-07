import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension LocalizationExtension on BuildContext {
  String tr(String key) => key.tr(context: this);

  bool get isRtl => Directionality.of(this) == ui.TextDirection.rtl;
}

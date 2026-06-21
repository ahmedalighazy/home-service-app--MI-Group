import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

/// Thin wrapper — all screens call context.tr('key') via the extension below.
/// easy_localization reads from assets/translations/ar.json & en.json.
class LocalizationService {
  LocalizationService._privateConstructor();
  static final LocalizationService instance =
      LocalizationService._privateConstructor();

  /// Kept for any legacy code that calls
  /// LocalizationService.instance.translate(key)
  String translate(String key) => key.tr();
}

extension LocalizationExtension on BuildContext {
  /// Delegates to easy_localization's .tr() which reads from JSON files.
  String tr(String key) => key.tr();
}

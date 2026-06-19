import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizationsSetting {
  final Locale locale;
  AppLocalizationsSetting(this.locale);

  static AppLocalizationsSetting? of(BuildContext context) {
    return Localizations.of<AppLocalizationsSetting>(
      context,
      AppLocalizationsSetting,
    );
  }

  static const LocalizationsDelegate<AppLocalizationsSetting> delegate =
      _AppLocalizationsDelegate();

  late Map<String, String> _localizedStrings;

  Future<bool> load() async {
    _localizedStrings = {};

    // List of features to load localization for
    final features = ['booking', 'profile', 'setting'];

    for (final feature in features) {
      try {
        String jsonString = await rootBundle.loadString(
          'lib/features/$feature/localization/${locale.languageCode}.json',
        );
        Map<String, dynamic> jsonMap = json.decode(jsonString);
        _localizedStrings.addAll(
          jsonMap.map((key, value) => MapEntry(key, value.toString())),
        );
      } catch (e) {
        // Fallback or log if a feature doesn't have the localization file yet
        debugPrint('Failed to load $feature localization: $e');
      }
    }

    return true;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizationsSetting> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizationsSetting> load(Locale locale) async {
    AppLocalizationsSetting localizations = AppLocalizationsSetting(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

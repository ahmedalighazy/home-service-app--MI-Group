import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/helpers/cache_helper.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  static const String _langKey = 'language';

  LanguageCubit() : super(_getInitialState());

  Object? get isArabic => null;

  static LanguageState _getInitialState() {
    final savedLanguage = CacheHelper.getData(key: _langKey);

    switch (savedLanguage) {
      case 'en':
        return const LanguageState(Locale('en'));

      case 'ar':
      default:
        return const LanguageState(Locale('ar'));
    }
  }

  Future<void> setArabic() async {
    await CacheHelper.saveData(key: _langKey, value: 'ar');

    emit(const LanguageState(Locale('ar')));
  }

  Future<void> setEnglish() async {
    await CacheHelper.saveData(key: _langKey, value: 'en');

    emit(const LanguageState(Locale('en')));
  }

  Future<void> toggleLanguage() async {
    if (state.isArabic) {
      await setEnglish();
    } else {
      await setArabic();
    }
  }
}

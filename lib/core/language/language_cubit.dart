import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/helpers/cache_helper.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  static const String _langKey = 'language';

  LanguageCubit() : super(_getInitialState());

  static LanguageState _getInitialState() {
    final saved = CacheHelper.getData(key: _langKey);
    if (saved == 'ar') {
      return const LanguageState(Locale('ar'));
    } else if (saved == 'en') {
      return const LanguageState(Locale('en'));
    }
    // Default to Arabic
    return const LanguageState(Locale('ar'));
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

import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/helpers/cache_helper.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  static const String _langKey = 'language';

  LanguageCubit() : super(_loadInitialState());

  static LanguageState _loadInitialState() {
    final saved = CacheHelper.getData(key: _langKey);
    if (saved == 'ar') return const LanguageState(isArabic: true);
    if (saved == 'en') return const LanguageState(isArabic: false);
    return const LanguageState(isArabic: true);
  }

  bool get isArabic => state.isArabic;

  Future<void> setArabic() async {
    await CacheHelper.saveData(key: _langKey, value: 'ar');
    emit(const LanguageState(isArabic: true));
  }

  Future<void> setEnglish() async {
    await CacheHelper.saveData(key: _langKey, value: 'en');
    emit(const LanguageState(isArabic: false));
  }

  Future<void> toggleLanguage() async {
    if (state.isArabic) {
      await setEnglish();
    } else {
      await setArabic();
    }
  }
}

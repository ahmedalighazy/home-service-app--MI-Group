part of 'language_cubit.dart';

class LanguageState {
  final bool isArabic;

  const LanguageState({required this.isArabic});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageState &&
          runtimeType == other.runtimeType &&
          isArabic == other.isArabic;

  @override
  int get hashCode => isArabic.hashCode;
}

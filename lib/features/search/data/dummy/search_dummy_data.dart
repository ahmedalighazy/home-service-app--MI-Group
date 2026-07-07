import 'package:home_service_app/core/themes/image/app_assets.dart';
import 'package:home_service_app/features/home/domain/entities/category_entity.dart';

import '../../domain/entities/search_result_entity.dart';
import '../../domain/entities/search_suggestion_entity.dart';

class SearchDummyData {
  const SearchDummyData._();

  static const recentSearches = ['تنظيف منزل', 'مكافحة آفات', 'تعقيم'];

  static const popularSearches = [
    'تنظيف أثاث',
    'تنظيف مطابخ',
    'تنظيف بعد التشطيب',
  ];

  static const suggestions = [
    SearchSuggestionEntity(
      title: 'تنظيف',
      description: 'حلول فورية لمكافحة الآفات',
      imagePath: AppAssets.insectsInHouse,
    ),
    SearchSuggestionEntity(
      title: 'مكافحة',
      description: 'إزالة الغبار وبقايا الدهانات',
      imagePath: AppAssets.banner,
    ),
    SearchSuggestionEntity(
      title: 'تعقيم',
      description: 'تعطير وتعقيم شامل للمساحات',
      imagePath: AppAssets.pestControlService,
    ),
    SearchSuggestionEntity(
      title: 'تعقيم',
      description: 'تعطير وتعقيم شامل للمساحات',
      imagePath: AppAssets.pestControlService,
    ),
  ];

  static const results = [
    SearchResultEntity(title: 'تنظيف منزل', id: ''),
    SearchResultEntity(title: 'تنظيف أثاث', id: ''),
    SearchResultEntity(title: 'تنظيف بعد التشطيب', id: ''),
    SearchResultEntity(title: 'مكافحة حشرات', id: ''),
  ];

  static List<CategoryEntity> categories = [
    // CategoryEntity(title: 'تنظيف مطابخ', iconPath: IconsPath.cleanerIcon),
    // CategoryEntity(title: 'تنظيف عادي', iconPath: IconsPath.manualCleanerIcon),
    // CategoryEntity(title: 'تنظيف سجاد', iconPath: IconsPath.bugIcon),
    // CategoryEntity(title: 'تنظيف كتب', iconPath: IconsPath.institutionsIcon),
  ];
}

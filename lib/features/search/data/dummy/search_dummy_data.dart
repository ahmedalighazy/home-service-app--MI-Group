import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';
import 'package:home_service_app/features/home/domain/entities/category_entity.dart';

import '../../domain/entities/search_result_entity.dart';
import '../../domain/entities/search_suggestion_entity.dart';

class SearchDummyData {
  SearchDummyData._();

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

  static final results = [
    SearchResultEntity(
      id: '1',
      title: 'تنظيف منزل',
      description: 'خدمة تنظيف منزل شاملة',
      type: 'service',
    ),
    SearchResultEntity(
      id: '2',
      title: 'تنظيف أثاث',
      description: 'خدمة تنظيف أثاث ومفروشات',
      type: 'service',
    ),
    SearchResultEntity(
      id: '3',
      title: 'تنظيف بعد التشطيب',
      description: 'خدمة تنظيف بعد التشطيب',
      type: 'service',
    ),
    SearchResultEntity(
      id: '4',
      title: 'مكافحة حشرات',
      description: 'خدمة مكافحة الحشرات',
      type: 'service',
    ),
  ];

  static const categories = [
    CategoryEntity(title: 'تنظيف مطابخ', iconPath: IconsPath.cleanerIcon),
    CategoryEntity(title: 'تنظيف عادي', iconPath: IconsPath.manualCleanerIcon),
    CategoryEntity(title: 'تنظيف سجاد', iconPath: IconsPath.bugIcon),
    CategoryEntity(title: 'تنظيف كتب', iconPath: IconsPath.institutionsIcon),
  ];
}

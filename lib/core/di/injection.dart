import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/repos/auth_repo.dart';

import '../../features/profile/data/repo/profile_repo.dart';
import '../language/language_cubit.dart';
import '../network/api_service.dart';
import '../network/dio_client.dart';
import '../utils/helpers/cache_helper.dart';
import '../utils/l10n/localization_service.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // ── Infrastructure ─────────────────────────────────────────

  await CacheHelper.init();

  if (!getIt.isRegistered<SharedPreferences>()) {
    getIt.registerSingleton<SharedPreferences>(CacheHelper.sharedPreferences);
  }

  final Dio dio = DioClient.getDio();

  if (!getIt.isRegistered<ApiService>()) {
    getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
  }

  // ── Auth ────────────────────────────────────────────────────

  if (!getIt.isRegistered<AuthRepo>()) {
    getIt.registerLazySingleton<AuthRepo>(() => AuthRepo(getIt<ApiService>()));
  }

  // ── Profile ─────────────────────────────────────────────────

  if (!getIt.isRegistered<ProfileRepo>()) {
    getIt.registerLazySingleton<ProfileRepo>(
      () => ProfileRepo(getIt<ApiService>()),
    );
  }

  // ── Core ────────────────────────────────────────────────────

  if (!getIt.isRegistered<LocalizationService>()) {
    getIt.registerSingleton<LocalizationService>(LocalizationService.instance);
  }

  if (!getIt.isRegistered<LanguageCubit>()) {
    getIt.registerLazySingleton<LanguageCubit>(() => LanguageCubit());
  }
}

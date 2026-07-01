import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/repos/auth_repo.dart';
import '../../features/auth/cubit/login/login_cubit.dart';
import '../../features/auth/cubit/register/register_cubit.dart';
import '../../features/auth/cubit/forgot_password/forgot_password_cubit.dart';

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
    getIt.registerLazySingleton<AuthRepo>(
      () => AuthRepo(getIt<ApiService>(), getIt<SharedPreferences>()),
    );
  }

  if (!getIt.isRegistered<LoginCubit>()) {
    getIt.registerLazySingleton<LoginCubit>(
      () => LoginCubit(getIt<AuthRepo>()),
    );
  }

  if (!getIt.isRegistered<RegisterCubit>()) {
    getIt.registerLazySingleton<RegisterCubit>(
      () => RegisterCubit(getIt<AuthRepo>()),
    );
  }

  if (!getIt.isRegistered<ForgotPasswordCubit>()) {
    getIt.registerLazySingleton<ForgotPasswordCubit>(
      () => ForgotPasswordCubit(getIt<AuthRepo>()),
    );
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

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/profile/data/repo/profile_repo.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../network/api_service.dart';
import '../network/dio_client.dart';
import '../utils/helpers/cache_helper.dart';
import '../utils/l10n/localization_service.dart';
import '../../features/auth/presentation/cubits/auth_cubit.dart';
import '../../features/auth/presentation/cubits/forget_password_cubit.dart';
import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/datasources/auth_local_datasource_real.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/datasources/auth_remote_datasource_impl.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/complete_profile_usecase.dart';
import '../../features/auth/domain/usecases/get_current_user_usecase.dart';
import '../../features/auth/domain/usecases/refresh_token_usecase.dart';
import '../../features/auth/domain/usecases/request_password_reset_usecase.dart';
import '../../features/auth/domain/usecases/reset_password_usecase.dart';
import '../../features/auth/domain/usecases/send_otp_usecase.dart';
import '../../features/auth/domain/usecases/sign_in_usecase.dart';
import '../../features/auth/domain/usecases/sign_in_with_apple_usecase.dart';
import '../../features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import '../../features/auth/domain/usecases/sign_out_usecase.dart';
import '../../features/auth/domain/usecases/verify_otp_usecase.dart';
import '../../features/auth/domain/usecases/verify_reset_code_usecase.dart';
import '../language/language_cubit.dart';
import 'injection.config.dart';
import 'register_module.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> setupGetIt() async {
  getIt.init();

  if (!getIt.isRegistered<SharedPreferences>()) {
    getIt.registerLazySingleton<SharedPreferences>(
      () => CacheHelper.sharedPreferences,
    );
  }

  if (!getIt.isRegistered<AuthLocalDataSource>()) {
    getIt.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceReal(getIt<SharedPreferences>()),
    );
  }

  Dio dio = DioClient.getDio();

  if (!getIt.isRegistered<ApiService>()) {
    getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
  }

  if (!getIt.isRegistered<AuthRemoteDataSource>()) {
    getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(getIt<ApiService>()),
    );
  }

  if (!getIt.isRegistered<AuthRepository>()) {
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: getIt<AuthRemoteDataSource>(),
        localDataSource: getIt<AuthLocalDataSource>(),
      ),
    );
  }

  if (!getIt.isRegistered<SignInUseCase>()) {
    getIt.registerLazySingleton(() => SignInUseCase(getIt<AuthRepository>()));
  }
  if (!getIt.isRegistered<VerifyOtpUseCase>()) {
    getIt.registerLazySingleton(
      () => VerifyOtpUseCase(getIt<AuthRepository>()),
    );
  }
  if (!getIt.isRegistered<CompleteProfileUseCase>()) {
    getIt.registerLazySingleton(
      () => CompleteProfileUseCase(getIt<AuthRepository>()),
    );
  }
  if (!getIt.isRegistered<RequestPasswordResetUseCase>()) {
    getIt.registerLazySingleton(
      () => RequestPasswordResetUseCase(getIt<AuthRepository>()),
    );
  }
  if (!getIt.isRegistered<VerifyResetCodeUseCase>()) {
    getIt.registerLazySingleton(
      () => VerifyResetCodeUseCase(getIt<AuthRepository>()),
    );
  }
  if (!getIt.isRegistered<ResetPasswordUseCase>()) {
    getIt.registerLazySingleton(
      () => ResetPasswordUseCase(getIt<AuthRepository>()),
    );
  }
  if (!getIt.isRegistered<SignInWithGoogleUseCase>()) {
    getIt.registerLazySingleton(
      () => SignInWithGoogleUseCase(getIt<AuthRepository>()),
    );
  }
  if (!getIt.isRegistered<SignInWithAppleUseCase>()) {
    getIt.registerLazySingleton(
      () => SignInWithAppleUseCase(getIt<AuthRepository>()),
    );
  }
  if (!getIt.isRegistered<GetCurrentUserUseCase>()) {
    getIt.registerLazySingleton(
      () => GetCurrentUserUseCase(getIt<AuthRepository>()),
    );
  }
  if (!getIt.isRegistered<RefreshTokenUseCase>()) {
    getIt.registerLazySingleton(
      () => RefreshTokenUseCase(getIt<AuthRepository>()),
    );
  }
  if (!getIt.isRegistered<SignOutUseCase>()) {
    getIt.registerLazySingleton(() => SignOutUseCase(getIt<AuthRepository>()));
  }
  if (!getIt.isRegistered<SendOtpUseCase>()) {
    getIt.registerLazySingleton(() => SendOtpUseCase(getIt<AuthRepository>()));
  }

  if (getIt.isRegistered<AuthCubit>()) {
    getIt.unregister<AuthCubit>();
  }
  getIt.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      getIt<SignInUseCase>(),
      getIt<VerifyOtpUseCase>(),
      getIt<CompleteProfileUseCase>(),
      getIt<RequestPasswordResetUseCase>(),
      getIt<VerifyResetCodeUseCase>(),
      getIt<ResetPasswordUseCase>(),
      getIt<SignInWithGoogleUseCase>(),
      getIt<SignInWithAppleUseCase>(),
      getIt<GetCurrentUserUseCase>(),
      getIt<RefreshTokenUseCase>(),
      getIt<SignOutUseCase>(),
      getIt<SendOtpUseCase>(),
    ),
  );

  if (!getIt.isRegistered<ForgetPasswordCubit>()) {
    getIt.registerFactory<ForgetPasswordCubit>(() => ForgetPasswordCubit());
  }

  try {
    registerCoreModules(getIt);
  } catch (_) {}

  if (!getIt.isRegistered<LocalizationService>()) {
    getIt.registerSingleton<LocalizationService>(LocalizationService.instance);
  }
  if (!getIt.isRegistered<LanguageCubit>()) {
    getIt.registerLazySingleton<LanguageCubit>(() => LanguageCubit());
  }
  if (!getIt.isRegistered<ProfileRepo>()) {
    getIt.registerLazySingleton<ProfileRepo>(
      () => ProfileRepo(getIt<ApiService>()),
    );
  }
  if (!getIt.isRegistered<ProfileCubit>()) {
    getIt.registerFactory<ProfileCubit>(
      () => ProfileCubit(getIt<ProfileRepo>()),
    );
  }
}

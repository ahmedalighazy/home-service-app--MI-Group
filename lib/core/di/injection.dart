import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:home_service_app/features/notification/data/datasources/remote/notification_remote_data_source.dart';
import 'package:home_service_app/features/notification/data/datasources/remote/notification_remote_data_source_impl.dart';
import 'package:home_service_app/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:home_service_app/features/notification/domain/repositories/notification_repository.dart';
import 'package:home_service_app/features/notification/domain/usecases/get_notifications_usecase.dart';
import 'package:home_service_app/features/notification/domain/usecases/mark_notification_as_read_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/usecases/get_profile_usecase.dart';
import '../../features/profile/domain/usecases/update_profile_usecase.dart';
import '../../features/profile/domain/usecases/change_password_usecase.dart';
import '../../features/profile/domain/usecases/delete_account_usecase.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../../features/address/presentation/cubit/address_cubit.dart';
import '../../features/auth/data/repos/auth_repo.dart';
import '../../features/home/data/datasources/local/home_local_data_source.dart';
import '../../features/home/data/datasources/local/home_local_data_source_impl.dart';
import '../../features/home/data/datasources/remote/home_remote_data_source.dart';
import '../../features/home/data/datasources/remote/home_remote_data_source_impl.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_home_data_usecase.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/notification/presentation/cubit/notification_cubit.dart';
import '../../features/profile/data/repo/profile_repo.dart';
import '../language/language_cubit.dart';
import '../network/api_service.dart';
import '../network/dio_client.dart';
import '../network/network_info.dart';
import '../network/network_info_impl.dart';

import '../token/token_manager.dart';
import '../utils/helpers/cache_helper.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // ── Infrastructure ─────────────────────────────────────────

  await CacheHelper.init();

  if (!getIt.isRegistered<SharedPreferences>()) {
    getIt.registerSingleton<SharedPreferences>(CacheHelper.sharedPreferences);
  }

  // if (!getIt.isRegistered<GoRouter>()) {
  //   getIt.registerLazySingleton<GoRouter>(() => AppRouter.router);
  // }

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

  // if (!getIt.isRegistered<LocalizationService>()) {
  //   getIt.registerSingleton<LocalizationService>(LocalizationService.instance);
  // }

  if (!getIt.isRegistered<LanguageCubit>()) {
    getIt.registerLazySingleton<LanguageCubit>(() => LanguageCubit());
  }

  // ── Network ────────────────────────────────────────────────

  if (!getIt.isRegistered<TokenManager>()) {
    getIt.registerLazySingleton<TokenManager>(() => TokenManager());
  }

  final dio = DioClient.getDio(tokenManager: getIt<TokenManager>());

  if (!getIt.isRegistered<ApiService>()) {
    getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
  }

  // ── Home Feature ──────────────────────────────────────────

  if (!getIt.isRegistered<NetworkInfo>()) {
    getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(Connectivity()),
    );
  }

  if (!getIt.isRegistered<HomeLocalDataSource>()) {
    getIt.registerLazySingleton<HomeLocalDataSource>(
      () => HomeLocalDataSourceImpl(),
    );
  }

  if (!getIt.isRegistered<HomeRemoteDataSource>()) {
    getIt.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(getIt()),
    );
  }

  if (!getIt.isRegistered<HomeRepository>()) {
    getIt.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(
        getIt<HomeLocalDataSource>(),
        getIt<HomeRemoteDataSource>(),
        getIt<NetworkInfo>(),
      ),
    );
  }

  if (!getIt.isRegistered<GetHomeDataUseCase>()) {
    getIt.registerLazySingleton<GetHomeDataUseCase>(
      () => GetHomeDataUseCase(getIt<HomeRepository>()),
    );
  }

  // ── Notification Feature ───────────────────────────────────

  if (!getIt.isRegistered<NotificationRemoteDataSource>()) {
    getIt.registerLazySingleton<NotificationRemoteDataSource>(
      () => NotificationRemoteDataSourceImpl(getIt<ApiService>()),
    );
  }

  if (!getIt.isRegistered<NotificationRepository>()) {
    getIt.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(
        getIt<NotificationRemoteDataSource>(),
        getIt<NetworkInfo>(),
      ),
    );
  }

  if (!getIt.isRegistered<GetNotificationsUseCase>()) {
    getIt.registerLazySingleton<GetNotificationsUseCase>(
      () => GetNotificationsUseCase(getIt<NotificationRepository>()),
    );
  }
  // ── Cubits ────────────────────────────────────────────────

  if (!getIt.isRegistered<HomeCubit>()) {
    getIt.registerLazySingleton<HomeCubit>(
      () => HomeCubit(getIt<GetHomeDataUseCase>()),
    );
  }

  if (!getIt.isRegistered<AddressCubit>()) {
    getIt.registerLazySingleton<AddressCubit>(() => AddressCubit());
  }
  if (!getIt.isRegistered<MarkNotificationAsReadUseCase>()) {
    getIt.registerLazySingleton<MarkNotificationAsReadUseCase>(
      () => MarkNotificationAsReadUseCase(getIt<NotificationRepository>()),
    );
  }

  getIt.registerLazySingleton<NotificationCubit>(
    () => NotificationCubit(
      getIt<GetNotificationsUseCase>(),
      getIt<MarkNotificationAsReadUseCase>(),
    ),
  );

  // ============= Profile Feature (Clean Architecture) =============
  if (!getIt.isRegistered<ProfileRepository>()) {
    getIt.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(getIt<ApiService>()),
    );
  }
  if (!getIt.isRegistered<GetProfileUseCase>()) {
    getIt.registerLazySingleton(
      () => GetProfileUseCase(getIt<ProfileRepository>()),
    );
  }
  if (!getIt.isRegistered<UpdateProfileUseCase>()) {
    getIt.registerLazySingleton(
      () => UpdateProfileUseCase(getIt<ProfileRepository>()),
    );
  }
  if (!getIt.isRegistered<ChangePasswordUseCase>()) {
    getIt.registerLazySingleton(
      () => ChangePasswordUseCase(getIt<ProfileRepository>()),
    );
  }
  if (!getIt.isRegistered<DeleteAccountUseCase>()) {
    getIt.registerLazySingleton(
      () => DeleteAccountUseCase(getIt<ProfileRepository>()),
    );
  }
  if (!getIt.isRegistered<ProfileCubit>()) {
    getIt.registerLazySingleton<ProfileCubit>(
      () => ProfileCubit(
        getIt<GetProfileUseCase>(),
        getIt<UpdateProfileUseCase>(),
        getIt<ChangePasswordUseCase>(),
        getIt<DeleteAccountUseCase>(),
      ),
    );
  }
}

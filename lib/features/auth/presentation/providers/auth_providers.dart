import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:home_service_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:home_service_app/features/auth/data/datasources/auth_local_datasource_real.dart';
import 'package:home_service_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:home_service_app/features/auth/data/datasources/auth_remote_datasource_impl_real.dart';
import 'package:home_service_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:home_service_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:home_service_app/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:home_service_app/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:home_service_app/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:home_service_app/features/auth/domain/usecases/complete_profile_usecase.dart';
import 'package:home_service_app/features/auth/domain/usecases/request_password_reset_usecase.dart';
import 'package:home_service_app/features/auth/domain/usecases/verify_reset_code_usecase.dart';
import 'package:home_service_app/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:home_service_app/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:home_service_app/features/auth/domain/usecases/sign_in_with_apple_usecase.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit_v2.dart';
import 'package:home_service_app/features/auth/logic/cubits/auth_cubit.dart';
import 'package:home_service_app/core/di/injection.dart';

/// Setup Auth Providers for Dependency Injection
/// Call this at app startup before runApp()
Future<void> setupAuthProviders() async {
  // External Dependencies
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerSingleton<http.Client>(http.Client());

  // Data Sources
  getIt.registerSingleton<AuthLocalDataSource>(
    AuthLocalDataSourceReal(getIt<SharedPreferences>()),
  );
  getIt.registerSingleton<AuthRemoteDataSource>(
    AuthRemoteDataSourceReal(
      httpClient: getIt<http.Client>(),
      baseUrl: 'https://api.example.com', // Replace with real API URL
    ),
  );

  // Repository
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      localDataSource: getIt<AuthLocalDataSource>(),
    ),
  );

  // Use Cases
  getIt.registerSingleton<SignInUseCase>(SignInUseCase(getIt<AuthRepository>()));
  getIt.registerSingleton<SendOtpUseCase>(SendOtpUseCase(getIt<AuthRepository>()));
  getIt.registerSingleton<VerifyOtpUseCase>(VerifyOtpUseCase(getIt<AuthRepository>()));
  getIt.registerSingleton<CompleteProfileUseCase>(CompleteProfileUseCase(getIt<AuthRepository>()));
  
  final passwordResetUseCase = RequestPasswordResetUseCase(getIt<AuthRepository>());
  final verifyResetCodeUseCase = VerifyResetCodeUseCase(getIt<AuthRepository>());
  final resetPasswordUseCase = ResetPasswordUseCase(getIt<AuthRepository>());
  getIt.registerSingleton<RequestPasswordResetUseCase>(passwordResetUseCase);
  getIt.registerSingleton<VerifyResetCodeUseCase>(verifyResetCodeUseCase);
  getIt.registerSingleton<ResetPasswordUseCase>(resetPasswordUseCase);
  
  getIt.registerSingleton<SignInWithGoogleUseCase>(SignInWithGoogleUseCase(getIt<AuthRepository>()));
  getIt.registerSingleton<SignInWithAppleUseCase>(SignInWithAppleUseCase(getIt<AuthRepository>()));

  // Cubits
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(),
  );
  
  getIt.registerSingleton<AuthCubitV2>(
    AuthCubitV2(
      signInUseCase: getIt<SignInUseCase>(),
      sendOtpUseCase: getIt<SendOtpUseCase>(),
      verifyOtpUseCase: getIt<VerifyOtpUseCase>(),
      completeProfileUseCase: getIt<CompleteProfileUseCase>(),
      requestPasswordResetUseCase: getIt<RequestPasswordResetUseCase>(),
      verifyResetCodeUseCase: getIt<VerifyResetCodeUseCase>(),
      resetPasswordUseCase: getIt<ResetPasswordUseCase>(),
      signInWithGoogleUseCase: getIt<SignInWithGoogleUseCase>(),
      signInWithAppleUseCase: getIt<SignInWithAppleUseCase>(),
    ),
  );
  
  // Verify registration
  if (kDebugMode) {
    print('AuthCubit registered: ${getIt.isRegistered<AuthCubit>()}');
    print('AuthCubitV2 registered: ${getIt.isRegistered<AuthCubitV2>()}');
  }
}

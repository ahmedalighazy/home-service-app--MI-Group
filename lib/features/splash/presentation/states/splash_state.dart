import '../../domain/entities/app_config_entity.dart';

abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashLoaded extends SplashState {
  final AppConfigEntity config;
  
  SplashLoaded(this.config);
}

class SplashError extends SplashState {
  final String message;
  
  SplashError(this.message);
}

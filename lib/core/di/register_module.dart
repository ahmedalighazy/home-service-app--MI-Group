import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../network/network_info.dart';
import '../network/network_info_impl.dart';

/// Registers core services for dependency injection.
void registerCoreModules(GetIt getIt) {
  // Register Connectivity instance
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());

  // Register NetworkInfo implementation
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt<Connectivity>()));
}

/// Module class for dependency injection
class RegisterModule {
  Connectivity get connectivity => Connectivity();
}

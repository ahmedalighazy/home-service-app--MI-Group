import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../network/network_info.dart';
import '../network/network_info_impl.dart';

void registerCoreModules(GetIt getIt) {

  getIt.registerLazySingleton<Connectivity>(() => Connectivity());

  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt<Connectivity>()));
}

class RegisterModule {
  Connectivity get connectivity => Connectivity();
}

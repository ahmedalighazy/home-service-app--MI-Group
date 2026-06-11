import 'package:get_it/get_it.dart';
import '../language/language_cubit.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';
import 'register_module.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Setup auth providers first (includes data sources, repository, use cases, and cubits)
  await setupAuthProviders();

  // Register core services (e.g., Connectivity, NetworkInfo)
  registerCoreModules(getIt);

  // Register other cubits
  getIt.registerSingleton<LanguageCubit>(LanguageCubit());
}

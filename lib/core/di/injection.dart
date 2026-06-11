import 'package:get_it/get_it.dart';
import '../language/language_cubit.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Setup auth providers first (includes data sources, repository, use cases, and cubits)
  await setupAuthProviders();
  
  // Register other cubits
  getIt.registerSingleton<LanguageCubit>(LanguageCubit());
}

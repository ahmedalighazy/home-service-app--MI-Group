// Dependency Injection setup using GetIt
import 'package:get_it/get_it.dart';
import '../../features/auth/logic/cubits/auth_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Register cubits
  getIt.registerFactory<AuthCubit>(() => AuthCubit());
}

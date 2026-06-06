import 'package:get_it/get_it.dart';
import '../../features/auth/logic/cubits/auth_cubit.dart';
import '../language/language_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerSingleton<AuthCubit>(AuthCubit());
  getIt.registerSingleton<LanguageCubit>(LanguageCubit());
}

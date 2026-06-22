import 'package:get_it/get_it.dart' as _i174;
import 'package:home_service_app/core/network/dio_client.dart' as _i953;
import 'package:home_service_app/core/network/network_info.dart' as _i702;
import 'package:home_service_app/features/address/presentation/cubit/address_cubit.dart'
    as _i565;
import 'package:home_service_app/features/auth/presentation/cubits/forget_password_cubit.dart'
    as _i83;
import 'package:home_service_app/features/home/data/datasources/local/home_local_data_source.dart'
    as _i516;
import 'package:home_service_app/features/home/data/datasources/local/home_local_data_source_impl.dart'
    as _i678;
import 'package:home_service_app/features/home/data/datasources/remote/home_remote_data_source.dart'
    as _i3;
import 'package:home_service_app/features/home/data/datasources/remote/home_remote_data_source_impl.dart'
    as _i1023;
import 'package:home_service_app/features/home/data/repositories/home_repository_impl.dart'
    as _i761;
import 'package:home_service_app/features/home/domain/repositories/home_repository.dart'
    as _i138;
import 'package:home_service_app/features/home/domain/usecases/get_home_data_usecase.dart'
    as _i1057;
import 'package:home_service_app/features/home/presentation/cubit/home_cubit.dart'
    as _i829;
import 'package:home_service_app/features/notification/presentation/cubit/notification_cubit.dart'
    as _i745;
import 'package:home_service_app/features/search/domain/repositories/search_repository.dart'
    as _i200;
import 'package:home_service_app/features/search/domain/usecases/search_usecase.dart'
    as _i406;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {

  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i565.AddressCubit>(() => _i565.AddressCubit());
    gh.factory<_i83.ForgetPasswordCubit>(() => _i83.ForgetPasswordCubit());
    gh.lazySingleton<_i953.DioClient>(() => _i953.DioClient());
    gh.lazySingleton<_i745.NotificationCubit>(() => _i745.NotificationCubit());
    gh.lazySingleton<_i516.HomeLocalDataSource>(
      () => _i678.HomeLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i406.SearchUseCase>(
      () => _i406.SearchUseCase(gh<_i200.SearchRepository>()),
    );
    gh.lazySingleton<_i3.HomeRemoteDataSource>(
      () => _i1023.HomeRemoteDataSourceImpl(gh<_i953.DioClient>()),
    );
    gh.lazySingleton<_i138.HomeRepository>(
      () => _i761.HomeRepositoryImpl(
        gh<_i516.HomeLocalDataSource>(),
        gh<_i3.HomeRemoteDataSource>(),
        gh<_i702.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i1057.GetHomeDataUseCase>(
      () => _i1057.GetHomeDataUseCase(gh<_i138.HomeRepository>()),
    );
    gh.factory<_i829.HomeCubit>(
      () => _i829.HomeCubit(gh<_i1057.GetHomeDataUseCase>()),
    );
    return this;
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:get_it/get_it.dart' as _i174;
import 'package:home_service_app/core/di/register_module.dart' as _i866;
import 'package:home_service_app/core/network/dio_client.dart' as _i953;
import 'package:home_service_app/core/network/network_info.dart' as _i702;
import 'package:home_service_app/core/network/network_info_impl.dart' as _i799;
import 'package:home_service_app/features/address/presentation/cubit/address_cubit.dart'
    as _i565;
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart'
    as _i694;
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
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i565.AddressCubit>(() => _i565.AddressCubit());
    gh.factory<_i694.AuthCubit>(() => _i694.AuthCubit());
    gh.lazySingleton<_i895.Connectivity>(() => registerModule.connectivity);
    gh.lazySingleton<_i953.DioClient>(() => _i953.DioClient());
    gh.lazySingleton<_i745.NotificationCubit>(() => _i745.NotificationCubit());
    gh.lazySingleton<_i516.HomeLocalDataSource>(
      () => _i678.HomeLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i702.NetworkInfo>(
      () => _i799.NetworkInfoImpl(gh<_i895.Connectivity>()),
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

class _$RegisterModule extends _i866.RegisterModule {}

import 'package:home_service_app/core/network/dio_client.dart';
import 'package:injectable/injectable.dart';

import '../../models/home_data_model.dart';
import 'home_remote_data_source.dart';

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient dioClient;

  HomeRemoteDataSourceImpl(this.dioClient);

  @override
  Future<HomeDataModel> getHomeData() async {
    throw UnimplementedError();
  }
}

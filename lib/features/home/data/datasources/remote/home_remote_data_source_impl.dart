import 'package:injectable/injectable.dart';

import '../../models/home_data_model.dart';
import 'home_remote_data_source.dart';

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl();

  @override
  Future<HomeDataModel> getHomeData() async {
    throw UnimplementedError();
  }
}

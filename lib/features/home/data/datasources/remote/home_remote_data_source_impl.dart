import 'package:injectable/injectable.dart';

import '../../../../../core/network/api_service.dart';
import '../../models/home_data_model.dart';
import 'home_remote_data_source.dart';

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSourceImpl(this.apiService);

  @override
  Future<HomeDataModel> getHomeData() async {
    return await apiService.getHome();
  }
}

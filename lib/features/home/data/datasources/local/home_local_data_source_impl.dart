import 'package:home_service_app/features/home/data/datasources/local/home_local_data_source.dart';
import 'package:home_service_app/features/home/data/dummy/home_dummy_data.dart';
import 'package:home_service_app/features/home/data/models/home_data_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeLocalDataSource)
class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<HomeDataModel> getHomeData() async {
    return HomeDummyData.homeData;
  }
}

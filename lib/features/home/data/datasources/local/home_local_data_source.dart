import '../../models/home_data_model.dart';

abstract class HomeLocalDataSource {
  Future<HomeDataModel> getHomeData();
}

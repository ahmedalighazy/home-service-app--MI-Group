class AppConfigModel {
  final bool isFirstLaunch;
  final bool isLoggedIn;
  final String? userId;

  AppConfigModel({
    required this.isFirstLaunch,
    required this.isLoggedIn,
    this.userId,
  });
}

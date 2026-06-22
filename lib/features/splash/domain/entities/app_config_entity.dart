class AppConfigEntity {
  final bool isFirstLaunch;
  final bool isLoggedIn;
  final String? userId;

  AppConfigEntity({
    required this.isFirstLaunch,
    required this.isLoggedIn,
    this.userId,
  });
}

class ServiceItem {
  final String id;
  final String title;
  final String imagePath;
  final String? badge;
  final String? discount;

  ServiceItem({
    required this.id,
    required this.title,
    required this.imagePath,
    this.badge,
    this.discount,
  });
}

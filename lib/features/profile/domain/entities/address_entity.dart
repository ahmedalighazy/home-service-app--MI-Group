class AddressEntity {
  final String id;
  final String label;
  final String details;
  final bool isDefault;
  final String iconPath;

  AddressEntity({
    required this.id,
    required this.label,
    required this.details,
    this.isDefault = false,
    required this.iconPath,
  });
}

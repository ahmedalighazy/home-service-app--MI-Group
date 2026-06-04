class AddressModel {
  final String id;
  final String label;
  final String details;
  final bool isDefault;
  final String iconPath;

  AddressModel({
    required this.id,
    required this.label,
    required this.details,
    this.isDefault = false,
    required this.iconPath,
  });
}

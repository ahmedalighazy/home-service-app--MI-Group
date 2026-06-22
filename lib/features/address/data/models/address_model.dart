class AddressModel {
  final String title;
  final String address;
  final String iconPath;
  final bool isSelected;

  AddressModel({
    required this.title,
    required this.address,
    required this.iconPath,
    this.isSelected = false,
  });

  AddressModel copyWith({
    String? title,
    String? address,
    String? iconPath,
    bool? isSelected,
  }) {
    return AddressModel(
      title: title ?? this.title,
      address: address ?? this.address,
      iconPath: iconPath ?? this.iconPath,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

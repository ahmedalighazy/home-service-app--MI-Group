import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String title;
  final String address;
  final String iconPath;
  final bool isSelected;

  const AddressEntity({
    required this.title,
    required this.address,
    required this.iconPath,
    this.isSelected = false,
  });

  AddressEntity copyWith({
    String? title,
    String? address,
    String? iconPath,
    bool? isSelected,
  }) {
    return AddressEntity(
      title: title ?? this.title,
      address: address ?? this.address,
      iconPath: iconPath ?? this.iconPath,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [title, address, iconPath, isSelected];
}

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

  @override
  List<Object?> get props => [title, address, iconPath, isSelected];
}

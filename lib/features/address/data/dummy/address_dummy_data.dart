import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/features/address/domain/entities/address_entity.dart';

class AddressDummyData {
  const AddressDummyData._();

  static const addresses = [
    AddressEntity(
      title: 'المنزل',
      address: '18 شارع الوعب، الدوحة',
      iconPath: IconsPath.home,
      isSelected: true,
    ),

    AddressEntity(
      title: 'العمل',
      address: 'برج الأعمال، الدوحة',
      iconPath: IconsPath.institutionsIcon,
    ),
  ];
}

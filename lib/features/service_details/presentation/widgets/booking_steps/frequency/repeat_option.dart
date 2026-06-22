import '../../../../data/models/repeat_type.dart';

class RepeatOption {
  final RepeatType type;
  final String title;
  final String? discount;
  final bool recommended;

  const RepeatOption({
    required this.type,
    required this.title,
    this.discount,
    this.recommended = false,
  });
}

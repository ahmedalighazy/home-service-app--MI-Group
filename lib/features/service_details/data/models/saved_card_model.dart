/// Represents a saved payment card.
class SavedCard {
  final String last4;
  final String holder;
  final String brand; // 'VISA' | 'MC'
  final bool isDefault;

  const SavedCard({
    required this.last4,
    required this.holder,
    required this.brand,
    this.isDefault = false,
  });

  /// Mock saved cards shown on the Payment step.
  static const List<SavedCard> savedCards = [
    SavedCard(last4: '2345', holder: 'Ahmed A', brand: 'VISA', isDefault: true),
    SavedCard(last4: '2345', holder: 'Ahmed A', brand: 'MC'),
  ];
}


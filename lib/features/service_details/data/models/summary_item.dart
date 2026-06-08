class SummaryItem {
  final String title;
  final double price;
  int qty;

  SummaryItem({required this.title, required this.price, this.qty = 1});

  double get totalPrice => price * qty;
}


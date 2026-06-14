extension EmailFormatter on String {
  String truncateEmail() {
    final atIndex = indexOf('@');
    if (atIndex <= 5) return this;
    return '${substring(0, 5)}...${substring(atIndex)}';
  }
}
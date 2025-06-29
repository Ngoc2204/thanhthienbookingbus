class Promotion {
  final String id;
  final String code;
  final String description;
  final double discountAmount;  // Có thể % hoặc số tiền
  final DateTime expiredAt;

  Promotion({
    required this.id,
    required this.code,
    required this.description,
    required this.discountAmount,
    required this.expiredAt,
  });
}

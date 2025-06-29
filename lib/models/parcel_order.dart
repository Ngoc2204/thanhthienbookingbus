enum OrderStatus { pending, delivering, delivered, canceled }

class ParcelOrder {
  final String id;
  final String senderName;
  final String senderPhone;
  final String receiverName;
  final String receiverPhone;
  final String itemInfo;         // Mô tả kiện hàng
  final String pickUpMethod;     // Lấy tại bến, nhận tại nhà...
  final double price;
  final String payer;            // Người gửi/người nhận
  final OrderStatus status;
  final DateTime createdAt;

  ParcelOrder({
    required this.id,
    required this.senderName,
    required this.senderPhone,
    required this.receiverName,
    required this.receiverPhone,
    required this.itemInfo,
    required this.pickUpMethod,
    required this.price,
    required this.payer,
    this.status = OrderStatus.pending,
    required this.createdAt,
  });
}

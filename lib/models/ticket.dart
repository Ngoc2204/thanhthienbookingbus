enum TicketStatus { pending, paid, canceled }

class Ticket {
  final String id;          // Mã vé (có thể là QR code)
  final String userId;      // Ai đặt vé
  final String tripId;      // Thuộc chuyến xe nào
  final String seatNumber;
  final String name;
  final String phone;
  final String email;
  final double price;
  final TicketStatus status;

  Ticket({
    required this.id,
    required this.userId,
    required this.tripId,
    required this.seatNumber,
    required this.name,
    required this.phone,
    required this.email,
    required this.price,
    this.status = TicketStatus.pending,
  });
}

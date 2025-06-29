class Trip {
  final String id;
  final String routeId;
  final DateTime departureTime;
  final String vehicleType;   // Ghế ngồi, Giường nằm...
  final double price;
  final int availableSeats;
  final List<String> bookedSeats; // Danh sách số ghế đã đặt

  Trip({
    required this.id,
    required this.routeId,
    required this.departureTime,
    required this.vehicleType,
    required this.price,
    required this.availableSeats,
    required this.bookedSeats,
  });
}

class RouteModel {
  final String id;
  final String startPoint;
  final String endPoint;
  final Duration travelTime;

  RouteModel({
    required this.id,
    required this.startPoint,
    required this.endPoint,
    required this.travelTime,
  });
}

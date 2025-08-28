class TripEntity {
  final String id;
  final String title;
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final double cost;

  const TripEntity({
    required this.id,
    required this.title,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.cost,
  });
}

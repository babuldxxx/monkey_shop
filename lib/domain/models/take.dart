class Take {
  final int? id;
  final int userId;
  final int productId;
  final DateTime takenAt;
  final DateTime? returnedAt;

  Take({
    this.id,
    required this.userId,
    required this.productId,
    required this.takenAt,
    this.returnedAt,
  });
}

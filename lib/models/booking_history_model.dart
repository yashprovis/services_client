class CompletedBooking {
  final String bookingId;
  final String bookingDate;
  final String bookingDuration;
  final double bookingTotal;
  final double? bookingRating;
  final String? bookingReview;
  final String customerName;
  final String customerId;
  final String workerName;
  final String workerId;

  const CompletedBooking({
    required this.bookingId,
    required this.bookingDate,
    required this.bookingDuration,
    required this.bookingTotal,
    this.bookingRating,
    this.bookingReview,
    required this.customerName,
    required this.customerId,
    required this.workerName,
    required this.workerId,
  });
}

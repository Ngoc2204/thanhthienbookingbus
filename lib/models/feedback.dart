enum FeedbackStatus { pending, processing, resolved }

class FeedbackModel {
  final String id;
  final String userId;
  final String message;
  final FeedbackStatus status;
  final DateTime createdAt;

  FeedbackModel({
    required this.id,
    required this.userId,
    required this.message,
    this.status = FeedbackStatus.pending,
    required this.createdAt,
  });
}

import 'package:flutter/foundation.dart';

@immutable
class Vote {
  final String userId;

  const Vote({
    required this.userId,
  });

  Vote copyWith({
    String? userId,
    DateTime? createdAt,
  }) {
    return Vote(
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  static Vote fromJson(Map<String, dynamic> json) {
    return Vote(
      userId: json['userId'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Vote && other.userId == userId;
  }

  @override
  int get hashCode => userId.hashCode;

  @override
  String toString() {
    return 'Upvote(userId: $userId)';
  }
}

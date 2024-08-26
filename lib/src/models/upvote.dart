import 'package:flutter/foundation.dart';

@immutable
class Upvote {
  final String userId;

  const Upvote({
    required this.userId,
  });

  Upvote copyWith({
    String? userId,
    DateTime? createdAt,
  }) {
    return Upvote(
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  static Upvote fromJson(Map<String, dynamic> json) {
    return Upvote(
      userId: json['userId'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Upvote && other.userId == userId;
  }

  @override
  int get hashCode => userId.hashCode;

  @override
  String toString() {
    return 'Upvote(userId: $userId)';
  }
}

import 'package:flutter/foundation.dart';

@immutable
class Vote {
  const Vote({required this.userId});

  factory Vote.fromJson(Map<String, dynamic> json) {
    return Vote(userId: json['userId'] as String);
  }
  final String userId;

  Vote copyWith({String? userId}) {
    return Vote(userId: userId ?? this.userId);
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'createdAt': DateTime.now().toIso8601String()};
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
    return 'Vote(userId: $userId)';
  }
}

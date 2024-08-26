import 'package:flutter/foundation.dart';

@immutable
class Creator {
  final String userId;
  final String username;
  final bool isAdmin; // New field to indicate if the user is an admin

  const Creator({
    required this.userId,
    required this.username,
    this.isAdmin = false,
  });

  Creator copyWith({
    String? userId,
    String? username,
    bool? isAdmin,
  }) {
    return Creator(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'isAdmin': isAdmin,
    };
  }

  static Creator fromJson(Map<String, dynamic> json) {
    return Creator(
      userId: json['userId'],
      username: json['username'],
      isAdmin: json['isAdmin'] ?? false,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Creator &&
        other.userId == userId &&
        other.username == username &&
        other.isAdmin == isAdmin;
  }

  @override
  int get hashCode => userId.hashCode ^ username.hashCode ^ isAdmin.hashCode;

  @override
  String toString() {
    return 'Creator(userId: $userId, username: $username, isAdmin: $isAdmin)';
  }
}

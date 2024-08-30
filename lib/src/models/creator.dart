import 'package:flutter/foundation.dart';

@immutable
class Creator {
  const Creator({
    required this.userId,
    required this.username,
    this.isAdmin = false,
  });

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      userId: json['userId'] as String,
      username: json['username'] as String,
      isAdmin: json['isAdmin'] as bool,
    );
  }

  final String userId;
  final String username;
  final bool isAdmin;

  Creator copyWith({String? userId, String? username, bool? isAdmin}) {
    return Creator(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'username': username, 'isAdmin': isAdmin};
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

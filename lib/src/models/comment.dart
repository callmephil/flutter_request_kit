import 'package:flutter/foundation.dart';

@immutable
class Comment {
  const Comment({
    required this.id,
    required this.userId,
    required this.username,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as String,
      userId: json['userId'] as String,
      username: json['username'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String? ?? ''),
      updatedAt: DateTime.parse(json['updatedAt'] as String? ?? ''),
    );
  }

  final String id;
  final String userId;
  final String username;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  Comment copyWith({
    String? id,
    String? userId,
    String? username,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Comment(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'username': username,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Comment &&
        other.id == id &&
        other.userId == userId &&
        other.username == username &&
        other.content == content &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        username.hashCode ^
        content.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }

  @override
  String toString() {
    return '''
    Comment(
    id: $id, 
    userId: $userId, 
    username: $username, 
    content: $content, 
    createdAt: $createdAt, 
    updatedAt: $updatedAt
    )
    ''';
  }
}

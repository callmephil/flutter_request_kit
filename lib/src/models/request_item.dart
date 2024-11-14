import 'package:flutter/foundation.dart';
import 'package:flutter_request_kit/flutter_request_kit.dart';

@immutable
class RequestItem {
  const RequestItem({
    required this.id,
    required this.creator,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.comments = const [],
    this.votes = const [],
    this.status = RequestStatus.none,
  });

  factory RequestItem.fromJson(Map<String, dynamic> json) {
    return RequestItem(
      id: json['id'] as String,
      creator: Creator.fromJson(json['creator'] as Map<String, dynamic>),
      title: json['title'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      comments: (json['comments'] as List<Object?>).map<Comment>((comment) {
        return Comment.fromJson(comment! as Map<String, dynamic>);
      }).toList(growable: false),
      votes: (json['votes'] as List<Object?>).map<Vote>((vote) {
        return Vote.fromJson(vote! as Map<String, dynamic>);
      }).toList(growable: false),
      status: RequestStatus.values.firstWhere(
        (e) => e.toString().split('.').lastOrNull == json['status'],
      ),
    );
  }

  final String id;
  final Creator creator;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Comment> comments;
  final List<Vote> votes;
  final RequestStatus status;

  RequestItem copyWith({
    String? id,
    Creator? creator,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Comment>? comments,
    List<Vote>? votes,
    RequestStatus? status,
  }) {
    return RequestItem(
      id: id ?? this.id,
      creator: creator ?? this.creator,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      comments: comments ?? this.comments,
      votes: votes ?? this.votes,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creator': creator.toJson(),
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'comments': comments.map((comment) => comment.toJson()).toList(),
      'votes': votes.map((e) => e.toJson()).toList(),
      'status': status.name,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RequestItem &&
        other.id == id &&
        other.creator == creator &&
        other.title == title &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        listEquals(other.comments, comments) &&
        listEquals(other.votes, votes) &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        creator.hashCode ^
        title.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        comments.hashCode ^
        votes.hashCode ^
        status.hashCode;
  }

  @override
  String toString() {
    return '''
    RequestItem(
      id: $id, 
      creator: $creator, 
      title: $title, 
      description: $description,
      createdAt: $createdAt,
      updatedAt: $updatedAt, 
      comments: $comments, 
      votes: $votes, 
      status: $status
    )
    ''';
  }
}

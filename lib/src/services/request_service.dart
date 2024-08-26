import 'package:flutter_request_kit/flutter_request_kit.dart';
import 'package:flutter_request_kit/src/extension/string_extension.dart';

typedef RequestCallback = void Function(RequestItem request);
typedef CommentCallback = void Function(Comment comment);
typedef RequestListCallback = void Function(List<RequestItem> requestList);

class RequestService {
  RequestService({
    this.requestList = const [],
    required this.onAddRequest,
    required this.onUpdateRequest,
    required this.onDeleteRequest,
    required this.onAddComment,
    required this.onVoteChange,
  });

  List<RequestItem> requestList;
  final RequestCallback onAddRequest;
  final RequestCallback onUpdateRequest;
  final RequestCallback onDeleteRequest;
  final CommentCallback onAddComment;
  final RequestCallback onVoteChange;

  void listRequests(RequestListCallback callback) {
    // callback(List<RequestItem>.from(requestList));
  }

  void getRequest(String id, callback) {
    final request = requestList.firstWhere((item) => item.id == id,
        orElse: () => throw Exception('Request not found'.tr));
    callback(request);
  }

  void addRequest(RequestItem request) {
    if (requestList.any((item) => item.id == request.id)) {
      throw Exception('Request with the same ID already exists'.tr);
    }
    requestList.add(request);
    onAddRequest(request);
  }

  void updateRequest(String id, RequestItem updatedRequest) {
    final index = requestList.indexWhere((item) => item.id == id);
    if (index != -1) {
      final newItem = updatedRequest.copyWith(updatedAt: DateTime.now());
      requestList[index] = newItem;
      onUpdateRequest(newItem);
    } else {
      throw Exception('Request not found'.tr);
    }
  }

  void deleteRequest(String id) {
    final request = requestList.firstWhere((item) => item.id == id,
        orElse: () => throw Exception('Request not found'.tr));
    requestList.removeWhere((item) => item.id == id);
    onDeleteRequest(request);
  }

  void addComment(String id, Comment comment) {
    final index = requestList.indexWhere((item) => item.id == id);
    if (index != -1) {
      final request = requestList[index];
      final updatedComments = List<Comment>.from(request.comments)
        ..add(comment);
      final updatedRequest = request.copyWith(
          comments: updatedComments, updatedAt: DateTime.now());
      requestList[index] = updatedRequest;
      onAddComment(comment);
    } else {
      throw Exception('Request not found'.tr);
    }
  }

  void upVoteRequest(String id, Upvote upvote) {
    final index = requestList.indexWhere((item) => item.id == id);
    if (index != -1) {
      final request = requestList[index];
      if (request.upvotes.any((u) => u.userId == upvote.userId)) {
        // downvote here
        final updatedUpvotes = List<Upvote>.from(request.upvotes)
          ..removeWhere((u) => u.userId == upvote.userId);
        final updatedRequest = request.copyWith(
          upvotes: updatedUpvotes,
          updatedAt: DateTime.now(),
        );
        requestList[index] = updatedRequest;
        onVoteChange(updatedRequest);

        return;
      }
      final updatedUpvotes = List<Upvote>.from(request.upvotes)..add(upvote);
      final updatedRequest = request.copyWith(
        upvotes: updatedUpvotes,
        updatedAt: DateTime.now(),
      );
      requestList[index] = updatedRequest;
      onVoteChange(updatedRequest);
    } else {
      throw Exception('Request not found'.tr);
    }
  }

  void downVoteRequest(String id, String userId) {
    final index = requestList.indexWhere((item) => item.id == id);
    if (index != -1) {
      final request = requestList[index];
      final updatedUpvotes = List<Upvote>.from(request.upvotes)
        ..removeWhere((u) => u.userId == userId);
      final updatedRequest = request.copyWith(
        upvotes: updatedUpvotes,
        updatedAt: DateTime.now(),
      );
      requestList[index] = updatedRequest;
      onVoteChange(updatedRequest);
    }
  }
}

import 'dart:async';

import 'package:flutter_request_kit/packages/vx_store/lib/vxstate.dart';
import 'package:flutter_request_kit/src/extension/list_extensions.dart';
import 'package:flutter_request_kit/src/models/models.dart';

export 'package:flutter_request_kit/packages/vx_store/lib/vxstate.dart';

typedef RequestCallback = FutureOr<void> Function(RequestItem request);
typedef AddRequestCallback = FutureOr<RequestItem> Function(
  RequestItem request,
);
typedef CommentCallback = FutureOr<void> Function(
  String requestId,
  Comment comment,
);

class RequestStore extends VxStore {
  RequestStore({
    this.requests = const [],
    this.onAddRequest,
    this.onUpdateRequest,
    this.onDeleteRequest,
    this.onAddComment,
    this.onVoteChange,
  });
  List<RequestItem> requests = [];

  final AddRequestCallback? onAddRequest;
  final RequestCallback? onUpdateRequest;
  final RequestCallback? onDeleteRequest;
  final CommentCallback? onAddComment;
  final RequestCallback? onVoteChange;
}

class AddRequest extends VxMutation<RequestStore> {
  AddRequest(this.request);

  final RequestItem request;

  @override
  Future<void> perform() async {
    try {
      final data = await store?.onAddRequest?.call(request);
      if (data == null) {
        throw Exception('Request not added');
      }
      store?.requests = [data, ...?store?.requests];
    } catch (e) {
      rethrow;
    }
  }
}

class UpdateRequest extends VxMutation<RequestStore> {
  UpdateRequest(this.id, this.updatedRequest);

  final String id;
  final RequestItem updatedRequest;

  @override
  void perform() {
    final index = store?.requests.indexWhere((item) => item.id == id);
    if (index == null || index == -1) return;

    final existingRequest = store!.requests.elementAtOrNull(index);
    if (existingRequest == null) return;

    // Merge existing comments and votes with the updated request
    final mergedRequest = updatedRequest.copyWith(
      comments: updatedRequest.comments.isEmpty
          ? existingRequest.comments
          : updatedRequest.comments,
      votes: updatedRequest.votes.isEmpty
          ? existingRequest.votes
          : updatedRequest.votes,
    );

    // Update the store's requests list with the merged request
    store!.requests[index] = mergedRequest;
    store?.onUpdateRequest?.call(mergedRequest);
  }
}

class DeleteRequest extends VxMutation<RequestStore> {
  DeleteRequest(this.id);
  final String id;

  @override
  void perform() {
    final request = store?.requests.firstWhereOrNull((item) => item.id == id);
    if (request == null) return;

    store?.requests.remove(request);
    store?.onDeleteRequest?.call(request);
  }
}

class AddComment extends VxMutation<RequestStore> {
  AddComment(this.id, this.comment);
  final String id;
  final Comment comment;

  @override
  void perform() {
    final index = store?.requests.indexWhere((item) => item.id == id);
    if (index == null || index == -1) return;

    final request = store!.requests.elementAtOrNull(index);
    if (request == null) return;

    final updatedRequest = request.copyWith(
      comments: [...request.comments, comment],
    );

    store!.requests[index] = updatedRequest;
    store?.onAddComment?.call(id, comment);
  }
}

class UpdateVote extends VxMutation<RequestStore> {
  UpdateVote(this.id, this.vote);
  final String id;
  final Vote vote;

  @override
  void perform() {
    final index = store?.requests.indexWhere((item) => item.id == id);
    if (index == null || index == -1) return;

    final request = store!.requests.elementAtOrNull(index);
    if (request == null) return;

    // Create a new list from the existing votes to ensure it's modifiable
    final updatedVotes = List<Vote>.of(request.votes);

    if (updatedVotes.any((u) => u.userId == vote.userId)) {
      updatedVotes.removeWhere((u) => u.userId == vote.userId);
    } else {
      updatedVotes.add(vote);
    }

    final updatedRequest = request.copyWith(votes: updatedVotes);

    // Update the store's requests list
    store?.requests[index] = updatedRequest;
    store?.onVoteChange?.call(updatedRequest);
  }
}

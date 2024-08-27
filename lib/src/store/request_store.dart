import 'package:flutter_request_kit/packages/vx_store/lib/vxstate.dart';
import 'package:flutter_request_kit/src/models/models.dart';

export 'package:flutter_request_kit/packages/vx_store/lib/vxstate.dart';

typedef RequestCallback = void Function(RequestItem request);
typedef CommentCallback = void Function(Comment comment);

class RequestStore extends VxStore {
  List<RequestItem> requests = [];

  final RequestCallback? onAddRequest;
  final RequestCallback? onUpdateRequest;
  final RequestCallback? onDeleteRequest;
  final CommentCallback? onAddComment;
  final RequestCallback? onVoteChange;

  RequestStore({
    this.requests = const [],
    this.onAddRequest,
    this.onUpdateRequest,
    this.onDeleteRequest,
    this.onAddComment,
    this.onVoteChange,
  });
}

class AddRequest extends VxMutation<RequestStore> {
  final RequestItem request;

  AddRequest(this.request);

  @override
  perform() {
    store?.requests.add(request);
    store?.onAddRequest?.call(request);
  }
}

class UpdateRequest extends VxMutation<RequestStore> {
  final String id;
  final RequestItem updatedRequest;

  UpdateRequest(this.id, this.updatedRequest);

  @override
  perform() {
    final index = store?.requests.indexWhere((item) => item.id == id);
    if (index == null || index == -1) return;

    final existingRequest = store!.requests[index];

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
  final String id;

  DeleteRequest(this.id);

  @override
  perform() {
    final request = store?.requests.firstWhere((item) => item.id == id);
    if (request == null) return;

    store?.requests.remove(request);
    store?.onDeleteRequest?.call(request);
  }
}

class AddComment extends VxMutation<RequestStore> {
  final String id;
  final Comment comment;

  AddComment(this.id, this.comment);

  @override
  perform() {
    final int? index = store?.requests.indexWhere((item) => item.id == id);
    if (index == null || index == -1) return;

    final request = store!.requests[index];
    final updatedRequest = request.copyWith(
      comments: [...request.comments, comment],
    );

    store!.requests[index] = updatedRequest;
    store?.onAddComment?.call(comment);
  }
}

class UpdateVote extends VxMutation<RequestStore> {
  final String id;
  final Vote vote;

  UpdateVote(this.id, this.vote);

  @override
  perform() {
    final int? index = store?.requests.indexWhere((item) => item.id == id);
    if (index == null || index == -1) return;

    final request = store!.requests[index];
    // Create a new list from the existing votes to ensure it's modifiable
    final List<Vote> updatedVotes = List<Vote>.from(request.votes);

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

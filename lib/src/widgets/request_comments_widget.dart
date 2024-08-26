import 'package:flutter/material.dart';
import 'package:flutter_request_kit/src/extension/provider_extensions.dart';
import 'package:flutter_request_kit/src/extension/request_date_time_extension.dart';
import 'package:flutter_request_kit/src/theme/request_sizes.dart';

import '../models/models.dart';

class RequestComments extends StatefulWidget {
  final RequestItem request;
  final Function(Comment)? onAddComment;
  final Function() onUpvote;
  final Function() onRemoveUpvote;
  final Creator currentUser;

  const RequestComments({
    super.key,
    required this.request,
    required this.currentUser,
    this.onAddComment,
    required this.onUpvote,
    required this.onRemoveUpvote,
  });

  @override
  State<RequestComments> createState() => _RequestCommentsState();
}

class _RequestCommentsState extends State<RequestComments> {
  final TextEditingController commentController = TextEditingController();
  late List<Comment> _comments;

  @override
  void initState() {
    super.initState();
    _comments = List.from(widget.request.comments);
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (commentController.text.isEmpty) return;

    final comment = Comment(
      id: DateTime.now().toString(),
      userId: widget.currentUser.userId,
      username: widget.currentUser.username,
      content: commentController.text,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    setState(() {
      _comments.add(comment);
      commentController.clear();
    });

    widget.onAddComment?.call(comment);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: RequestSizes.borderRadius32,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: RequestSizes.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: RequestSizes.borderRadius16,
          ),
          title: Text(
            context.locale.comments,
            style: context.theme.textTheme.titleMedium,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: _comments.isEmpty
                    ? Center(
                        child: Text(
                          context.locale.no_comments,
                          style: context.theme.textTheme.labelLarge,
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(RequestSizes.s8),
                        itemCount: _comments.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: RequestSizes.s8,
                          );
                        },
                        itemBuilder: (context, index) {
                          final comment = _comments[index];
                          return ListTile(
                            title: Text.rich(
                              TextSpan(
                                text: comment.username,
                                style: context.theme.textTheme.titleSmall,
                                children: [
                                  const WidgetSpan(
                                    child: SizedBox(width: RequestSizes.s8),
                                  ),
                                  TextSpan(
                                    text: comment.createdAt.toRequestDateTime,
                                    style: context.theme.textTheme.labelSmall
                                        ?.copyWith(
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            subtitle: Text(comment.content),
                          );
                        },
                      ),
              ),
              TextField(
                controller: commentController,
                decoration: InputDecoration(
                  hintText: context.locale.add_comment,
                  suffixIcon: IconButton(
                    onPressed: _onSubmit,
                    icon: const Icon(Icons.send),
                  ),
                  contentPadding: const EdgeInsets.all(RequestSizes.s12),
                ),
                onSubmitted: (_) {
                  _onSubmit();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

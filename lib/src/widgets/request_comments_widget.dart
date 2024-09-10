import 'package:flutter/material.dart';
import 'package:flutter_request_kit/flutter_request_kit.dart';
import 'package:flutter_request_kit/src/extension/provider_extensions.dart';
import 'package:flutter_request_kit/src/extension/request_date_time_extension.dart';
import 'package:flutter_request_kit/src/i18n/i18n.dart';
import 'package:flutter_request_kit/src/i18n/localization_provider.dart';
import 'package:flutter_request_kit/src/theme/request_sizes.dart';

void showRequestCommentsBottomSheet({
  required BuildContext context,
  required RequestItem request,
  required Creator currentUser,
  required I18n locale,
}) {
  showModalBottomSheet<Widget>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    constraints: BoxConstraints(
      minHeight: MediaQuery.sizeOf(context).height * .8,
      maxHeight: MediaQuery.sizeOf(context).height * .8,
    ),
    builder: (_) {
      return LocalizationProvider(
        locale: locale,
        child: Builder(
          builder: (_) {
            return RequestCommentsWidget(
              request: request,
              currentUser: currentUser,
              onAddComment: (comment) {
                AddComment(request.id, comment);
              },
            );
          },
        ),
      );
    },
  );
}

class RequestCommentsWidget extends StatefulWidget {
  const RequestCommentsWidget({
    super.key,
    required this.request,
    required this.currentUser,
    this.onAddComment,
  });
  final RequestItem request;
  final void Function(Comment)? onAddComment;
  final Creator currentUser;

  @override
  State<RequestCommentsWidget> createState() => _RequestCommentsWidgetState();
}

class _RequestCommentsWidgetState extends State<RequestCommentsWidget> {
  final TextEditingController commentController = TextEditingController();
  late List<Comment> _comments;

  @override
  void initState() {
    super.initState();
    _comments = List.of(widget.request.comments);
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
                        separatorBuilder: (_, index) {
                          return const SizedBox(height: RequestSizes.s8);
                        },
                        itemBuilder: (_, index) {
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
              Padding(
                padding: const EdgeInsets.all(RequestSizes.s12),
                child: TextField(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

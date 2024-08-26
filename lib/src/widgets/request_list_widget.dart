import 'package:flutter/material.dart';
import 'package:flutter_request_kit/src/extension/provider_extensions.dart';
import 'package:flutter_request_kit/src/flutter_request_kit.dart';
import 'package:flutter_request_kit/src/models/models.dart';
import 'package:flutter_request_kit/src/theme/request_sizes.dart';
import 'package:flutter_request_kit/src/widgets/components/request_item_card.dart';

class RequestListWidget extends StatelessWidget {
  final List<RequestItem> requestList;
  final String currentUserId;
  final void Function(RequestItem) onRequestSelected;
  final void Function(RequestItem) onUpvote;
  final void Function(RequestItem) onRemoveUpvote;
  final void Function(RequestItem)? onLongPress;
  final Future<void> Function() onRefresh;

  const RequestListWidget({
    super.key,
    required this.requestList,
    required this.onRequestSelected,
    required this.onUpvote,
    required this.onRemoveUpvote,
    required this.currentUserId,
    this.onLongPress,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (requestList.isEmpty) {
      return Center(
        child: Text(
          context.locale.no_requests,
          style: context.theme.textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      );
    }

    return RefreshIndicator.adaptive(
      onRefresh: onRefresh,
      child: ListView.separated(
        padding: const EdgeInsets.all(RequestSizes.s8),
        itemCount: requestList.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: RequestSizes.s16);
        },
        itemBuilder: (context, index) {
          final request = requestList[index];
          final userUpvoted = request.upvotes.any(
            (u) => u.userId == currentUserId,
          );

          return RequestItemCard(
            item: request,
            onTap: () {
              onRequestSelected(request);
            },
            onLongPress: onLongPress == null
                ? null
                : () {
                    onLongPress?.call(request);
                  },
            onVote: () {
              userUpvoted ? onRemoveUpvote(request) : onUpvote(request);
            },
          );
        },
      ),
    );
  }
}

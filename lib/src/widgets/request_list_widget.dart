import 'package:flutter/material.dart';
import 'package:flutter_request_kit/src/extension/provider_extensions.dart';
import 'package:flutter_request_kit/src/flutter_request_kit.dart';
import 'package:flutter_request_kit/src/models/models.dart';
import 'package:flutter_request_kit/src/theme/request_sizes.dart';
import 'package:flutter_request_kit/src/widgets/components/request_item_card/request_item_card.dart';

class RequestListWidget extends StatelessWidget {
  const RequestListWidget({
    super.key,
    required this.requestList,
    required this.currentUser,
    required this.onRefresh,
    required this.onRequestSelected,
    required this.onVoteChange,
    this.onLongPress,
  });
  final List<RequestItem> requestList;
  final Creator currentUser;
  final Future<void> Function() onRefresh;
  final void Function(RequestItem) onRequestSelected;
  final void Function(RequestItem) onVoteChange;
  final void Function(RequestItem)? onLongPress;

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
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: requestList.length,
        separatorBuilder: (_, index) {
          return const SizedBox(height: RequestSizes.s16);
        },
        itemBuilder: (_, index) {
          final request = requestList[index];
          return RequestItemCard(
            item: request,
            onTap: () => onRequestSelected(request),
            onLongPress: request.creator.userId  == currentUser.userId
                || currentUser.isAdmin ? onLongPress == null
                ? null
                : () {
                    onLongPress?.call(request);
                  } : null,
            onVote: () => onVoteChange(request),
          );
        },
      ),
    );
  }
}

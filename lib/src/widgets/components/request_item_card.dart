import 'package:flutter/material.dart';
import 'package:flutter_request_kit/src/enums/enums.dart';
import 'package:flutter_request_kit/src/extension/provider_extensions.dart';
import 'package:flutter_request_kit/src/extension/request_date_time_extension.dart';
import 'package:flutter_request_kit/src/models/request_item.dart';
import 'package:flutter_request_kit/src/theme/custom_theme.dart';
import 'package:flutter_request_kit/src/theme/request_colors.dart';
import 'package:flutter_request_kit/src/theme/request_sizes.dart';
import 'package:flutter_request_kit/src/widgets/components/request_status_pill.dart';
import 'package:flutter_request_kit/src/widgets/components/request_voting_box.dart';

class RequestItemCard extends StatelessWidget {
  const RequestItemCard({
    super.key,
    required this.item,
    this.onVote,
    this.onTap,
    this.onLongPress,
  });

  final RequestItem item;
  final void Function()? onVote;
  final void Function()? onTap;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.extension<RequestItemCardTheme>();

    return Material(
      color: theme?.backgroundColor ?? Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: theme?.borderRadius ?? RequestSizes.borderRadius4,
        side: BorderSide(
          color: theme?.borderColor ?? RequestColors.grey,
          width: theme?.borderWidth ?? RequestSizes.s05,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: theme?.padding ?? const EdgeInsets.all(RequestSizes.s12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RequestItemTitle(item: item),
                    RequestItemDescription(item: item),
                    const SizedBox(height: RequestSizes.s8),
                    RequestItemComments(item: item),
                  ],
                ),
              ),
              const SizedBox(width: RequestSizes.s16),
              RequestVotingBox(onVote: onVote, item: item),
            ],
          ),
        ),
      ),
    );
  }
}

class RequestItemTitle extends StatelessWidget {
  const RequestItemTitle({
    super.key,
    required this.item,
  });

  final RequestItem item;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.extension<RequestItemCardTheme>();

    return Row(
      children: [
        Text(
          item.title,
          style: theme?.titleTextStyle ?? context.theme.textTheme.titleLarge,
        ),
        const SizedBox(width: RequestSizes.s4),
        Text(
          item.createdAt.toRequestDateTime,
          style: theme?.titleTextStyle ??
              context.theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w200,
              ),
        ),
      ],
    );
  }
}

class RequestItemDescription extends StatelessWidget {
  const RequestItemDescription({
    super.key,
    required this.item,
  });

  final RequestItem item;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.extension<RequestItemCardTheme>();

    return Text(
      item.description,
      maxLines: 3,
      style: theme?.descriptionTextStyle ??
          const TextStyle(color: RequestColors.grey600),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class RequestItemComments extends StatelessWidget {
  const RequestItemComments({
    super.key,
    required this.item,
  });

  final RequestItem item;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.extension<RequestItemCardTheme>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.chat_bubble_outline_outlined,
          size: theme?.iconSize ?? RequestSizes.s16,
          color: theme?.iconColor ?? RequestColors.grey600,
        ),
        const SizedBox(width: RequestSizes.s4),
        Text(
          item.comments.length.toString(),
          style: theme?.commentsTextStyle ??
              const TextStyle(
                color: RequestColors.grey600,
              ),
        ),
        if (item.status != RequestStatus.none)
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(RequestSizes.s8),
                child: Text(theme?.separatorText ?? '-'),
              ),
              RequestStatusPill(status: item.status),
            ],
          )
      ],
    );
  }
}

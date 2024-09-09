import 'package:flutter/material.dart';
import 'package:flutter_request_kit/src/extension/provider_extensions.dart';
import 'package:flutter_request_kit/src/models/request_item.dart';
import 'package:flutter_request_kit/src/theme/request_colors.dart';
import 'package:flutter_request_kit/src/theme/request_custom_theme.dart';
import 'package:flutter_request_kit/src/theme/request_sizes.dart';
import 'package:flutter_request_kit/src/widgets/components/request_item_card/request_item_card_comment_count.dart';
import 'package:flutter_request_kit/src/widgets/components/request_item_card/request_item_card_description.dart';
import 'package:flutter_request_kit/src/widgets/components/request_item_card/request_item_card_owner.dart';
import 'package:flutter_request_kit/src/widgets/components/request_item_card/request_item_card_title.dart';
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
                    RequestItemCardTitle(item: item),
                    RequestItemCardDescription(item: item),
                    const SizedBox(height: RequestSizes.s8),
                    Row(
                      children: [
                        RequestItemCardOwner(userName: item.creator.username),
                        const SizedBox(width: RequestSizes.s8),
                        RequestItemCardCommentCount(item: item),
                      ],
                    )
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

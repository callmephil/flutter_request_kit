import 'package:flutter/material.dart';
import 'package:flutter_request_kit/src/enums/request_status.dart';
import 'package:flutter_request_kit/src/extension/provider_extensions.dart';
import 'package:flutter_request_kit/src/models/models.dart';
import 'package:flutter_request_kit/src/theme/request_colors.dart';
import 'package:flutter_request_kit/src/theme/request_custom_theme.dart';
import 'package:flutter_request_kit/src/theme/request_sizes.dart';
import 'package:flutter_request_kit/src/widgets/components/request_status_pill.dart';

class RequestItemCardCommentCount extends StatelessWidget {
  const RequestItemCardCommentCount({super.key, required this.item});

  final RequestItem item;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.extension<RequestItemCardTheme>();

    return Row(
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
              const TextStyle(color: RequestColors.grey600),
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
          ),
      ],
    );
  }
}

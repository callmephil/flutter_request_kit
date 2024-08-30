// request_voting_box.dart

import 'package:flutter/material.dart';
import 'package:flutter_request_kit/flutter_request_kit.dart';
import 'package:flutter_request_kit/src/extension/provider_extensions.dart';
import 'package:flutter_request_kit/src/theme/request_colors.dart';
import 'package:flutter_request_kit/src/theme/request_sizes.dart';

class RequestVotingBox extends StatelessWidget {
  const RequestVotingBox({
    super.key,
    required this.onVote,
    required this.item,
  });

  final void Function()? onVote;
  final RequestItem item;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.extension<RequestVotingBoxTheme>();

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
        onTap: onVote,
        child: Padding(
          padding: theme?.padding ??
              const EdgeInsets.symmetric(
                vertical: RequestSizes.s4,
                horizontal: RequestSizes.s8,
              ).copyWith(bottom: RequestSizes.s8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.keyboard_arrow_up_rounded,
                color: theme?.iconColor ?? RequestColors.grey,
                size: theme?.iconSize ?? RequestSizes.s16,
              ),
              Text(
                item.votes.length.toString(),
                style: theme?.textStyle ??
                    const TextStyle(color: RequestColors.grey, height: 0.8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

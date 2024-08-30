import 'package:flutter/material.dart';
import 'package:flutter_request_kit/src/extension/provider_extensions.dart';
import 'package:flutter_request_kit/src/extension/request_date_time_extension.dart';
import 'package:flutter_request_kit/src/models/request_item.dart';
import 'package:flutter_request_kit/src/theme/request_custom_theme.dart';
import 'package:flutter_request_kit/src/theme/request_sizes.dart';

class RequestItemCardTitle extends StatelessWidget {
  const RequestItemCardTitle({super.key, required this.item});

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

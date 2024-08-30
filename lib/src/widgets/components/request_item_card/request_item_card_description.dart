import 'package:flutter/material.dart';
import 'package:flutter_request_kit/src/extension/provider_extensions.dart';
import 'package:flutter_request_kit/src/models/request_item.dart';
import 'package:flutter_request_kit/src/theme/request_colors.dart';
import 'package:flutter_request_kit/src/theme/request_custom_theme.dart';

class RequestItemCardDescription extends StatelessWidget {
  const RequestItemCardDescription({super.key, required this.item});

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

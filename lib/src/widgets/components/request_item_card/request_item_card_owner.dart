import 'package:flutter/material.dart';
import 'package:flutter_request_kit/flutter_request_kit.dart';
import 'package:flutter_request_kit/src/extension/provider_extensions.dart';

class RequestItemCardOwner extends StatelessWidget {
  const RequestItemCardOwner({super.key, required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.extension<RequestItemCardTheme>();
// TODO: add translations
    return Text(
      'by $userName',
      style: theme?.ownerTextStyle ?? context.theme.textTheme.labelSmall,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_request_kit/src/enums/enums.dart';
import 'package:flutter_request_kit/src/extension/provider_extensions.dart';
import 'package:flutter_request_kit/src/theme/request_custom_theme.dart';
import 'package:flutter_request_kit/src/theme/request_sizes.dart';

class RequestStatusPill extends StatelessWidget {
  const RequestStatusPill({super.key, required this.status});

  final RequestStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.extension<RequestStatusPillTheme>();

    Color getStatusColor() {
      switch (status) {
        case RequestStatus.inProgress:
          return theme?.inProgressColor ?? status.color;
        case RequestStatus.completed:
          return theme?.completedColor ?? status.color;
        case RequestStatus.planned:
          return theme?.plannedColor ?? status.color;
        // ignore: no_default_cases
        default:
          return status.color;
      }
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: getStatusColor(),
        borderRadius: theme?.borderRadius ?? RequestSizes.borderRadius4,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: RequestSizes.s4,
          horizontal: RequestSizes.s8,
        ),
        child: Text(
          status.toName(context.locale),
          style: context.theme.textTheme.labelMedium?.copyWith(
            color: status.color.computeLuminance() < 0.5
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
    );
  }
}

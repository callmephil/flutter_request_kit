import 'dart:ui';

import 'package:flutter_request_kit/src/i18n/i18n.dart';
import 'package:flutter_request_kit/src/theme/request_colors.dart';

enum RequestStatus {
  none(RequestColors.grey),
  planned(RequestColors.blue300),
  inProgress(RequestColors.red300),
  completed(RequestColors.green300);

  const RequestStatus(this.color);

  final Color color;

  String toName(I18n i18n) {
    return switch (this) {
      RequestStatus.none => i18n.none,
      RequestStatus.planned => i18n.planned,
      RequestStatus.inProgress => i18n.in_progress,
      RequestStatus.completed => i18n.completed,
    };
  }
}

import 'package:flutter_request_kit/src/extension/string_extension.dart';

extension RequestDateTimeExtension on DateTime {
  String get toRequestDateTime {
    final now = DateTime.now();
    final diff = now.difference(this);

    if (diff.inDays > 0) {
      return '${diff.inDays}d'.tr;
    } else if (diff.inHours > 0) {
      return '${diff.inHours}h'.tr;
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes}m'.tr;
    } else {
      return '${diff.inSeconds}s'.tr;
    }
  }
}

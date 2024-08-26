import 'package:flutter/material.dart';
import 'package:flutter_request_kit/src/i18n/i18n.dart';

class LocalizationProvider extends InheritedWidget {
  const LocalizationProvider({
    super.key,
    required this.locale,
    required super.child,
  });
  final I18n locale;

  static LocalizationProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LocalizationProvider>();
  }

  @override
  bool updateShouldNotify(LocalizationProvider oldWidget) {
    return oldWidget.locale != locale;
  }
}

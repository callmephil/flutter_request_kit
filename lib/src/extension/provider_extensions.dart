import 'package:flutter/material.dart';
import 'package:flutter_request_kit/src/i18n/i18n.dart';
import 'package:flutter_request_kit/src/i18n/i18n_enum.dart';
import 'package:flutter_request_kit/src/i18n/localization_provider.dart';

extension ProviderExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  I18n get locale {
    final locale = LocalizationProvider.of(this);
    if (locale == null) {
      return RequestKitLocales.enUS.locale;
    }

    return locale.locale;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_request_kit/src/i18n/i18n.dart';
import 'package:flutter_request_kit/src/i18n/localization_provider.dart';
import 'package:flutter_request_kit/src/i18n/request_kit_locales.dart';

extension ProviderExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  I18n get locale {
    final provider = LocalizationProvider.of(this);
    if (provider == null) {
      return RequestKitLocales.enUS.locale;
    }

    return provider.locale;
  }
}

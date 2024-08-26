import 'package:flutter/material.dart';
import 'package:flutter_request_kit/src/i18n/i18n.dart';
import 'package:flutter_request_kit/src/i18n/i18n_enum.dart';
import 'package:flutter_request_kit/src/i18n/localization_provider.dart';
import 'package:flutter_request_kit/src/theme/custom_theme_provider.dart';

extension ProviderExtensions on BuildContext {
  ThemeData get theme {
    final customTheme = CustomThemeProvider.of(this);
    if (customTheme == null) {
      return Theme.of(this);
    }

    return customTheme.themeData;
  }

  I18n get locale {
    final locale = LocalizationProvider.of(this);
    if (locale == null) {
      return RequestKitLocales.enUS.locale;
    }

    return locale.locale;
  }
}

import 'package:flutter_request_kit/src/i18n/i18n.dart';

enum RequestKitLocales {
  enUS(EnUS()),
  frFR(FrFR());

  const RequestKitLocales(this.locale);
  final I18n locale;

  static I18n fromName(String name) => RequestKitLocales.values
      .firstWhere((e) => e.name == name, orElse: () => enUS)
      .locale;
}

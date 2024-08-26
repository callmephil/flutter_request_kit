import 'package:flutter/material.dart';

class CustomThemeProvider extends InheritedWidget {
  const CustomThemeProvider({
    super.key,
    required this.themeData,
    required super.child,
  });
  final ThemeData themeData;

  static CustomThemeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CustomThemeProvider>();
  }

  @override
  bool updateShouldNotify(CustomThemeProvider oldWidget) {
    return oldWidget.themeData != themeData;
  }
}

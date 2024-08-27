import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_request_kit/src/theme/request_colors.dart';
import 'package:flutter_request_kit/src/theme/request_sizes.dart';

class RequestCustomTheme {
  const RequestCustomTheme._();

  static final defaultTheme = ThemeData(
    primarySwatch: Colors.blue,
    extensions: const [
      RequestStatusPillTheme(),
      RequestVotingBoxTheme(),
      RequestItemCardTheme(),
    ],
  );
}

class RequestItemCardTheme extends ThemeExtension<RequestItemCardTheme> {
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final TextStyle? titleTextStyle;
  final TextStyle? descriptionTextStyle;
  final TextStyle? commentsTextStyle;
  final Color? iconColor;
  final double? iconSize;
  final String? separatorText;

  const RequestItemCardTheme({
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.titleTextStyle,
    this.descriptionTextStyle,
    this.commentsTextStyle,
    this.iconColor,
    this.iconSize,
    this.separatorText,
  });

  @override
  RequestItemCardTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    TextStyle? titleTextStyle,
    TextStyle? descriptionTextStyle,
    TextStyle? commentsTextStyle,
    Color? iconColor,
    double? iconSize,
    String? separatorText,
  }) {
    return RequestItemCardTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
      commentsTextStyle: commentsTextStyle ?? this.commentsTextStyle,
      iconColor: iconColor ?? this.iconColor,
      iconSize: iconSize ?? this.iconSize,
      separatorText: separatorText ?? this.separatorText,
    );
  }

  @override
  RequestItemCardTheme lerp(
      ThemeExtension<RequestItemCardTheme>? other, double t) {
    if (other is! RequestItemCardTheme) {
      return this;
    }
    return RequestItemCardTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t),
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t),
      padding: EdgeInsets.lerp(padding, other.padding, t),
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t),
      descriptionTextStyle:
          TextStyle.lerp(descriptionTextStyle, other.descriptionTextStyle, t),
      commentsTextStyle:
          TextStyle.lerp(commentsTextStyle, other.commentsTextStyle, t),
      iconColor: Color.lerp(iconColor, other.iconColor, t),
      iconSize: lerpDouble(iconSize, other.iconSize, t),
      separatorText: separatorText,
    );
  }
}

class RequestStatusPillTheme extends ThemeExtension<RequestStatusPillTheme> {
  final TextStyle? textStyle;
  final Color? inProgressColor;
  final Color? completedColor;
  final Color? plannedColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;

  const RequestStatusPillTheme({
    this.textStyle,
    this.inProgressColor = RequestColors.red300,
    this.completedColor = RequestColors.green300,
    this.plannedColor = RequestColors.blue300,
    this.borderRadius = RequestSizes.borderRadius4,
    this.padding = const EdgeInsets.symmetric(
      vertical: RequestSizes.s4,
      horizontal: RequestSizes.s8,
    ),
  });

  @override
  RequestStatusPillTheme copyWith({
    TextStyle? textStyle,
    Color? inProgressColor,
    Color? completedColor,
    Color? plannedColor,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
  }) {
    return RequestStatusPillTheme(
      textStyle: textStyle ?? this.textStyle,
      inProgressColor: inProgressColor ?? this.inProgressColor,
      completedColor: completedColor ?? this.completedColor,
      plannedColor: plannedColor ?? this.plannedColor,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
    );
  }

  @override
  RequestStatusPillTheme lerp(
      ThemeExtension<RequestStatusPillTheme>? other, double t) {
    if (other is! RequestStatusPillTheme) {
      return this;
    }
    return RequestStatusPillTheme(
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
      inProgressColor: Color.lerp(inProgressColor, other.inProgressColor, t),
      completedColor: Color.lerp(completedColor, other.completedColor, t),
      plannedColor: Color.lerp(plannedColor, other.plannedColor, t),
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t),
      padding: EdgeInsets.lerp(padding, other.padding, t),
    );
  }
}

class RequestVotingBoxTheme extends ThemeExtension<RequestVotingBoxTheme> {
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final Color? iconColor;
  final double? iconSize;

  const RequestVotingBoxTheme({
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.textStyle,
    this.iconColor,
    this.iconSize,
  });

  @override
  RequestVotingBoxTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    TextStyle? textStyle,
    Color? iconColor,
    double? iconSize,
  }) {
    return RequestVotingBoxTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      iconColor: iconColor ?? this.iconColor,
      iconSize: iconSize ?? this.iconSize,
    );
  }

  @override
  RequestVotingBoxTheme lerp(
      ThemeExtension<RequestVotingBoxTheme>? other, double t) {
    if (other is! RequestVotingBoxTheme) {
      return this;
    }
    return RequestVotingBoxTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t),
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t),
      padding: EdgeInsets.lerp(padding, other.padding, t),
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
      iconColor: Color.lerp(iconColor, other.iconColor, t),
      iconSize: lerpDouble(iconSize, other.iconSize, t),
    );
  }
}

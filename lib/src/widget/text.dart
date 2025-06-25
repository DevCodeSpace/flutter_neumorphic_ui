// ignore_for_file: unused_element_parameter

import 'dart:ui' as ui show FontFeature;

import 'package:flutter/material.dart' as material;
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';
import 'package:flutter_neumorphic_ui/src/decoration/neumorphic_text_decorations.dart';

export '../decoration/neumorphic_decorations.dart';
export '../neumorphic_box_shape.dart';
export '../theme/neumorphic_theme.dart';

/// A class to define a custom text style for NeumorphicText
class NeumorphicTextStyle {
  final bool inherit; // Whether the style inherits from parent
  final double? fontSize; // Font size of the text
  final FontWeight? fontWeight; // Font weight of the text
  final FontStyle? fontStyle; // Font style (e.g., normal, italic)
  final double? letterSpacing; // Spacing between letters
  final double? wordSpacing; // Spacing between words
  final TextBaseline? textBaseline; // Baseline for text alignment
  final double? height; // Line height multiplier
  final Locale? locale; // Locale for text rendering
  final List<ui.FontFeature>? fontFeatures; // Custom font features
  final TextDecoration? decoration; // Text decoration (e.g., underline)
  final String? debugLabel; // Debug label for debugging purposes
  final String? fontFamily; // Font family name
  final List<String>? fontFamilyFallback; // Fallback font families
  final String? package; // Package name for font family

  /// Converts NeumorphicTextStyle to Flutter's TextStyle
  TextStyle get textStyle => TextStyle(
    inherit: inherit,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    letterSpacing: letterSpacing,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    height: height,
    locale: locale,
    fontFeatures: fontFeatures,
    decoration: decoration,
    debugLabel: debugLabel,
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    package: package,
    //color: color,
    //backgroundColor: backgroundColor,
    //foreground: foreground,
    //background: background,
    //decoration: decoration,
    //decorationColor: decorationColor,
    //decorationStyle: decorationStyle,
    //decorationThickness: decorationThickness,
  );

  /// Creates a text style.
  ///
  /// The `package` argument must be non-null if the font family is defined in a
  /// package. It is combined with the `fontFamily` argument to set the
  /// [fontFamily] property.
  NeumorphicTextStyle({
    this.inherit = true,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.textBaseline,
    this.height,
    this.locale,
    this.fontFeatures,
    this.decoration,
    this.debugLabel,
    this.fontFamily,
    //this.color,
    //this.backgroundColor,
    //this.foreground,
    //this.background,
    //this.decoration,
    //this.decorationColor,
    //this.decorationStyle,
    //this.decorationThickness,
    this.fontFamilyFallback,
    this.package,
  });

  /// Creates a copy of this style with updated properties
  NeumorphicTextStyle copyWith({
    bool? inherit,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? locale,
    List<ui.FontFeature>? fontFeatures,
    String? debugLabel,
    //Color color,
    //Color backgroundColor,
    //Paint foreground,
    //Paint background,
    //TextDecoration decoration,
    //Color decorationColor,
    //TextDecorationStyle decorationStyle,
    //double decorationThickness,
  }) {
    return NeumorphicTextStyle(
      inherit: inherit ?? this.inherit,
      fontFamily: fontFamily ?? this.fontFamily,
      fontFamilyFallback: fontFamilyFallback ?? this.fontFamilyFallback,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      textBaseline: textBaseline ?? this.textBaseline,
      height: height ?? this.height,
      locale: locale ?? this.locale,
      fontFeatures: fontFeatures ?? this.fontFeatures,
      debugLabel: debugLabel ?? this.debugLabel,
      //color: this.foreground == null && foreground == null ? color ?? this.color : null,
      //backgroundColor: this.background == null && background == null ? backgroundColor ?? this.backgroundColor : null,
      //foreground: foreground ?? this.foreground,
      //background: background ?? this.background,
      //shadows: shadows ?? this.shadows,
      //decoration: decoration ?? this.decoration,
      //decorationColor: decorationColor ?? this.decorationColor,
      //decorationStyle: decorationStyle ?? this.decorationStyle,
      //decorationThickness: decorationThickness ?? this.decorationThickness,
    );
  }
}

/// A widget to display text with a neumorphic effect
@immutable
class NeumorphicText extends StatelessWidget {
  final String text; // The text to display
  final NeumorphicStyle? style; // Neumorphic style for the text
  final TextAlign textAlign; // Text alignment
  final NeumorphicTextStyle? textStyle; // Custom text style
  final Curve curve; // Animation curve for transitions
  final Duration duration; // Animation duration for transitions

  const NeumorphicText(
    this.text, {
    super.key,
    this.duration = Neumorphic.defaultDuration,
    this.curve = Neumorphic.defaultCurve,
    this.style,
    this.textAlign = TextAlign.center,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(
      context,
    ); // Retrieves current theme
    final NeumorphicStyle style = (this.style ?? NeumorphicStyle())
        .copyWithThemeIfNull(theme)
        .applyDisableDepth(); // Applies theme defaults and disables depth if needed

    return _NeumorphicText(
      textStyle: (textStyle ?? NeumorphicTextStyle())
          .textStyle, // Converts to TextStyle
      textAlign: textAlign,
      text: text,
      duration: duration,
      style: style,
      curve: curve,
    );
  }
}

/// Internal stateful widget to handle neumorphic text rendering
class _NeumorphicText extends material.StatefulWidget {
  final String text; // Text to render
  final NeumorphicStyle style; // Neumorphic style for the text
  final TextStyle textStyle; // Flutter TextStyle for the text
  final Duration duration; // Animation duration
  final Curve curve; // Animation curve
  final TextAlign textAlign; // Text alignment

  const _NeumorphicText({
    super.key,
    required this.duration,
    required this.curve,
    required this.textAlign,
    required this.style,
    required this.textStyle,
    required this.text,
  });

  @override
  __NeumorphicTextState createState() => __NeumorphicTextState();
}

/// State class for _NeumorphicText to manage text rendering
class __NeumorphicTextState extends material.State<_NeumorphicText> {
  @override
  Widget build(BuildContext context) {
    // Creates a TextPainter to measure text dimensions
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: widget.textAlign,
    );
    final textStyle = widget.textStyle;
    textPainter.text = TextSpan(text: widget.text, style: widget.textStyle);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Lays out text to determine its size
        textPainter.layout(minWidth: 0, maxWidth: constraints.maxWidth);
        final double width = textPainter.width; // Text width
        final double height = textPainter.height; // Text height

        return DefaultTextStyle(
          style: textStyle, // Applies default text style
          child: AnimatedContainer(
            duration: widget.duration, // Sets animation duration
            curve: widget.curve, // Sets animation curve
            foregroundDecoration: NeumorphicTextDecoration(
              isForeground: true, // Renders decoration in foreground
              textStyle: textStyle, // Applies text style
              textAlign: widget.textAlign, // Applies text alignment
              renderingByPath: true, // Uses path-based rendering
              style: widget.style, // Applies neumorphic style
              text: widget.text, // Text content
            ),
            child: SizedBox(
              width: width,
              height: height,
            ), // Sizes container to text
          ),
        );
      },
    );
  }
}

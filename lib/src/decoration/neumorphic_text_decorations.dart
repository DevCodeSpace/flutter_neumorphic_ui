// ignore_for_file: avoid_print

import 'dart:ui';

import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

import 'neumorphic_text_decoration_painter.dart';

// Immutable decoration class for rendering text with neumorphic effects
@immutable
class NeumorphicTextDecoration extends Decoration {
  // Style configuration for the neumorphic effect
  final NeumorphicStyle style;
  // Text style configuration for rendering text
  final TextStyle textStyle;
  // Text to be rendered
  final String text;
  // Flag to enable path-based rendering
  final bool renderingByPath;
  // Flag to indicate if this is a foreground decoration
  final bool isForeground;
  // Text alignment for the rendered text
  final TextAlign textAlign;

  // Constructor for initializing the decoration with required properties
  const NeumorphicTextDecoration({
    required this.style, // Neumorphic style configuration
    required this.textStyle, // Text style for rendering
    required this.isForeground, // Whether this is a foreground decoration
    required this.renderingByPath, // Whether to render using paths
    required this.text, // Text to render
    required this.textAlign, // Text alignment
  });

  // Creates the appropriate painter based on style depth
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    //print("createBoxPainter : ${style.depth}");
    // If depth is non-negative, use NeumorphicDecorationTextPainter
    if (style.depth != null && style.depth! >= 0) {
      return NeumorphicDecorationTextPainter(
        style: style,
        textStyle: textStyle,
        textAlign: textAlign,
        drawGradient: true, // Always draw gradient for non-negative depth
        drawBackground: !isForeground, // Background only for non-foreground
        drawShadow: !isForeground, // Shadows only for non-foreground
        renderingByPath: renderingByPath,
        onChanged: onChanged ?? () {}, // Default to no-op callback
        text: text,
      );
    } else {
      // Use NeumorphicEmptyTextPainter for negative depth (no rendering)
      return NeumorphicEmptyTextPainter(onChanged: onChanged ?? () {});
    }
    /* else {
      return NeumorphicEmbossDecorationPainter(
        drawBackground: !isForeground,
        style: style,
        drawShadow: (isForeground && splitBackgroundForeground) ||
            (!isForeground && !splitBackgroundForeground),
        onChanged: onChanged,
        shape: shape,
      );
    }
    */
  }

  // Interpolates from a previous decoration to this one
  @override
  NeumorphicTextDecoration? lerpFrom(Decoration? a, double t) {
    if (a == null) return scale(t); // Scale this decoration if no previous
    if (a is NeumorphicTextDecoration) {
      return NeumorphicTextDecoration.lerp(
        a,
        this,
        t,
      ); // Interpolate between two NeumorphicTextDecorations
    }
    return super.lerpFrom(a, t)
        as NeumorphicTextDecoration; // Fallback to superclass
  }

  // Interpolates to a next decoration from this one
  @override
  NeumorphicTextDecoration? lerpTo(Decoration? b, double t) {
    if (b == null) return scale(1.0 - t); // Scale this decoration if no next
    if (b is NeumorphicTextDecoration) {
      return NeumorphicTextDecoration.lerp(
        this,
        b,
        t,
      ); // Interpolate between two NeumorphicTextDecorations
    }
    return super.lerpTo(b, t)
        as NeumorphicTextDecoration; // Fallback to superclass
  }

  // Scales the decoration by a factor
  NeumorphicTextDecoration scale(double factor) {
    print("scale");
    return NeumorphicTextDecoration(
      textAlign: textAlign,
      isForeground: isForeground,
      renderingByPath: renderingByPath,
      text: text,
      textStyle: textStyle,
      style: style.copyWith(), // Create a copy of the style
    );
  }

  // Static method to interpolate between two NeumorphicTextDecorations
  static NeumorphicTextDecoration? lerp(
    NeumorphicTextDecoration? a,
    NeumorphicTextDecoration? b,
    double t,
  ) {
    //print("lerp $t ${a.style.depth}, ${b.style.depth}");

    if (a == null && b == null) return null; // Return null if both are null
    if (a == null) return b!.scale(t); // Scale b if a is null
    if (b == null) return a.scale(1.0 - t); // Scale a if b is null
    if (t == 0.0) {
      //print("return a");
      return a; // Return a if t is 0
    }
    if (t == 1.0) {
      //print("return b (1.0)");
      return b; // Return b if t is 1
    }

    var aStyle = a.style;
    var bStyle = b.style;

    // Create a new decoration with interpolated properties
    return NeumorphicTextDecoration(
      isForeground: a.isForeground,
      text: a.text,
      textAlign: a.textAlign,
      textStyle:
          TextStyle.lerp(a.textStyle, b.textStyle, t) ??
          TextStyle(), // Interpolate text style
      renderingByPath: a.renderingByPath,
      style: a.style.copyWith(
        border: NeumorphicBorder.lerp(
          aStyle.border,
          bStyle.border,
          t,
        ), // Interpolate border
        intensity: lerpDouble(
          aStyle.intensity,
          bStyle.intensity,
          t,
        ), // Interpolate intensity
        depth: lerpDouble(aStyle.depth, bStyle.depth, t), // Interpolate depth
        color: Color.lerp(aStyle.color, bStyle.color, t), // Interpolate color
        lightSource: LightSource.lerp(
          aStyle.lightSource,
          bStyle.lightSource,
          t,
        ), // Interpolate light source
      ),
    );
  }

  // Indicates that this decoration is complex (requires layer)
  @override
  bool get isComplex => true;

  // Equality comparison for NeumorphicTextDecoration objects
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicTextDecoration &&
          runtimeType == other.runtimeType &&
          style == other.style &&
          text == other.text &&
          textStyle == other.textStyle &&
          isForeground == other.isForeground &&
          renderingByPath == other.renderingByPath;

  // Generates hash code for the decoration
  @override
  int get hashCode =>
      style.hashCode ^
      text.hashCode ^
      textStyle.hashCode ^
      isForeground.hashCode ^
      renderingByPath.hashCode;
}

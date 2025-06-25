// ignore_for_file: avoid_print

import 'dart:ui';

import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

import 'neumorphic_decoration_painter.dart';
import 'neumorphic_emboss_decoration_painter.dart';

// Immutable decoration class for rendering neumorphic effects
@immutable
class NeumorphicDecoration extends Decoration {
  // Style configuration for the neumorphic effect
  final NeumorphicStyle style;
  // Shape configuration for the element
  final NeumorphicBoxShape shape;
  // Flag to split background and foreground rendering
  final bool splitBackgroundForeground;
  // Flag to enable path-based rendering
  final bool renderingByPath;
  // Flag to indicate if this is a foreground decoration
  final bool isForeground;

  // Constructor for initializing the decoration with required properties
  const NeumorphicDecoration({
    required this.style, // Neumorphic style configuration
    required this.isForeground, // Whether this is a foreground decoration
    required this.renderingByPath, // Whether to render using paths
    required this.splitBackgroundForeground, // Whether to split background/foreground
    required this.shape, // Shape of the element
  });

  // Creates the appropriate painter based on style depth
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // If depth is non-negative, use NeumorphicDecorationPainter
    if (style.depth != null && style.depth! >= 0) {
      return NeumorphicDecorationPainter(
        style: style,
        // Gradient drawn for foreground if split, or background if not split
        drawGradient:
            (isForeground && splitBackgroundForeground) ||
            (!isForeground && !splitBackgroundForeground),
        drawBackground: !isForeground, // Background only for non-foreground
        drawShadow: !isForeground, // Shadows only for non-foreground
        renderingByPath: renderingByPath,
        onChanged: onChanged ?? () {}, // Default to no-op callback
        shape: shape,
      );
    } else {
      // Use NeumorphicEmbossDecorationPainter for negative depth (emboss effect)
      return NeumorphicEmbossDecorationPainter(
        drawBackground: !isForeground, // Background only for non-foreground
        style: style,
        // Shadows drawn for foreground if split, or background if not split
        drawShadow:
            (isForeground && splitBackgroundForeground) ||
            (!isForeground && !splitBackgroundForeground),
        onChanged: onChanged ?? () {}, // Default to no-op callback
        shape: shape,
      );
    }
  }

  // Interpolates from a previous decoration to this one
  @override
  NeumorphicDecoration lerpFrom(Decoration? a, double t) {
    if (a == null) return scale(t); // Scale this decoration if no previous
    if (a is NeumorphicDecoration) {
      return NeumorphicDecoration.lerp(
        a,
        this,
        t,
      )!; // Interpolate between two NeumorphicDecorations
    }
    return super.lerpFrom(a, t)
        as NeumorphicDecoration; // Fallback to superclass
  }

  // Interpolates to a next decoration from this one
  @override
  NeumorphicDecoration lerpTo(Decoration? b, double t) {
    if (b == null) return scale(1.0 - t); // Scale this decoration if no next
    if (b is NeumorphicDecoration) {
      return NeumorphicDecoration.lerp(
        this,
        b,
        t,
      )!; // Interpolate between two NeumorphicDecorations
    }
    return super.lerpTo(b, t) as NeumorphicDecoration; // Fallback to superclass
  }

  // Scales the decoration by a factor
  NeumorphicDecoration scale(double factor) {
    print("scale");
    return NeumorphicDecoration(
      isForeground: isForeground,
      renderingByPath: renderingByPath,
      splitBackgroundForeground: splitBackgroundForeground,
      shape: NeumorphicBoxShape.lerp(null, shape, factor)!, // Interpolate shape
      style: style.copyWith(), // Create a copy of the style
    );
  }

  // Static method to interpolate between two NeumorphicDecorations
  static NeumorphicDecoration? lerp(
    NeumorphicDecoration? a,
    NeumorphicDecoration? b,
    double t,
  ) {
    if (a == null && b == null) return null; // Return null if both are null
    if (a == null) return b!.scale(t); // Scale b if a is null
    if (b == null) return a.scale(1.0 - t); // Scale a if b is null
    if (t == 0.0) {
      return a; // Return a if t is 0
    }
    if (t == 1.0) {
      return b; // Return b if t is 1
    }

    var aStyle = a.style;
    var bStyle = b.style;

    // Create a new decoration with interpolated properties
    return NeumorphicDecoration(
      isForeground: a.isForeground,
      shape: NeumorphicBoxShape.lerp(a.shape, b.shape, t)!, // Interpolate shape
      splitBackgroundForeground: a.splitBackgroundForeground,
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
        surfaceIntensity: lerpDouble(
          aStyle.surfaceIntensity,
          bStyle.surfaceIntensity,
          t,
        ), // Interpolate surface intensity
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

  // Equality comparison for NeumorphicDecoration objects
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicDecoration &&
          runtimeType == other.runtimeType &&
          style == other.style &&
          shape == other.shape &&
          splitBackgroundForeground == other.splitBackgroundForeground &&
          isForeground == other.isForeground &&
          renderingByPath == other.renderingByPath;

  // Generates hash code for the decoration
  @override
  int get hashCode =>
      style.hashCode ^
      shape.hashCode ^
      splitBackgroundForeground.hashCode ^
      isForeground.hashCode ^
      renderingByPath.hashCode;
}

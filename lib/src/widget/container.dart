// ignore_for_file: unused_element_parameter

import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../decoration/neumorphic_decorations.dart';
import '../neumorphic_box_shape.dart';
import '../theme/neumorphic_theme.dart';
import 'clipper/neumorphic_box_shape_clipper.dart';

export '../decoration/neumorphic_decorations.dart';
export '../neumorphic_box_shape.dart';
export '../theme/neumorphic_theme.dart';

/// The main container of the Neumorphic UI KIT
/// it takes a Neumorphic style @see [NeumorphicStyle]
///
/// it's clipped using a [NeumorphicBoxShape] (circle, roundrect, stadium)
///
/// It can be, depending on its [NeumorphicStyle.shape] : [NeumorphicShape.concave],  [NeumorphicShape.convex],  [NeumorphicShape.flat]
///
/// if [NeumorphicStyle.depth] < 0 ----> use the emboss shape
///
/// The container animates any change for you, with [duration] ! (including style / theme / size / etc.)
///
/// [drawSurfaceAboveChild] enable to draw emboss, concave, convex effect above this widget child
///
/// drawSurfaceAboveChild - UseCase 1 :
///
///   put an image inside a neumorphic(concave) :
///   drawSurfaceAboveChild=false -> the concave effect is below the image
///   drawSurfaceAboveChild=true -> the concave effect is above the image, the image seems concave
///
/// drawSurfaceAboveChild - UseCase 2 :
///   put an image inside a neumorphic(emboss) :
///   drawSurfaceAboveChild=false -> the emboss effect is below the image -> not visible
///   drawSurfaceAboveChild=true -> the emboss effeect effect is above the image -> visible
///
@immutable
class Neumorphic extends StatelessWidget {
  // Default animation duration for changes
  static const defaultDuration = Duration(milliseconds: 100);
  // Default animation curve for transitions
  static const defaultCurve = Curves.linear;

  // Minimum allowed depth for neumorphic effects
  static const double minDepth = -20.0;
  // Maximum allowed depth for neumorphic effects
  static const double maxDepth = 20.0;

  // Minimum allowed intensity for shadows
  static const double minIntensity = 0.0;
  // Maximum allowed intensity for shadows
  static const double maxIntensity = 1.0;

  // Minimum allowed curve value
  static const double minCurve = 0.0;
  // Maximum allowed curve value
  static const double maxCurve = 1.0;

  // The child widget to be displayed within the container
  final Widget? child;

  // Optional neumorphic style for the container
  final NeumorphicStyle? style;
  // Optional text style for child text widgets
  final TextStyle? textStyle;
  // Padding inside the container
  final EdgeInsets padding;
  // Margin outside the container
  final EdgeInsets margin;
  // Animation curve for transitions
  final Curve curve;
  // Duration of animations
  final Duration duration;
  // Whether to draw the surface effect above the child
  final bool drawSurfaceAboveChild;

  // Constructor for initializing the Neumorphic container
  const Neumorphic({
    super.key,
    this.child, // Optional child widget
    this.duration = Neumorphic.defaultDuration, // Default animation duration
    this.curve = Neumorphic.defaultCurve, // Default animation curve
    this.style, // Optional style
    this.textStyle, // Optional text style
    this.margin = const EdgeInsets.all(0), // Default to zero margin
    this.padding = const EdgeInsets.all(0), // Default to zero padding
    this.drawSurfaceAboveChild = true, // Default to draw surface above child
  });

  // Builds the widget tree for the neumorphic container
  @override
  Widget build(BuildContext context) {
    // Get the current neumorphic theme
    final theme = NeumorphicTheme.currentTheme(context);
    // Apply theme defaults to style and handle disabled depth
    final NeumorphicStyle style = (this.style ?? NeumorphicStyle())
        .copyWithThemeIfNull(theme)
        .applyDisableDepth();

    // Return the internal container widget
    return _NeumorphicContainer(
      padding: padding, // Apply padding
      textStyle: textStyle, // Apply text style
      drawSurfaceAboveChild:
          drawSurfaceAboveChild, // Apply surface drawing setting
      duration: duration, // Apply animation duration
      style: style, // Apply resolved style
      curve: curve, // Apply animation curve
      margin: margin, // Apply margin
      child: child, // Apply child widget
    );
  }
}

// Internal container widget for rendering the neumorphic effect
class _NeumorphicContainer extends StatelessWidget {
  // Resolved neumorphic style
  final NeumorphicStyle style;
  // Optional text style for child text
  final TextStyle? textStyle;
  // Child widget to be displayed
  final Widget? child;
  // Margin outside the container
  final EdgeInsets margin;
  // Duration of animations
  final Duration duration;
  // Animation curve for transitions
  final Curve curve;
  // Whether to draw the surface effect above the child
  final bool drawSurfaceAboveChild;
  // Padding inside the container
  final EdgeInsets padding;

  // Constructor for initializing the internal container
  const _NeumorphicContainer({
    super.key,
    this.child, // Optional child widget
    this.textStyle, // Optional text style
    required this.padding, // Required padding
    required this.margin, // Required margin
    required this.duration, // Required animation duration
    required this.curve, // Required animation curve
    required this.style, // Required style
    required this.drawSurfaceAboveChild, // Required surface drawing setting
  });

  // Builds the widget tree for the container
  @override
  Widget build(BuildContext context) {
    // Use the provided box shape or default to rectangle
    final shape = style.boxShape ?? NeumorphicBoxShape.rect();

    // Apply default text style to child text widgets
    return DefaultTextStyle(
      style:
          textStyle ??
          material.Theme.of(
            context,
          ).textTheme.bodyMedium!, // Default text style
      child: AnimatedContainer(
        margin: margin, // Apply margin
        duration: duration, // Apply animation duration
        curve: curve, // Apply animation curve
        // Apply foreground decoration for surface effects if needed
        foregroundDecoration: NeumorphicDecoration(
          isForeground: true, // Foreground decoration
          renderingByPath: shape
              .customShapePathProvider
              .oneGradientPerPath, // Path rendering setting
          splitBackgroundForeground:
              drawSurfaceAboveChild, // Surface drawing setting
          style: style, // Apply style
          shape: shape, // Apply shape
        ),
        // Apply background decoration for the container
        decoration: NeumorphicDecoration(
          isForeground: false, // Background decoration
          renderingByPath: shape
              .customShapePathProvider
              .oneGradientPerPath, // Path rendering setting
          splitBackgroundForeground:
              drawSurfaceAboveChild, // Surface drawing setting
          style: style, // Apply style
          shape: shape, // Apply shape
        ),
        // Clip the child with the specified shape
        child: NeumorphicBoxShapeClipper(
          shape: shape, // Apply shape for clipping
          child: Padding(
            padding: padding,
            child: child,
          ), // Apply padding to child
        ),
      ),
    );
  }
}

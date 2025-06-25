import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';
import 'package:flutter_neumorphic_ui/src/shape/rrect_path_provider.dart';
import 'package:flutter_neumorphic_ui/src/shape/stadium_path_provider.dart';

import 'shape/beveled_path_provider.dart';
import 'shape/circle_path_provider.dart';
import 'shape/rect_path_provider.dart';

export 'shape/path/flutter_logo_path_provider.dart';

/// Define a Neumorphic container box shape

class NeumorphicBoxShape {
  final NeumorphicPathProvider
  customShapePathProvider; // Path provider for the shape

  /// Private constructor to initialize with a path provider
  const NeumorphicBoxShape._(this.customShapePathProvider);

  /// Creates a circular box shape
  const NeumorphicBoxShape.circle() : this._(const CirclePathProvider());

  /// Creates a custom path-based box shape
  const NeumorphicBoxShape.path(NeumorphicPathProvider pathProvider)
    : this._(pathProvider);

  /// Creates a rectangular box shape
  const NeumorphicBoxShape.rect() : this._(const RectPathProvider());

  /// Creates a stadium-shaped (capsule) box shape
  NeumorphicBoxShape.stadium() : this._(StadiumPathProvider());

  /// Creates a rounded rectangle box shape with specified border radius
  NeumorphicBoxShape.roundRect(BorderRadius borderRadius)
    : this._(RRectPathProvider(borderRadius));

  /// Creates a beveled rectangle box shape with specified border radius
  NeumorphicBoxShape.beveled(BorderRadius borderRadius)
    : this._(BeveledPathProvider(borderRadius));

  /// Checks if the shape is a custom path
  bool get isCustomPath =>
      !isStadium && !isRect && !isCircle && !isRoundRect && !isBeveled;

  /// Checks if the shape is a stadium (capsule)
  bool get isStadium =>
      customShapePathProvider.runtimeType == StadiumPathProvider;

  /// Checks if the shape is a circle
  bool get isCircle =>
      customShapePathProvider.runtimeType == CirclePathProvider;

  /// Checks if the shape is a rectangle
  bool get isRect => customShapePathProvider.runtimeType == RectPathProvider;

  /// Checks if the shape is a rounded rectangle
  bool get isRoundRect =>
      customShapePathProvider.runtimeType == RRectPathProvider;

  /// Checks if the shape is a beveled rectangle
  bool get isBeveled =>
      customShapePathProvider.runtimeType == BeveledPathProvider;

  /// Interpolates between two NeumorphicBoxShape instances
  static NeumorphicBoxShape? lerp(
    NeumorphicBoxShape? a,
    NeumorphicBoxShape? b,
    double t,
  ) {
    if (a == null && b == null) return null; // Returns null if both are null

    if (t == 0.0) return a; // Returns a if interpolation factor is 0
    if (t == 1.0) return b; // Returns b if interpolation factor is 1

    if (a == null) {
      if (b!.isCircle || b.isRect || b.isStadium || b.isCustomPath) {
        return b; // Returns b if b is a non-interpolatable shape
      } else {
        return NeumorphicBoxShape.roundRect(
          BorderRadius.lerp(
            null,
            (b.customShapePathProvider as RRectPathProvider).borderRadius,
            t,
          )!, // Interpolates border radius for roundRect
        );
      }
    }
    if (a.isCircle || a.isRect || a.isStadium || a.isCustomPath) {
      return a; // Returns a if a is a non-interpolatable shape
    }

    if (b == null) {
      if (a.isCircle || a.isRect || a.isStadium || a.isCustomPath) {
        return a; // Returns a if a is a non-interpolatable shape
      } else {
        return NeumorphicBoxShape.roundRect(
          BorderRadius.lerp(
            null,
            (a.customShapePathProvider as RRectPathProvider).borderRadius,
            t,
          )!, // Interpolates border radius for roundRect
        );
      }
    }
    if (b.isCircle || b.isRect || b.isStadium || b.isCustomPath) {
      return b; // Returns b if b is a non-interpolatable shape
    }

    if (a.isBeveled && b.isBeveled) {
      return NeumorphicBoxShape.beveled(
        BorderRadius.lerp(
          (a.customShapePathProvider as BeveledPathProvider).borderRadius,
          (b.customShapePathProvider as BeveledPathProvider).borderRadius,
          t,
        )!, // Interpolates border radius for beveled shape
      );
    }

    return NeumorphicBoxShape.roundRect(
      BorderRadius.lerp(
        (a.customShapePathProvider as RRectPathProvider).borderRadius,
        (b.customShapePathProvider as RRectPathProvider).borderRadius,
        t,
      )!, // Interpolates border radius for roundRect
    );
  }
}

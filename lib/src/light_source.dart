import 'dart:ui';

import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

/// A custom offset that define a source of light used to project a shadow of a widget
/// left -1 <= dx <= 1 right
/// top -1 <= dy <= 1 bottom
///
/// constants like "top", "topLeft", "topRight" are providen in LightSource
///
@immutable
class LightSource {
  final double
  dx; // X-coordinate of the light source (-1 for left, 1 for right)
  final double
  dy; // Y-coordinate of the light source (-1 for top, 1 for bottom)

  const LightSource(this.dx, this.dy);

  /// Returns the light source position as an Offset
  Offset get offset => Offset(dx, dy);

  // Predefined light source positions
  static const top = LightSource(0, -1); // Light source at top center
  static const topLeft = LightSource(-1, -1); // Light source at top-left corner
  static const topRight = LightSource(
    1,
    -1,
  ); // Light source at top-right corner
  static const bottom = LightSource(0, 1); // Light source at bottom center
  static const bottomLeft = LightSource(
    -1,
    1,
  ); // Light source at bottom-left corner
  static const bottomRight = LightSource(
    1,
    1,
  ); // Light source at bottom-right corner
  static const left = LightSource(-1, 0); // Light source at left center
  static const right = LightSource(1, 0); // Light source at right center

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LightSource &&
          runtimeType == other.runtimeType &&
          offset == other.offset; // Compares light sources based on offset

  @override
  int get hashCode => offset.hashCode; // Generates hash code based on offset

  /// Scales the light source offset by a given distance
  Offset toOffset(double distance) {
    return offset.scale(distance, distance);
  }

  @override
  String toString() {
    return 'LightSource{dx: $dx, dy: $dy}'; // String representation of the light source
  }

  /// Returns a new LightSource with inverted coordinates
  LightSource invert() => LightSource(dx * -1, dy * -1);

  /// Interpolates between two LightSource instances
  static LightSource? lerp(LightSource? a, LightSource? b, double t) {
    if (a == null && b == null) {
      return null; // Returns null if both inputs are null
    }
    if (a == null) return b; // Returns b if a is null
    if (b == null) return a; // Returns a if b is null
    if (a == b) return a; // Returns a if both are equal
    if (t == 0.0) return a; // Returns a if interpolation factor is 0
    if (t == 1.0) return b; // Returns b if interpolation factor is 1

    return LightSource(
      (a.dx != b.dx ? lerpDouble(a.dx, b.dx, t) : a.dx)!, // Interpolates dx
      (a.dy != b.dy ? lerpDouble(a.dy, b.dy, t) : a.dy)!, // Interpolates dy
    );
  }

  /// Creates a copy of the LightSource with optional new dx and dy values
  LightSource copyWith({double? dx, double? dy}) {
    return LightSource(dx ?? this.dx, dy ?? this.dy);
  }
}

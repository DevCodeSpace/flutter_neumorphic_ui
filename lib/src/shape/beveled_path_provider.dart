import 'dart:math' as math;

import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Custom path provider for creating a beveled shape with rounded corners
class BeveledPathProvider extends NeumorphicPathProvider {
  // Border radius configuration for the corners of the shape
  final BorderRadius borderRadius;

  // Constructor initializes with border radius and optional reclip listener
  const BeveledPathProvider(this.borderRadius, {Listenable? reclip});

  // Determines if the path should be reclipped by comparing with the old clipper
  @override
  bool shouldReclip(NeumorphicPathProvider oldClipper) {
    return true; // Always reclip to ensure the path is updated
  }

  // Generates the path for the beveled shape based on the provided size
  @override
  Path getPath(Size size) {
    // Create a rounded rectangle (RRect) with specified border radii
    final rrect = RRect.fromLTRBAndCorners(
      0,
      0,
      size.width,
      size.height,
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
      bottomLeft: borderRadius.bottomLeft,
      bottomRight: borderRadius.bottomRight,
    );
    // Convert the RRect to a beveled path
    return _getPath(rrect);
  }

  // Converts an RRect to a beveled polygon path (inspired by Material design)
  Path _getPath(RRect rrect) {
    // Define key points at the center of each side
    final Offset centerLeft = Offset(rrect.left, rrect.center.dy);
    final Offset centerRight = Offset(rrect.right, rrect.center.dy);
    final Offset centerTop = Offset(rrect.center.dx, rrect.top);
    final Offset centerBottom = Offset(rrect.center.dx, rrect.bottom);

    // Ensure non-negative radius values for each corner
    final double tlRadiusX = math.max(
      0.0,
      rrect.tlRadiusX,
    ); // Top-left X radius
    final double tlRadiusY = math.max(
      0.0,
      rrect.tlRadiusY,
    ); // Top-left Y radius
    final double trRadiusX = math.max(
      0.0,
      rrect.trRadiusX,
    ); // Top-right X radius
    final double trRadiusY = math.max(
      0.0,
      rrect.trRadiusY,
    ); // Top-right Y radius
    final double blRadiusX = math.max(
      0.0,
      rrect.blRadiusX,
    ); // Bottom-left X radius
    final double blRadiusY = math.max(
      0.0,
      rrect.blRadiusY,
    ); // Bottom-left Y radius
    final double brRadiusX = math.max(
      0.0,
      rrect.brRadiusX,
    ); // Bottom-right X radius
    final double brRadiusY = math.max(
      0.0,
      rrect.brRadiusY,
    ); // Bottom-right Y radius

    // Define vertices for the beveled polygon, accounting for corner radii
    final List<Offset> vertices = <Offset>[
      Offset(
        rrect.left,
        math.min(centerLeft.dy, rrect.top + tlRadiusY),
      ), // Top-left corner
      Offset(
        math.min(centerTop.dx, rrect.left + tlRadiusX),
        rrect.top,
      ), // Top-left to top
      Offset(
        math.max(centerTop.dx, rrect.right - trRadiusX),
        rrect.top,
      ), // Top to top-right
      Offset(
        rrect.right,
        math.min(centerRight.dy, rrect.top + trRadiusY),
      ), // Top-right corner
      Offset(
        rrect.right,
        math.max(centerRight.dy, rrect.bottom - brRadiusY),
      ), // Bottom-right corner
      Offset(
        math.max(centerBottom.dx, rrect.right - brRadiusX),
        rrect.bottom,
      ), // Bottom-right to bottom
      Offset(
        math.min(centerBottom.dx, rrect.left + blRadiusX),
        rrect.bottom,
      ), // Bottom to bottom-left
      Offset(
        rrect.left,
        math.max(centerLeft.dy, rrect.bottom - blRadiusY),
      ), // Bottom-left corner
    ];

    // Create and return a closed polygon path from the vertices
    return Path()..addPolygon(vertices, true);
  }

  // Specifies that a single gradient should be applied to the entire path
  @override
  bool get oneGradientPerPath => false; // Only one path, so one gradient
}

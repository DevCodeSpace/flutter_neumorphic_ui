import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Custom path provider for creating a rounded rectangle shape for neumorphic effects
class RRectPathProvider extends NeumorphicPathProvider {
  // Border radius configuration for the corners of the rounded rectangle
  final BorderRadius borderRadius;

  // Constructor initializes with border radius and optional reclip listener
  const RRectPathProvider(this.borderRadius, {Listenable? reclip});

  // Determines if the path should be reclipped by comparing with the old clipper
  @override
  bool shouldReclip(NeumorphicPathProvider oldClipper) {
    return true; // Always reclip to ensure the path is updated
  }

  // Generates the path for a rounded rectangle based on the provided size
  @override
  Path getPath(Size size) {
    // Create and return a path defining a rounded rectangle
    return Path()
      ..addRRect(
        RRect.fromLTRBAndCorners(
          0,
          0,
          size.width,
          size.height,
          topLeft: borderRadius.topLeft, // Top-left corner radius
          topRight: borderRadius.topRight, // Top-right corner radius
          bottomLeft: borderRadius.bottomLeft, // Bottom-left corner radius
          bottomRight: borderRadius.bottomRight, // Bottom-right corner radius
        ),
      )
      ..close(); // Close the path to form a complete rounded rectangle
  }

  // Specifies that a single gradient should be applied to the entire path
  @override
  bool get oneGradientPerPath => false; // Only one path, so one gradient
}

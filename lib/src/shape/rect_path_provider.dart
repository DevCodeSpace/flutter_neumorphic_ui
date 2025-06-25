import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Custom path provider for creating a rectangular shape for neumorphic effects
class RectPathProvider extends NeumorphicPathProvider {
  // Constructor with optional reclip listener
  const RectPathProvider({Listenable? reclip});

  // Determines if the path should be reclipped by comparing with the old clipper
  @override
  bool shouldReclip(NeumorphicPathProvider oldClipper) {
    return true; // Always reclip to ensure the path is updated
  }

  // Generates the path for a rectangle based on the provided size
  @override
  Path getPath(Size size) {
    // Create and return a path defining a rectangle
    return Path()
      ..addRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
      ) // Add rectangle from top-left to bottom-right
      ..close(); // Close the path to form a complete rectangle
  }

  // Specifies that a single gradient should be applied to the entire path
  @override
  bool get oneGradientPerPath => false; // Only one path, so one gradient
}

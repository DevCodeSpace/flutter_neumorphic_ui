import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Custom path provider for rendering the Flutter logo with neumorphic effects
class NeumorphicFlutterLogoPathProvider extends NeumorphicPathProvider {
  // Determines if the path should be reclipped by comparing with the old clipper
  @override
  bool shouldReclip(NeumorphicPathProvider oldClipper) {
    return true; // Always reclip to ensure the path is updated
  }

  // Generates the path for the Flutter logo based on the provided size
  @override
  Path getPath(Size size) {
    // Scale factors to adjust the logo coordinates to the provided size
    var scaleX = size.width / 166; // Base width of the logo is 166 units
    var scaleY = size.height / 202; // Base height of the logo is 202 units

    // Create and return a path defining the Flutter logo shape
    return Path()
      ..moveTo(37.7 * scaleX, 128.9 * scaleY) // Start at the first point
      ..lineTo(
        9.8 * scaleX,
        101.0 * scaleY,
      ) // Draw line to form the logo's top-left
      ..lineTo(100.4 * scaleX, 10.4 * scaleY) // Draw line to the top center
      ..lineTo(156.2 * scaleX, 10.4 * scaleY) // Draw line to the top-right
      ..moveTo(
        156.2 * scaleX,
        94.0 * scaleY,
      ) // Move to start the middle section
      ..lineTo(100.4 * scaleX, 94.0 * scaleY) // Draw line across the middle
      ..lineTo(51.6 * scaleX, 142.8 * scaleY) // Draw line to the bottom-left
      ..lineTo(100.4 * scaleX, 191.6 * scaleY) // Draw line to the bottom center
      ..lineTo(156.2 * scaleX, 191.6 * scaleY) // Draw line to the bottom-right
      ..lineTo(
        107.4 * scaleX,
        142.8 * scaleY,
      ) // Draw line to complete the shape
      ..close(); // Close the path to form a closed shape
  }

  // Specifies that each sub-path should have its own gradient
  @override
  bool get oneGradientPerPath => true; // Apply one shape (convex/concave) per sub-path
}

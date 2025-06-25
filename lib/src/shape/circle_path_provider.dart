import 'dart:math';

import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Custom path provider for creating a circular shape for neumorphic effects
class CirclePathProvider extends NeumorphicPathProvider {
  // Constructor with optional reclip listener
  const CirclePathProvider({Listenable? reclip});

  // Determines if the path should be reclipped by comparing with the old clipper
  @override
  bool shouldReclip(NeumorphicPathProvider oldClipper) {
    return true; // Always reclip to ensure the path is updated
  }

  // Generates the path for a circle based on the provided size
  @override
  Path getPath(Size size) {
    // Calculate the center point of the circle
    final middleHeight = size.height / 2; // Half of the height
    final middleWidth = size.width / 2; // Half of the width
    // Create and return a path defining a circle
    return Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(middleWidth, middleHeight), // Center at midpoint
          radius: min(
            middleHeight,
            middleWidth,
          ), // Radius is the smaller dimension
        ),
      )
      ..close(); // Close the path to form a complete circle
  }

  // Specifies that a single gradient should be applied to the entire path
  @override
  bool get oneGradientPerPath => false; // Only one path, so one gradient
}

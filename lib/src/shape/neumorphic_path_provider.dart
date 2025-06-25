import 'package:flutter/rendering.dart';

// Abstract class for providing custom paths for neumorphic effects
abstract class NeumorphicPathProvider extends CustomClipper<Path> {
  // Constructor with optional reclip listener
  const NeumorphicPathProvider({super.reclip});

  // Returns the clipping path for the given size, delegates to getPath
  @override
  Path getClip(Size size) {
    return getPath(size); // Use getPath to define the clipping region
  }

  /// Specifies gradient behavior for convex or concave shapes
  /// When true, each sub-path (created with moveTo) gets its own gradient
  /// When false, a single gradient is applied across the entire widget
  bool get oneGradientPerPath;

  // Abstract method to define the custom path based on the provided size
  Path getPath(Size size);

  // Determines if the clipper should be reclipped by comparing with the old clipper
  @override
  bool shouldReclip(NeumorphicPathProvider oldClipper) {
    return false; // Default to not reclipping unless overridden
  }
}

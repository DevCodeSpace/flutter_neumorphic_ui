import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// A stateless widget that clips its child using a NeumorphicBoxShape
class NeumorphicBoxShapeClipper extends StatelessWidget {
  // The neumorphic box shape defining the clipping path
  final NeumorphicBoxShape shape;
  // The optional child widget to be clipped
  final Widget? child;

  // Constructor for initializing the clipper with a shape and optional child
  const NeumorphicBoxShapeClipper({
    super.key,
    required this.shape, // Required shape for clipping
    this.child, // Optional child widget
  });

  // Retrieves the custom clipper from the provided NeumorphicBoxShape
  CustomClipper<Path>? _getClipper(NeumorphicBoxShape shape) {
    return shape
        .customShapePathProvider; // Returns the path provider for the shape
  }

  // Builds the widget tree with the clipped child
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _getClipper(shape), // Apply the custom clipper
      child: child, // Render the child widget
    );
  }
}

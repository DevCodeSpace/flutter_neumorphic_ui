// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/widgets.dart';

/// A implicit animated widget that updates the child's scale depending on the
/// parameter `scale` and `duration`
///
/// eg: in a stateful widget
///
/// double _scale = 1;
///
/// AnimatedScale(
///   scale: _scale,
///   child: /* a widget */
/// )
///
/// then use
///
/// setState(() {
///   _scale = 0.5
/// });
///
/// This will animate the child's scale from 1 to 0.5 in 150ms (default duration)
///
class AnimatedScale extends StatefulWidget {
  // The child widget to be scaled
  final Widget? child;
  // The target scale factor
  final double scale;
  // The duration of the scale animation
  final Duration duration;
  // The alignment point for the scaling transformation
  final Alignment alignment;

  // Constructor for initializing the AnimatedScale widget
  const AnimatedScale({
    super.key,
    this.child, // Optional child widget
    this.scale = 1, // Default scale is 1 (no scaling)
    this.duration = const Duration(
      milliseconds: 150,
    ), // Default animation duration
    this.alignment = Alignment.center, // Default alignment to center
  });

  // Creates the state for managing the animation
  @override
  _AnimatedScaleState createState() => _AnimatedScaleState();
}

// State class for managing the animation logic of AnimatedScale
class _AnimatedScaleState extends State<AnimatedScale>
    with TickerProviderStateMixin {
  // Controller for managing the animation
  late AnimationController _controller;
  // Animation for scaling the child widget
  late Animation<double> _animation;
  // Stores the previous scale value
  double oldScale = 1;

  // Initializes the animation controller and animation
  @override
  void initState() {
    // Create animation controller with the specified duration
    _controller = AnimationController(duration: widget.duration, vsync: this);
    // Initialize animation with the current scale as both start and end
    _animation = Tween<double>(
      begin: widget.scale,
      end: widget.scale,
    ).animate(_controller);
    super.initState();
  }

  // Updates the animation when the widget's properties change
  @override
  void didUpdateWidget(AnimatedScale oldWidget) {
    // Check if the scale has changed
    if (oldWidget.scale != widget.scale) {
      _controller.reset(); // Reset the animation controller
      oldScale = oldWidget.scale; // Store the previous scale
      // Create a new animation from the old scale to the new scale
      _animation = Tween<double>(
        begin: oldScale,
        end: widget.scale,
      ).animate(_controller);
      _controller.forward(); // Start the animation
    }
    super.didUpdateWidget(oldWidget);
  }

  // Cleans up resources when the widget is disposed
  @override
  void dispose() {
    _controller.dispose(); // Dispose of the animation controller
    super.dispose();
  }

  // Builds the widget tree with the animated scale transformation
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation, // Apply the scale animation
      alignment: widget.alignment, // Use the specified alignment
      child: widget.child, // Render the child widget
    );
  }
}

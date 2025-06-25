import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

/// A container that takes the current [NeumorphicTheme] baseColor as backgroundColor
/// @see [NeumorphicTheme]
///
/// It can provide too a roundRect clip of the screen border using [borderRadius], [margin] and [backendColor]
///
/// ```
/// NeumorphicBackground(
///      borderRadius: BorderRadius.circular(12),
///      margin: EdgeInsets.all(12),
///      child: ...`
/// )
/// ```
@immutable
class NeumorphicBackground extends StatelessWidget {
  // The child widget to be displayed within the background
  final Widget? child;
  // Optional padding inside the animated container
  final EdgeInsets? padding;
  // Optional margin outside the container
  final EdgeInsets? margin;
  // Background color behind the clipped area
  final Color backendColor;
  // Optional border radius for rounded rectangle clipping
  final BorderRadius? borderRadius;

  // Constructor for initializing the NeumorphicBackground
  const NeumorphicBackground({
    super.key,
    this.child, // Optional child widget
    this.padding, // Optional padding
    this.margin, // Optional margin
    this.borderRadius, // Optional border radius for clipping
    this.backendColor = const Color(0xFF000000), // Default to black background
  });

  // Builds the widget tree for the background
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: margin, // Apply margin as padding to the outer container
      color: backendColor, // Set the backend background color
      child: ClipRRect(
        borderRadius:
            borderRadius ??
            BorderRadius.circular(0), // Apply border radius or default to none
        child: AnimatedContainer(
          color: NeumorphicTheme.baseColor(
            context,
          ), // Use current theme's base color
          padding: padding, // Apply inner padding
          duration: const Duration(
            milliseconds: 100,
          ), // Animation duration for color changes
          child: child, // Render the child widget
        ),
      ),
    );
  }
}

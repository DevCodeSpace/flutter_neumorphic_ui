import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Export related dependencies for neumorphic decorations, box shape, and theme
export '../decoration/neumorphic_decorations.dart';
export '../neumorphic_box_shape.dart';
export '../theme/neumorphic_theme.dart';

// A stateless widget that renders a neumorphic-styled icon
@immutable
class NeumorphicIcon extends StatelessWidget {
  // The icon data to be displayed
  final IconData icon;
  // Optional neumorphic style for the icon
  final NeumorphicStyle? style;
  // Animation curve for transitions
  final Curve curve;
  // Size of the icon
  final double size;
  // Duration of the animation
  final Duration duration;

  // Constructor for initializing the NeumorphicIcon
  const NeumorphicIcon(
    this.icon, { // Required icon data
    super.key,
    this.duration = Neumorphic.defaultDuration, // Default animation duration
    this.curve = Neumorphic.defaultCurve, // Default animation curve
    this.style, // Optional style
    this.size = 20, // Default icon size
  });

  // Builds the widget tree for the icon
  @override
  Widget build(BuildContext context) {
    // Render the icon as a neumorphic text using its code point
    return NeumorphicText(
      String.fromCharCode(icon.codePoint), // Convert icon code point to string
      textStyle: NeumorphicTextStyle(
        fontSize: size, // Set font size to icon size
        fontFamily: icon.fontFamily, // Use icon's font family
        package: icon.fontPackage, // Use icon's font package
      ),
      duration: duration, // Apply animation duration
      style: style, // Apply neumorphic style
      curve: curve, // Apply animation curve
    );
  }
}

// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Type definition for the checkbox value change callback
typedef NeumorphicCheckboxListener<T> = void Function(T value);

/// A Style used to customize a NeumorphicCheckbox
///
/// selectedDepth : the depth when checked
/// unselectedDepth : the depth when unchecked (default : theme.depth)
/// selectedColor : the color when checked (default: theme.accent)
///
class NeumorphicCheckboxStyle {
  // Depth when the checkbox is checked
  final double? selectedDepth;
  // Depth when the checkbox is unchecked
  final double? unselectedDepth;
  // Whether to disable depth effects
  final bool? disableDepth;
  // Intensity of shadows when checked
  final double? selectedIntensity;
  // Intensity of shadows when unchecked
  final double unselectedIntensity;
  // Background color when checked
  final Color? selectedColor;
  // Color when the checkbox is disabled
  final Color? disabledColor;
  // Light source position for shadows
  final LightSource? lightSource;
  // Border configuration for the checkbox
  final NeumorphicBorder border;
  // Box shape of the checkbox
  final NeumorphicBoxShape? boxShape;

  // Constructor for initializing the checkbox style
  const NeumorphicCheckboxStyle({
    this.selectedDepth, // Optional selected depth
    this.border = const NeumorphicBorder.none(), // Default to no border
    this.selectedColor, // Optional selected color
    this.unselectedDepth, // Optional unselected depth
    this.disableDepth, // Optional depth disable flag
    this.lightSource, // Optional light source
    this.disabledColor, // Optional disabled color
    this.boxShape, // Optional box shape
    this.selectedIntensity = 1, // Default selected intensity
    this.unselectedIntensity = 0.7, // Default unselected intensity
  });

  // Equality comparison for NeumorphicCheckboxStyle objects
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicCheckboxStyle &&
          runtimeType == other.runtimeType &&
          selectedDepth == other.selectedDepth &&
          border == other.border &&
          unselectedDepth == other.unselectedDepth &&
          disableDepth == other.disableDepth &&
          selectedIntensity == other.selectedIntensity &&
          lightSource == other.lightSource &&
          unselectedIntensity == other.unselectedIntensity &&
          boxShape == other.boxShape &&
          selectedColor == other.selectedColor &&
          disabledColor == other.disabledColor;

  // Generates hash code for the style
  @override
  int get hashCode =>
      selectedDepth.hashCode ^
      unselectedDepth.hashCode ^
      border.hashCode ^
      lightSource.hashCode ^
      disableDepth.hashCode ^
      selectedIntensity.hashCode ^
      unselectedIntensity.hashCode ^
      boxShape.hashCode ^
      selectedColor.hashCode ^
      disabledColor.hashCode;
}

/// A Neumorphic Checkbox
///
/// takes a NeumorphicCheckboxStyle as `style`
/// takes the current checked state as `value`
///
/// notifies the parent when user interact with this widget with `onChanged`
///
/// ```
///  bool check1 = false;
///  bool check2 = false;
///  bool check3 = false;
///
///  Widget _buildChecks() {
///    return Row(
///      children: <Widget>[
///
///        NeumorphicCheckbox(
///          value: check1,
///          onChanged: (value) {
///            setState(() {
///              check1 = value;
///            });
///          },
///        ),
///
///        NeumorphicCheckbox(
///          value: check2,
///          onChanged: (value) {
///            setState(() {
///              check2 = value;
///            });
///          },
///        ),
///
///        NeumorphicCheckbox(
///          value: check3,
///          onChanged: (value) {
///            setState(() {
///              check3 = value;
///            });
///          },
///        ),
///
///      ],
///    );
///  }
/// ```
///
@immutable
class NeumorphicCheckbox extends StatelessWidget {
  // Current checked state of the checkbox
  final bool value;
  // Style configuration for the checkbox
  final NeumorphicCheckboxStyle style;
  // Callback triggered when the checkbox value changes
  final NeumorphicCheckboxListener onChanged;
  // Whether the checkbox is enabled
  final isEnabled;
  // Padding inside the checkbox
  final EdgeInsets padding;
  // Margin outside the checkbox
  final EdgeInsets margin;
  // Duration of the animation
  final Duration duration;
  // Animation curve for the transition
  final Curve curve;

  // Constructor for initializing the NeumorphicCheckbox
  const NeumorphicCheckbox({
    super.key,
    this.style = const NeumorphicCheckboxStyle(), // Default style
    required this.value, // Required checked state
    required this.onChanged, // Required change callback
    this.curve = Neumorphic.defaultCurve, // Default animation curve
    this.duration = Neumorphic.defaultDuration, // Default animation duration
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 12.0,
    ), // Default padding
    this.margin = const EdgeInsets.all(0), // Default margin
    this.isEnabled = true, // Default to enabled
  });

  // Indicates if the checkbox is selected
  bool get isSelected => value;

  // Handles click events by toggling the value
  void _onClick() {
    onChanged(!value); // Notify parent of value change
  }

  // Builds the widget tree for the checkbox
  @override
  Widget build(BuildContext context) {
    // Get the current neumorphic theme
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);
    // Use style's selected color or fallback to theme's accent color
    final selectedColor = style.selectedColor ?? theme.accentColor;

    // Calculate selected depth (negative absolute value)
    final double selectedDepth =
        -1 * (style.selectedDepth ?? theme.depth).abs();
    // Calculate unselected depth (absolute value)
    final double unselectedDepth = (style.unselectedDepth ?? theme.depth).abs();
    // Clamp selected intensity to valid range
    final double selectedIntensity =
        (style.selectedIntensity ?? theme.intensity).abs().clamp(
          Neumorphic.minIntensity,
          Neumorphic.maxIntensity,
        );
    // Clamp unselected intensity to valid range
    final double unselectedIntensity = style.unselectedIntensity.clamp(
      Neumorphic.minIntensity,
      Neumorphic.maxIntensity,
    );

    // Determine current depth based on selection state
    double depth = isSelected ? selectedDepth : unselectedDepth;
    if (!isEnabled) {
      depth = 0; // Disable depth if not enabled
    }

    // Determine background color based on selection state
    Color? color = isSelected ? selectedColor : null;
    if (!isEnabled) {
      color = null; // No color if disabled
    }

    // Determine icon color based on selection and enabled state
    Color iconColor = isSelected ? theme.baseColor : selectedColor;
    if (!isEnabled) {
      iconColor = theme.disabledColor; // Use disabled color if not enabled
    }

    // Create a neumorphic button to represent the checkbox
    return NeumorphicButton(
      padding: padding, // Apply padding
      pressed: isSelected, // Set pressed state based on selection
      margin: margin, // Apply margin
      duration: duration, // Apply animation duration
      curve: curve, // Apply animation curve
      onPressed: () {
        if (isEnabled) {
          _onClick(); // Handle click if enabled
        }
      },
      drawSurfaceAboveChild: true, // Draw surface above child
      minDistance: selectedDepth.abs(), // Set minimum depth for animation
      style: NeumorphicStyle(
        boxShape: style.boxShape, // Apply box shape
        border: style.border, // Apply border
        color: color, // Apply background color
        depth: depth, // Apply current depth
        lightSource:
            style.lightSource ?? theme.lightSource, // Apply light source
        disableDepth: style.disableDepth, // Apply depth disable flag
        intensity: isSelected
            ? selectedIntensity
            : unselectedIntensity, // Apply intensity
        shape: NeumorphicShape.flat, // Use flat shape
      ),
      child: Icon(
        Icons.check,
        color: iconColor,
        size: 20.0,
      ), // Display check icon
    );
  }
}

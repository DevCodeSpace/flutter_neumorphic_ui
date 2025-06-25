import 'package:flutter/widgets.dart';

import 'button.dart';
import 'container.dart';

typedef NeumorphicRadioListener<T> =
    void Function(
      T value,
    ); // Defines a callback type for handling radio value changes

/// A Style used to customize a [NeumorphicRadio]
///
/// [selectedDepth] : the depth when checked
/// [unselectedDepth] : the depth when unchecked (default : theme.depth)
///
/// [intensity] : a customizable neumorphic intensity for this widget
///
/// [boxShape] : a customizable neumorphic boxShape for this widget
///   @see [NeumorphicBoxShape]
///
/// [shape] : a customizable neumorphic shape for this widget
///   @see [NeumorphicShape] (concave, convex, flat)
///
class NeumorphicRadioStyle {
  final double? selectedDepth; // Depth when the radio is selected
  final double? unselectedDepth; // Depth when the radio is unselected
  final bool disableDepth; // Flag to disable depth effect

  final Color? selectedColor; // Color when selected (null for default)
  final Color?
  unselectedColor; // Color when unselected (null for unchanged color)

  final double? intensity; // Intensity of the neumorphic effect
  final NeumorphicShape?
  shape; // Shape of the neumorphic effect (concave, convex, flat)

  final NeumorphicBorder border; // Border style for the radio
  final NeumorphicBoxShape? boxShape; // Box shape for the radio

  final LightSource? lightSource; // Light source for the neumorphic effect

  const NeumorphicRadioStyle({
    this.selectedDepth,
    this.unselectedDepth,
    this.selectedColor,
    this.unselectedColor,
    this.lightSource,
    this.disableDepth = false,
    this.boxShape,
    this.border = const NeumorphicBorder.none(),
    this.intensity,
    this.shape,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicRadioStyle &&
          runtimeType == other.runtimeType &&
          disableDepth == other.disableDepth &&
          lightSource == other.lightSource &&
          border == other.border &&
          selectedDepth == other.selectedDepth &&
          unselectedDepth == other.unselectedDepth &&
          selectedColor == other.selectedColor &&
          unselectedColor == other.unselectedColor &&
          boxShape == other.boxShape &&
          intensity == other.intensity &&
          shape == other.shape;

  @override
  int get hashCode =>
      disableDepth.hashCode ^
      selectedDepth.hashCode ^
      lightSource.hashCode ^
      selectedColor.hashCode ^
      unselectedColor.hashCode ^
      boxShape.hashCode ^
      border.hashCode ^
      unselectedDepth.hashCode ^
      intensity.hashCode ^
      shape.hashCode;
}

/// A Neumorphic Radio
///
/// It takes a `value` and a `groupValue`
/// if (value == groupValue) => checked
///
/// takes a NeumorphicRadioStyle as `style`
///
/// notifies the parent when user interact with this widget with `onChanged`
///
/// ```
/// int _groupValue;
///
/// Widget _buildRadios() {
///    return Row(
///      children: <Widget>[
///
///        NeumorphicRadio(
///          child: SizedBox(
///            height: 50,
///            width: 50,
///            child: Center(
///              child: Text("1"),
///            ),
///          ),
///          value: 1,
///          groupValue: _groupValue,
///          onChanged: (value) {
///            setState(() {
///              _groupValue = value;
///            });
///          },
///        ),
///
///        NeumorphicRadio(
///          child: SizedBox(
///            height: 50,
///            width: 50,
///            child: Center(
///              child: Text("2"),
///            ),
///          ),
///          value: 2,
///          groupValue: _groupValue,
///          onChanged: (value) {
///            setState(() {
///              _groupValue = value;
///            });
///          },
///        ),
///
///        NeumorphicRadio(
///          child: SizedBox(
///            height: 50,
///            width: 50,
///            child: Center(
///              child: Text("3"),
///            ),
///          ),
///          value: 3,
///          groupValue: _groupValue,
///          onChanged: (value) {
///            setState(() {
///              _groupValue = value;
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
class NeumorphicRadio<T> extends StatelessWidget {
  final Widget? child; // Child widget to display inside the radio
  final T? value; // Value of this radio button
  final T? groupValue; // Current selected value in the group
  final EdgeInsets padding; // Padding around the radio button
  final NeumorphicRadioStyle style; // Custom style for the radio button
  final NeumorphicRadioListener<T?>?
  onChanged; // Callback when the radio is toggled
  final bool isEnabled; // Flag to enable or disable the radio

  final Duration duration; // Animation duration for state changes
  final Curve curve; // Animation curve for smooth transitions

  const NeumorphicRadio({
    super.key,
    this.child,
    this.style = const NeumorphicRadioStyle(),
    this.value,
    this.curve = Neumorphic.defaultCurve,
    this.duration = Neumorphic.defaultDuration,
    this.padding = EdgeInsets.zero,
    this.groupValue,
    this.onChanged,
    this.isEnabled = true,
  });

  bool get isSelected =>
      this.value != null &&
      this.value == this.groupValue; // Checks if the radio is selected

  void _onClick() {
    if (this.onChanged != null) {
      if (this.value == this.groupValue) {
        //unselect
        this.onChanged!(null); // Calls callback with null to unselect
      } else {
        this.onChanged!(this.value); // Calls callback with the selected value
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Retrieves the current neumorphic theme
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);

    // Sets the depth for selected state (negative for pressed effect)
    final double selectedDepth =
        -1 * (this.style.selectedDepth ?? theme.depth).abs();
    // Sets the depth for unselected state
    final double unselectedDepth = (this.style.unselectedDepth ?? theme.depth)
        .abs();

    // Determines the depth based on selection state
    double depth = isSelected ? selectedDepth : unselectedDepth;
    if (!this.isEnabled) {
      depth = 0; // Disables depth effect if radio is disabled
    }

    // Sets the color for unselected state (falls back to theme base color)
    final Color unselectedColor = this.style.unselectedColor ?? theme.baseColor;
    // Sets the color for selected state (falls back to unselected color)
    final Color selectedColor = this.style.selectedColor ?? unselectedColor;

    // Determines the color based on selection state
    final Color color = isSelected ? selectedColor : unselectedColor;

    return NeumorphicButton(
      onPressed: () {
        _onClick(); // Handles click event
      },
      duration: this.duration, // Applies animation duration
      curve: this.curve, // Applies animation curve
      padding: this.padding, // Applies padding
      pressed: isSelected, // Sets pressed state based on selection
      minDistance: selectedDepth, // Sets minimum depth for pressed state
      style: NeumorphicStyle(
        border: this.style.border, // Applies border style
        color: color, // Applies determined color
        boxShape: this.style.boxShape, // Applies box shape
        lightSource:
            this.style.lightSource ?? theme.lightSource, // Applies light source
        disableDepth: this.style.disableDepth, // Applies depth disable setting
        intensity: this.style.intensity, // Applies intensity
        depth: depth, // Applies determined depth
        shape:
            this.style.shape ??
            NeumorphicShape.flat, // Applies shape (defaults to flat)
      ),
      child: this.child, // Renders the child widget
    );
  }
}

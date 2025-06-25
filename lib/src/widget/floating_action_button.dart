import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Size constraints for a standard floating action button
const BoxConstraints _kSizeConstraints = BoxConstraints.tightFor(
  width: 56.0,
  height: 56.0,
);

// Size constraints for a mini floating action button
const BoxConstraints _kMiniSizeConstraints = BoxConstraints.tightFor(
  width: 40.0,
  height: 40.0,
);

// A stateless widget that creates a neumorphic-styled floating action button
class NeumorphicFloatingActionButton extends StatelessWidget {
  // The child widget displayed inside the button
  final Widget? child;
  // Callback triggered when the button is pressed
  final NeumorphicButtonClickListener? onPressed;
  // Whether to use the mini size constraints
  final bool mini;
  // Optional tooltip for accessibility
  final String? tooltip;
  // Optional neumorphic style for the button
  final NeumorphicStyle? style;

  // Constructor for initializing the floating action button
  const NeumorphicFloatingActionButton({
    super.key,
    this.mini = false, // Default to standard size
    this.style, // Optional style
    this.tooltip, // Optional tooltip
    @required this.child, // Required child widget
    @required this.onPressed, // Required press callback
  });

  // Builds the widget tree for the button
  @override
  Widget build(BuildContext context) {
    // Constrain the button size based on mini property
    return ConstrainedBox(
      constraints: mini
          ? _kMiniSizeConstraints
          : _kSizeConstraints, // Apply mini or standard constraints
      child: NeumorphicButton(
        padding: EdgeInsets.all(0), // No padding
        onPressed: onPressed, // Apply press callback
        tooltip: tooltip, // Apply tooltip
        style:
            style ??
            NeumorphicTheme.currentTheme(context)
                .appBarTheme
                .buttonStyle, // Use provided style or app bar theme style
        child: child, // Render the child widget
      ),
    );
  }
}

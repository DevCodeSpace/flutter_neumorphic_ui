import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// A stateless widget that creates a neumorphic-styled close button
class NeumorphicCloseButton extends StatelessWidget {
  // Callback function triggered when the button is pressed
  final VoidCallback? onPressed;
  // Optional neumorphic style for the button
  final NeumorphicStyle? style;
  // Optional padding for the button
  final EdgeInsets? padding;

  // Constructor for initializing the NeumorphicCloseButton
  const NeumorphicCloseButton({
    super.key,
    this.onPressed, // Optional custom press handler
    this.style, // Optional button style
    this.padding, // Optional button padding
  });

  // Builds the widget tree for the button
  @override
  Widget build(BuildContext context) {
    // Retrieve the app bar icons from the current neumorphic theme
    final nThemeIcons = NeumorphicTheme.of(context)!.current!.appBarTheme.icons;
    // Create a neumorphic button with the specified properties
    return NeumorphicButton(
      style: style, // Apply custom style if provided
      padding: padding, // Apply custom padding if provided
      tooltip: MaterialLocalizations.of(
        context,
      ).closeButtonTooltip, // Set tooltip for accessibility
      onPressed:
          onPressed ??
          () => Navigator.maybePop(
            context,
          ), // Default to pop navigation if no callback
      child: nThemeIcons.closeIcon, // Use close icon from theme
    );
  }
}

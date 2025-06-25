// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

import 'color_selector.dart';

/// A widget that allows the user to select and change the Neumorphic base color theme.
/// It uses a custom context to update the Neumorphic theme from outside the widget tree.
class ThemeColorSelector extends StatefulWidget {
  final BuildContext customContext; // The context to apply the theme change

  const ThemeColorSelector({super.key, required this.customContext});

  @override
  _ThemeColorSelectorState createState() => _ThemeColorSelectorState();
}

/// State class for ThemeColorSelector to handle theme color changes
class _ThemeColorSelectorState extends State<ThemeColorSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4), // Padding around the color selector
      color: Colors.black, // Background color for the container
      // Custom ColorSelector widget to pick a color
      child: ColorSelector(
        // Get the current base color from the provided context
        color: NeumorphicTheme.baseColor(widget.customContext),

        // Update the theme base color when a new color is selected
        onColorChanged: (color) {
          setState(() {
            NeumorphicTheme.update(
              widget.customContext,
              (current) => current!.copyWith(baseColor: color),
            );
          });
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

@immutable
/// A circular color selector that opens a color picker dialog when tapped.
/// It is customizable in size and returns the selected color via a callback.
class ColorSelector extends StatelessWidget {
  final Color color; // The currently selected color
  final ValueChanged<Color> onColorChanged; // Callback when a new color is selected
  final double height; // Height of the color selector circle
  final double width; // Width of the color selector circle

  const ColorSelector({
    super.key,
    this.height = 40,
    this.width = 40,
    required this.color,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _changeColor(context); // Opens color picker on tap
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: BoxShape.circle, // Circular shape
          color: color, // Fill with current color
          border: Border.all(color: Colors.grey, width: 1), // Border styling
        ),
      ),
    );
  }

  /// Displays a color picker dialog allowing the user to choose a new color
  void _changeColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: color, // Initial color shown
              onColorChanged: onColorChanged, // Triggered on color selection
              pickerAreaHeightPercent: 0.8, // Adjusts height of color picker
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              child: const Text('Close'),
              onTap: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}

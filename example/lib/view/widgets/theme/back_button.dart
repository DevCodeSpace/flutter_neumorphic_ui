import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

/// A custom back button styled with Neumorphic design.
/// When pressed, it pops the current route from the navigation stack.
class NeumorphicBack extends StatelessWidget {
  const NeumorphicBack({super.key});

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      padding: EdgeInsets.all(18), // Adds padding inside the circular button

      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.circle(), // Makes the button circular
        shape: NeumorphicShape.flat, // Flat appearance with Neumorphic feel
      ),

      // The back icon, styled based on the current theme (dark or light)
      child: Icon(
        Icons.arrow_back,
        color: NeumorphicTheme.isUsingDark(context)
            ? Colors.white70
            : Colors.black87,
      ),

      // Navigates back when the button is pressed
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}

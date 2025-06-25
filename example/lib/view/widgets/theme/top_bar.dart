import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

import 'back_button.dart';

/// A custom top bar widget that mimics an AppBar but uses Neumorphic styling.
/// It includes a back button, a title in the center, and optional action widgets on the right.
class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title; // Title to display in the center of the top bar
  final List<Widget>?
  actions; // Optional action widgets (e.g., icons) on the right side

  static const double kToolbarHeight = 110.0; // Fixed height of the top bar

  const TopBar({super.key, this.title = "", this.actions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 18.0,
      ), // Adds spacing below the top bar
      child: Stack(
        alignment: Alignment
            .center, // Align children relative to the center of the Stack
        children: [
          // Aligns the custom back button to the left
          Align(alignment: Alignment.centerLeft, child: NeumorphicBack()),

          // Displays the title text in the center
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: NeumorphicTheme.isUsingDark(context)
                    ? Colors.white70
                    : Colors.black87, // Adjusts color based on theme
              ),
            ),
          ),

          // Places the optional action widgets on the right
          Align(
            alignment: Alignment.centerRight,
            child: Row(mainAxisSize: MainAxisSize.min, children: actions ?? []),
          ),
        ],
      ),
    );
  }

  /// Defines the preferred height of the AppBar for use in Scaffold
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

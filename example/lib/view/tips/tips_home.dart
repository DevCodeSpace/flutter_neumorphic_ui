// Importing required packages and local widgets for UI components and navigation
import 'package:example/view/widgets/theme/top_bar.dart';
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Importing specific tip pages for border and recursive emboss demonstrations
import 'border/tips_border.dart';
import 'border/tips_emboss_inside_emboss.dart';

// Root widget for the Tips home page
class TipsHome extends StatelessWidget {
  // Constructor with optional key
  const TipsHome({super.key});

  // Builds a neumorphic button with consistent styling
  Widget _buildButton(context, {String? text, VoidCallback? onClick}) {
    // Creates a neumorphic button with customizable text and onClick callback
    return NeumorphicButton(
      margin: EdgeInsets.only(bottom: 12), // Adds bottom margin for spacing
      padding: EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 24,
      ), // Sets vertical and horizontal padding
      style: NeumorphicStyle(
        color: NeumorphicTheme.isUsingDark(context!)
            ? Colors.grey[800] // Darker color for dark theme
            : Colors.white,
        shape: NeumorphicShape.flat, // Uses flat shape for the button
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12),
        ), // Applies rounded rectangle shape
      ),
      onPressed: onClick, // Callback triggered on button press
      child: Center(
        child: Text(
          text!,
          style: TextStyle(
            color: NeumorphicTheme.isUsingDark(context)
                ? Colors
                      .white70 // Light text for dark theme
                : Colors.black87,
          ),
        ),
      ), // Centers the button text
    );
  }

  @override
  Widget build(BuildContext context) {
    // Wraps the page with NeumorphicTheme for consistent styling
    return NeumorphicTheme(
      theme: NeumorphicThemeData(depth: 8), // Sets depth for neumorphic shadow
      child: Scaffold(
        backgroundColor:
            NeumorphicColors.background, // Uses neumorphic background color
        body: SafeArea(
          // Ensures content avoids system UI areas
          child: SingleChildScrollView(
            // Enables scrolling for the content
            child: Padding(
              padding: const EdgeInsets.all(
                18.0,
              ), // Adds padding around the content
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .stretch, // Stretches children horizontally
                mainAxisAlignment:
                    MainAxisAlignment.start, // Aligns children at the start
                mainAxisSize: MainAxisSize.max, // Maximizes column size
                children: [
                  TopBar(title: "Tips"), // Displays the top bar with title
                  // Button to navigate to the Border tips page
                  _buildButton(
                    context,
                    text: "Border",
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return TipsBorderPage(); // Navigates to TipsBorderPage
                          },
                        ),
                      );
                    },
                  ),
                  // Button to navigate to the Recursive Emboss tips page
                  _buildButton(
                    context,
                    text: "Recursive Emboss",
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return TipsRecursiveeEmbossPage(); // Navigates to TipsRecursiveeEmbossPage
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

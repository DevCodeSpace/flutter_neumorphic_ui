// Importing required packages and local widgets for UI components and theming
import 'package:example/view/widgets/theme/theme_configurator.dart';
import 'package:example/view/widgets/theme/top_bar.dart';
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Root widget for the Galaxy sample demo page
class GalaxySample extends StatelessWidget {
  // Constructor with optional key
  const GalaxySample({super.key});

  @override
  Widget build(BuildContext context) {
    // Wraps the page with NeumorphicTheme for consistent styling
    return NeumorphicTheme(
      theme: NeumorphicThemeData(
        baseColor: Color(0xFFE5E5E5), // Light grey base color
        depth: 20, // High depth for pronounced neumorphic shadow
        intensity: 1, // Maximum intensity for neumorphic effect
        lightSource: LightSource.top, // Light source from top
      ),
      themeMode: ThemeMode.light, // Sets the theme to light mode
      child: Material(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFF1F1F1),
                Color(0xFFCFCFCF),
              ], // Gradient from light to darker grey
              begin: Alignment.topLeft, // Gradient starts at top-left
              end: Alignment.bottomRight, // Gradient ends at bottom-right
            ),
          ),
          child: _Page(), // Renders the main page content
        ),
      ),
    );
  }
}

// Container widget for the layout and UI of the Galaxy sample page
class _Page extends StatefulWidget {
  @override
  createState() => _PageState();
}

// State class for managing the page's UI
class _PageState extends State<_Page> {
  // Builds a styled letter widget for the "Galaxy" text
  Widget _letter(String letter) {
    return Text(
      letter, // Single letter to display
      style: TextStyle(
        color: Colors.black, // Black text color
        fontWeight: FontWeight.w700, // Bold font weight
        fontFamily: 'Samsung', // Custom font family
        fontSize: 80, // Large font size
      ),
    );
  }

  // Builds the first Neumorphic box with an inner emboss effect
  Widget _firstBox() {
    return Neumorphic(
      margin: EdgeInsets.symmetric(
        horizontal: 4,
      ), // Horizontal margin for spacing
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(8),
        ), // Rounded rectangle shape
      ),
      child: Neumorphic(
        style: NeumorphicStyle(
          depth: -1, // Negative depth for emboss effect
          oppositeShadowLightSource: true, // Opposite light source for contrast
        ),
        padding: EdgeInsets.all(2), // Small padding inside
        child: SizedBox(width: 40, height: 60), // Fixed size for the inner box
      ),
    );
  }

  // Builds the second Neumorphic box with a rotated appearance
  Widget _secondBox() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 4), // Asymmetric padding
      child: Transform.rotate(
        angle: 0.79, // Rotates by ~45 degrees (0.79 radians)
        child: Neumorphic(
          style: NeumorphicStyle(
            lightSource: LightSource.topLeft, // Light source for outer shape
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(8),
            ), // Rounded rectangle shape
          ),
          child: Neumorphic(
            style: NeumorphicStyle(
              depth: -1, // Negative depth for emboss effect
              oppositeShadowLightSource:
                  true, // Opposite light source for contrast
              lightSource: LightSource.topLeft, // Light source for inner shape
            ),
            child: SizedBox(
              width: 50,
              height: 50,
            ), // Fixed size for the inner box
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Builds the main page with a SafeArea and Stack for layered content
    return SafeArea(
      child: Stack(
        fit: StackFit.expand, // Expands to fill available space
        children: <Widget>[
          // Top bar with theme configurator
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(
                left: 12,
                right: 12,
                top: 10,
              ), // Margin for spacing
              child: TopBar(
                actions: <Widget>[ThemeConfigurator()],
              ), // Top bar with configurator
            ),
          ),
          // Centered row with "Galaxy" text and Neumorphic boxes
          Center(
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Centers vertically
              mainAxisSize: MainAxisSize.max, // Maximizes row width
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centers horizontally
              children: <Widget>[
                _letter("G"), // Letter G
                _firstBox(), // First Neumorphic box
                _letter("l"), // Letter l
                _secondBox(), // Second Neumorphic box
                _letter("x"), // Letter x
                _letter("y"), // Letter y
              ],
            ),
          ),
        ],
      ),
    );
  }
}

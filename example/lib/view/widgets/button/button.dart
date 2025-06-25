// ignore_for_file: avoid_print

// Importing the Neumorphic package for UI styling
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Root widget for the button sample demo page
class ButtonSample extends StatefulWidget {
  // Constructor with optional key
  const ButtonSample({super.key});

  @override
  createState() => _ButtonSampleState();
}

// State class for applying the Neumorphic theme and wrapping the content page
class _ButtonSampleState extends State<ButtonSample> {
  @override
  Widget build(BuildContext context) {
    // Wraps the page with NeumorphicTheme for consistent styling
    return NeumorphicTheme(
      themeMode: ThemeMode.light, // Sets the initial theme to light mode
      theme: NeumorphicThemeData(
        baseColor: Color(0xFFFFFFFF), // Sets base color for light theme (white)
        intensity: 0.5, // Sets intensity of neumorphic effect
        lightSource:
            LightSource.topLeft, // Defines light source for neumorphic effect
        depth: 10, // Sets depth for neumorphic shadow
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: Color(0xFF000000), // Sets base color for dark theme (black)
        intensity: 0.5, // Sets intensity of neumorphic effect
        lightSource:
            LightSource.topLeft, // Defines light source for neumorphic effect
        depth: 10, // Sets depth for neumorphic shadow
      ),
      child: _Page(), // Renders the main page content
    );
  }
}

// Container widget for the layout and UI of the button sample page
class _Page extends StatefulWidget {
  @override
  createState() => __PageState();
}

// State class for managing the page's UI and theme toggling
class __PageState extends State<_Page> {
  bool _useDark = false; // Tracks whether dark theme is active

  @override
  Widget build(BuildContext context) {
    // Builds the main scaffold with a safe area for content
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centers content vertically
          children: <Widget>[
            // Button to navigate back
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Pops the current route
              },
              child: Text("back"), // Button text
            ),
            // Button to toggle between light and dark themes
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _useDark = !_useDark; // Toggles the theme state
                  // Updates the theme mode based on _useDark
                  NeumorphicTheme.of(context)?.themeMode = _useDark
                      ? ThemeMode.dark
                      : ThemeMode.light;
                });
              },
              child: Text("toggle theme"), // Button text
            ),
            SizedBox(height: 34), // Adds vertical spacing
            _buildTopBar(context), // Builds the neumorphic button bar
          ],
        ),
      ),
    );
  }

  // Builds the top bar with a neumorphic button
  Widget _buildTopBar(BuildContext context) {
    return Center(
      child: NeumorphicButton(
        onPressed: () {
          print("click"); // Prints to console on button press
        },
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat, // Sets flat shape for the button
          boxShape: NeumorphicBoxShape.circle(), // Sets circular shape
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0), // Adds padding inside the button
          child: Icon(
            Icons.favorite_border, // Displays a favorite border icon
            color: _iconsColor(), // Sets icon color based on theme
          ),
        ),
      ),
    );
  }

  // Determines the icon color based on the current theme
  Color? _iconsColor() {
    final theme = NeumorphicTheme.of(context);
    if (theme!.isUsingDark) {
      return theme.current?.accentColor; // Uses accent color in dark theme
    } else {
      return null; // Uses default color in light theme
    }
  }
}

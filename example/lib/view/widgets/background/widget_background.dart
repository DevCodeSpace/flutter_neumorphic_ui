// Importing required packages and local widgets for UI components and theming
import 'package:example/view/widgets/theme/code.dart';
import 'package:example/view/widgets/theme/theme_configurator.dart';
import 'package:example/view/widgets/theme/top_bar.dart';
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Root widget for the Background demo page
class BackgroundWidgetPage extends StatefulWidget {
  // Constructor with optional key
  const BackgroundWidgetPage({super.key});

  @override
  createState() => _WidgetPageState();
}

// State class for applying the Neumorphic theme and wrapping the content page
class _WidgetPageState extends State<BackgroundWidgetPage> {
  @override
  Widget build(BuildContext context) {
    // Wraps the page with NeumorphicTheme for consistent styling
    return NeumorphicTheme(
      themeMode: ThemeMode.light, // Sets the theme to light mode
      theme: NeumorphicThemeData(
        lightSource:
            LightSource.topLeft, // Defines light source for neumorphic effect
        accentColor: NeumorphicColors.accent, // Sets accent color
        depth: 4, // Sets depth for neumorphic shadow
        intensity: 0.5, // Sets intensity of neumorphic effect
      ),
      child: _Page(), // Renders the main page content
    );
  }
}

// Container widget for the layout and UI of the Background page
class _Page extends StatefulWidget {
  @override
  createState() => _PageState();
}

// State class for managing the page's UI
class _PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    // Creates a neumorphic background with a scaffold for the page structure
    return NeumorphicBackground(
      padding: EdgeInsets.all(8), // Adds padding around the content
      child: Scaffold(
        appBar: TopBar(
          title: "Background", // Sets the title of the top bar
          actions: <Widget>[
            ThemeConfigurator(),
          ], // Adds theme configurator button to app bar
        ),
        backgroundColor:
            Colors.transparent, // Makes scaffold background transparent
        body: SingleChildScrollView(
          // Enables scrolling for the content
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Stretches children horizontally
            mainAxisAlignment:
                MainAxisAlignment.start, // Aligns children at the start
            mainAxisSize: MainAxisSize.max, // Maximizes column size
            children: [
              _DefaultWidget(), // Displays default background widget
              SizedBox(height: 30), // Adds spacing at the bottom
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------
// Default Background Section
// ---------------------------
// Stateful widget for the default background demonstration
class _DefaultWidget extends StatefulWidget {
  @override
  createState() => _DefaultWidgetState();
}

// State class for managing the default background widget
class _DefaultWidgetState extends State<_DefaultWidget> {
  // Builds the code snippet for the default background
  Widget _buildCode(BuildContext context) {
    return Code("""
// Takes the theme's baseColor as background
Expanded(
  child: NeumorphicBackground(
    child: ...
  ),
),
""");
  }

  // Builds the visual representation of the default background
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12), // Adds padding around the widget
      child: Row(
        children: <Widget>[
          Text(
            "Default\n(inside black)", // Label for the widget with line break
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12), // Spacing between elements
          Expanded(
            // Expands to fill available space
            child: Container(
              padding: EdgeInsets.all(8), // Adds padding inside the container
              color: Colors.black, // Sets black background for contrast
              child: NeumorphicBackground(
                // Applies neumorphic background with theme's base color
                child: const SizedBox(
                  width: 100,
                  height: 100,
                ), // Fixed size child
              ),
            ),
          ),
          SizedBox(width: 12), // Additional spacing
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Combines the widget and its code snippet
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[_buildWidget(context), _buildCode(context)],
    );
  }
}

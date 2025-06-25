// Importing required packages and local widgets for UI components and theming
import 'package:example/view/widgets/theme/code.dart';
import 'package:example/view/widgets/theme/theme_configurator.dart';
import 'package:example/view/widgets/theme/top_bar.dart';
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Root widget for the Recursive Emboss tips demo page
class TipsRecursiveeEmbossPage extends StatefulWidget {
  // Constructor with optional key
  const TipsRecursiveeEmbossPage({super.key});

  @override
  createState() => _WidgetPageState();
}

// State class for applying the Neumorphic theme and wrapping the content page
class _WidgetPageState extends State<TipsRecursiveeEmbossPage> {
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
        intensity: 0.6, // Sets intensity of neumorphic effect
      ),
      child: _Page(), // Renders the main page content
    );
  }
}

// Container widget for the layout and UI of the Recursive Emboss page
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
          title: "Emboss Recursive", // Sets the title of the top bar
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
              _EmbossmbossWidget(), // Displays the recursive emboss widget
              SizedBox(height: 30), // Adds spacing at the bottom
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------
// Recursive Emboss Widget Section
// ---------------------------------
// Stateful widget for the recursive emboss demonstration
class _EmbossmbossWidget extends StatefulWidget {
  @override
  createState() => _EmbossmbossWidgetState();
}

// State class for managing the recursive emboss widget
class _EmbossmbossWidgetState extends State<_EmbossmbossWidget> {
  // Builds the code snippet for the recursive emboss widget
  Widget _buildCode(BuildContext context) {
    return Code("""
 Widget _generateEmbosss({int number, Widget child, bool reverseEachPair = false}) {
    Widget element = child;
    for (int i = 0; i < number; ++i) {
      element = Neumorphic(
        padding: EdgeInsets.all(20),
        boxShape: NeumorphicBoxShape.circle(),
        style: NeumorphicStyle(
          depth: -(NeumorphicTheme.depth(context).abs()), //force negative
          oppositeShadowLightSource: (reverseEachPair && i % 2 == 0),
        ),
        child: element,
      );
    }
    return element;
  }
""");
  }

  // Generates a recursively embossed widget with specified number of layers
  Widget _generateEmboss({
    required int? number, // Number of recursive emboss layers
    required Widget? child, // Child widget at the center
    bool reverseEachPair =
        false, // Whether to reverse light source for each pair
  }) {
    Widget element = child!; // Initializes with the child widget
    for (int i = 0; i < number!; ++i) {
      // Wraps the element in a Neumorphic widget for each layer
      element = Neumorphic(
        padding: EdgeInsets.all(20), // Adds padding for each layer
        style: NeumorphicStyle(
          boxShape:
              NeumorphicBoxShape.circle(), // Circular shape for each layer
          depth: -(NeumorphicTheme.depth(
            context,
          )?.abs())!, // Forces negative depth for emboss effect
          oppositeShadowLightSource:
              (reverseEachPair &&
              i % 2 == 0), // Reverses light source for even pairs if enabled
        ),
        child: element, // Nests the previous element
      );
    }
    return element; // Returns the final nested widget
  }

  // Builds the visual representation of the recursive emboss widget
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12), // Adds padding around the widget
      child: Column(
        children: <Widget>[
          // First set of recursive emboss examples
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 100, // Fixed width for label alignment
                    margin: EdgeInsets.only(
                      left: 12,
                      right: 12,
                    ), // Adds margins for spacing
                    child: Text(
                      "Recursive Emboss", // Label for the widget
                      style: TextStyle(
                        color: NeumorphicTheme.defaultTextColor(
                          context,
                        ), // Default text color from theme
                      ),
                    ),
                  ),
                  // Generates 5 layers of recursive emboss
                  _generateEmboss(
                    number: 5,
                    child: SizedBox(
                      width: 10,
                      height: 10,
                    ), // Small central widget
                  ),
                ],
              ),
              SizedBox(height: 20), // Spacing between rows
              Row(
                children: <Widget>[
                  Container(
                    width: 100, // Fixed width for label alignment
                    margin: EdgeInsets.only(
                      left: 12,
                      right: 12,
                    ), // Adds margins for spacing
                    child: Text(
                      "Each pair number\nLightsource is reversed", // Label with line break
                      style: TextStyle(
                        color: NeumorphicTheme.defaultTextColor(
                          context,
                        ), // Default text color from theme
                      ),
                    ),
                  ),
                  // Generates 5 layers with reversed light source for each pair
                  _generateEmboss(
                    number: 5,
                    reverseEachPair:
                        true, // Reverses light source for even pairs
                    child: SizedBox(
                      width: 10,
                      height: 10,
                    ), // Small central widget
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20), // Spacing between sets
          // Second set of recursive emboss examples
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 100, // Fixed width for label alignment
                    margin: EdgeInsets.only(
                      left: 12,
                      right: 12,
                    ), // Adds margins for spacing
                    child: Text(
                      "Recursive Emboss", // Label for the widget
                      style: TextStyle(
                        color: NeumorphicTheme.defaultTextColor(
                          context,
                        ), // Default text color from theme
                      ),
                    ),
                  ),
                  // Generates 4 layers of recursive emboss
                  _generateEmboss(
                    number: 4,
                    child: SizedBox(
                      width: 10,
                      height: 10,
                    ), // Small central widget
                  ),
                ],
              ),
              SizedBox(height: 20), // Spacing between rows
              Row(
                children: <Widget>[
                  Container(
                    width: 100, // Fixed width for label alignment
                    margin: EdgeInsets.only(
                      left: 12,
                      right: 12,
                    ), // Adds margins for spacing
                    child: Text(
                      "Each pair number\nLightsource is reversed", // Label with line break
                      style: TextStyle(
                        color: NeumorphicTheme.defaultTextColor(
                          context,
                        ), // Default text color from theme
                      ),
                    ),
                  ),
                  // Generates 4 layers with reversed light source for each pair
                  _generateEmboss(
                    number: 4,
                    reverseEachPair:
                        true, // Reverses light source for even pairs
                    child: SizedBox(
                      width: 10,
                      height: 10,
                    ), // Small central widget
                  ),
                ],
              ),
            ],
          ),
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

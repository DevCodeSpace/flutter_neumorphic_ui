// Importing required packages and local widgets for UI components and theming
import 'package:example/view/widgets/theme/code.dart';
import 'package:example/view/widgets/theme/theme_configurator.dart';
import 'package:example/view/widgets/theme/top_bar.dart';
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Root widget for the Border Tips demo page
class TipsBorderPage extends StatefulWidget {
  // Constructor with optional key
  const TipsBorderPage({super.key});

  @override
  createState() => _WidgetPageState();
}

// State class for applying the Neumorphic theme and wrapping the content page
class _WidgetPageState extends State<TipsBorderPage> {
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

// Container widget for the layout and UI of the Border Tips page
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
          title: "Border", // Sets the title of the top bar
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
              // Demonstrates emboss inside flat shape
              _CustomWidget(
                title: "Emboss Inside Flat",
                firstStyle: NeumorphicStyle(
                  shape: NeumorphicShape.flat, // Flat outer shape
                  depth: 8, // Positive depth for outer shape
                ),
                secondStyle: NeumorphicStyle(
                  depth: -8,
                ), // Negative depth for inner emboss
              ),
              // Demonstrates emboss inside convex shape
              _CustomWidget(
                title: "Emboss Inside Convex",
                firstStyle: NeumorphicStyle(
                  shape: NeumorphicShape.convex, // Convex outer shape
                  depth: 8, // Positive depth for outer shape
                ),
                secondStyle: NeumorphicStyle(
                  depth: -8,
                ), // Negative depth for inner emboss
              ),
              // Demonstrates emboss inside concave shape
              _CustomWidget(
                title: "Emboss Inside Concave",
                firstStyle: NeumorphicStyle(
                  shape: NeumorphicShape.concave, // Concave outer shape
                  depth: 8, // Positive depth for outer shape
                ),
                secondStyle: NeumorphicStyle(
                  depth: -8,
                ), // Negative depth for inner emboss
              ),
              // Demonstrates flat inside emboss shape
              _CustomWidget(
                title: "Flat Inside Emboss",
                firstStyle: NeumorphicStyle(
                  depth: -8,
                ), // Negative depth for outer emboss
                secondStyle: NeumorphicStyle(
                  depth: 8, // Positive depth for inner shape
                  shape: NeumorphicShape.flat, // Flat inner shape
                ),
              ),
              // Demonstrates convex inside emboss shape
              _CustomWidget(
                title: "Convex Inside Emboss",
                firstStyle: NeumorphicStyle(
                  depth: -8,
                ), // Negative depth for outer emboss
                secondStyle: NeumorphicStyle(
                  depth: 8, // Positive depth for inner shape
                  shape: NeumorphicShape.convex, // Convex inner shape
                ),
              ),
              // Demonstrates concave inside emboss shape
              _CustomWidget(
                title: "Concave Inside Emboss",
                firstStyle: NeumorphicStyle(
                  depth: -8,
                ), // Negative depth for outer emboss
                secondStyle: NeumorphicStyle(
                  depth: 8, // Positive depth for inner shape
                  shape: NeumorphicShape.concave, // Concave inner shape
                ),
              ),
              // Demonstrates concave inside convex shape
              _CustomWidget(
                title: "Concave Inside Convex",
                firstStyle: NeumorphicStyle(
                  depth: 8, // Positive depth for outer shape
                  shape: NeumorphicShape.convex, // Convex outer shape
                ),
                secondStyle: NeumorphicStyle(
                  depth: 8, // Positive depth for inner shape
                  shape: NeumorphicShape.concave, // Concave inner shape
                ),
              ),
              // Demonstrates convex inside concave shape
              _CustomWidget(
                title: "Convex Inside Concave",
                firstStyle: NeumorphicStyle(
                  depth: 8, // Positive depth for outer shape
                  shape: NeumorphicShape.concave, // Concave outer shape
                ),
                secondStyle: NeumorphicStyle(
                  depth: 8, // Positive depth for inner shape
                  shape: NeumorphicShape.convex, // Convex inner shape
                ),
              ),
              SizedBox(height: 30), // Adds spacing at the bottom
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------------
// Custom Widget Section
// -------------------------
// Stateful widget for demonstrating custom border combinations
class _CustomWidget extends StatefulWidget {
  final String title; // Title for the widget
  final NeumorphicStyle firstStyle; // Style for the outer Neumorphic widget
  final NeumorphicStyle secondStyle; // Style for the inner Neumorphic widget

  // Constructor with required parameters
  const _CustomWidget({
    required this.title,
    required this.firstStyle,
    required this.secondStyle,
  });

  @override
  createState() => _CustomWidgetState();
}

// State class for managing the custom border widget
class _CustomWidgetState extends State<_CustomWidget> {
  // Generates a string description of a NeumorphicStyle for code display
  String _describe(NeumorphicStyle style) {
    return "NeumorphicStyle(depth: ${style.depth}, oppositeShadowLightSource: ${style.oppositeShadowLightSource}, ...)";
  }

  // Builds the code snippet for the custom border widget
  Widget _buildCode(BuildContext context) {
    return Code("""
Neumorphic(
      padding: EdgeInsets.all(20),
      boxShape: NeumorphicBoxShape.circle(),
      style: ${_describe(widget.firstStyle)},
      child: Neumorphic(
          boxShape: NeumorphicBoxShape.circle(),
          style: ${_describe(widget.secondStyle)},
          child: SizedBox(
            height: 100,
            width: 100,
          ),
      ),
    ),
""");
  }

  // Builds the visual representation of the custom border widget
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12), // Adds padding around the widget
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Centers children horizontally
        mainAxisAlignment:
            MainAxisAlignment.center, // Centers children vertically
        children: <Widget>[
          // First row: Default light source
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  left: 12,
                  right: 12,
                ), // Adds margins for spacing
                width: 100, // Fixed width for label alignment
                child: Text(
                  widget.title, // Displays the widget title
                  style: TextStyle(
                    color: NeumorphicTheme.defaultTextColor(
                      context,
                    ), // Default text color from theme
                  ),
                ),
              ),
              Neumorphic(
                padding: EdgeInsets.all(
                  20,
                ), // Adds padding for the outer widget
                style: widget.firstStyle.copyWith(
                  boxShape:
                      NeumorphicBoxShape.circle(), // Circular shape for outer widget
                ),
                child: Neumorphic(
                  style: widget.secondStyle.copyWith(
                    boxShape:
                        NeumorphicBoxShape.circle(), // Circular shape for inner widget
                  ),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                  ), // Fixed size inner child
                ),
              ),
              SizedBox(width: 12), // Additional spacing
            ],
          ),
          SizedBox(height: 12), // Spacing between rows
          // Second row: Opposite light source for inner widget
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  left: 12,
                  right: 12,
                ), // Adds margins for spacing
                width: 100, // Fixed width for label alignment
                child: Text(
                  "opposite\nchild\nlightsource", // Label with line breaks
                  style: TextStyle(
                    color: NeumorphicTheme.defaultTextColor(
                      context,
                    ), // Default text color from theme
                  ),
                ),
              ),
              Neumorphic(
                padding: EdgeInsets.all(
                  20,
                ), // Adds padding for the outer widget
                style: widget.firstStyle.copyWith(
                  boxShape:
                      NeumorphicBoxShape.circle(), // Circular shape for outer widget
                ),
                child: Neumorphic(
                  style: widget.secondStyle.copyWith(
                    boxShape:
                        NeumorphicBoxShape.circle(), // Circular shape for inner widget
                    oppositeShadowLightSource:
                        true, // Reverses light source for inner widget
                  ),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                  ), // Fixed size inner child
                ),
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

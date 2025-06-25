// Imports necessary packages for the widget page, including Neumorphic for UI design
import 'package:example/view/widgets/theme/code.dart';
import 'package:example/view/widgets/theme/color_selector.dart';
import 'package:example/view/widgets/theme/theme_configurator.dart';
import 'package:example/view/widgets/theme/top_bar.dart';
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Defines a stateful widget for the container widget page
class ContainerWidgetPage extends StatefulWidget {
  // Constructor with optional key
  const ContainerWidgetPage({super.key});

  @override
  createState() => _WidgetPageState();
}

// State class for ContainerWidgetPage
class _WidgetPageState extends State<ContainerWidgetPage> {
  @override
  Widget build(BuildContext context) {
    // Wraps the page with NeumorphicTheme for consistent styling
    return NeumorphicTheme(
      themeMode: ThemeMode.light, // Sets the theme to light mode
      theme: NeumorphicThemeData(
        lightSource:
            LightSource.topLeft, // Sets light source for neumorphic effect
        accentColor: NeumorphicColors.accent, // Defines accent color
        depth: 8, // Sets depth for neumorphic shadow
        intensity: 0.5, // Sets intensity of neumorphic effect
      ),
      child: _Page(), // Renders the main page content
    );
  }
}

// Internal stateful widget for the page content
class _Page extends StatefulWidget {
  @override
  createState() => _PageState();
}

// State class for _Page
class _PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    // Creates a neumorphic background with a scaffold for the page structure
    return NeumorphicBackground(
      padding: EdgeInsets.all(8), // Adds padding around the content
      child: Scaffold(
        appBar: TopBar(
          title: "Container", // Sets the title of the top bar
          actions: <Widget>[
            ThemeConfigurator(),
          ], // Adds theme configurator to app bar
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
              _DefaultWidget(), // Default neumorphic widget
              _CircleWidget(), // Circular neumorphic widget
              _RoundRectWidget(), // Rounded rectangle neumorphic widget
              _ColorizableWidget(), // Color customizable neumorphic widget
              _FlatConcaveConvexWidget(), // Widget showing flat, concave, and convex shapes
              _EmbossWidget(), // Embossed neumorphic widget
              _DrawAboveWidget(), // Widget demonstrating drawSurfaceAboveChild
              SizedBox(height: 30), // Adds spacing at the bottom
            ],
          ),
        ),
      ),
    );
  }
}

// Stateful widget for the default neumorphic container
class _DefaultWidget extends StatefulWidget {
  @override
  createState() => _DefaultWidgetState();
}

// State class for _DefaultWidget
class _DefaultWidgetState extends State<_DefaultWidget> {
  // Builds the code snippet for the default widget
  Widget _buildCode(BuildContext context) {
    return Code("""
Neumorphic(
    child: SizedBox(
        height: 100,
        width: 100,
    ),
),
""");
  }

  // Builds the visual representation of the default widget
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12), // Adds padding around the widget
      child: Row(
        children: <Widget>[
          Text(
            "Default", // Label for the widget
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12), // Spacing between elements
          Neumorphic(
            child: SizedBox(height: 100, width: 100),
          ), // Default neumorphic container
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

// Stateful widget for the circular neumorphic container
class _CircleWidget extends StatefulWidget {
  @override
  createState() => _CircleWidgetState();
}

// State class for _CircleWidget
class _CircleWidgetState extends State<_CircleWidget> {
  // Builds the code snippet for the circular widget
  Widget _buildCode(BuildContext context) {
    return Code("""
Neumorphic(
     boxShape: NeumorphicBoxShape.circle(),
     padding: EdgeInsets.all(18.0),
     child: Icon(Icons.map),
),
""");
  }

  // Builds the visual representation of the circular widget
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12), // Adds padding around the widget
      child: Row(
        children: <Widget>[
          Text(
            "Circle", // Label for the widget
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12), // Spacing between elements
          Neumorphic(
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.circle(),
            ), // Circular shape
            padding: EdgeInsets.all(18.0), // Internal padding
            child: Icon(Icons.map), // Icon inside the widget
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

// Stateful widget for the rounded rectangle neumorphic container
class _RoundRectWidget extends StatefulWidget {
  @override
  createState() => _RoundRectWidgetState();
}

// State class for _RoundRectWidget
class _RoundRectWidgetState extends State<_RoundRectWidget> {
  // Builds the code snippet for the rounded rectangle widget
  Widget _buildCode(BuildContext context) {
    return Code("""
Neumorphic(
    style: NeumorphicStyle(
         boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
    ),
    padding: EdgeInsets.all(18.0),
    child: Icon(Icons.map),
),
""");
  }

  // Builds the visual representation of the rounded rectangle widget
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12), // Adds padding around the widget
      child: Row(
        children: <Widget>[
          Text(
            "RoundRect", // Label for the widget
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12), // Spacing between elements
          Neumorphic(
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(8),
              ), // Rounded rectangle shape
            ),
            padding: EdgeInsets.all(18.0), // Internal padding
            child: Icon(Icons.map), // Icon inside the widget
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

// Stateful widget for the color customizable neumorphic container
class _ColorizableWidget extends StatefulWidget {
  @override
  createState() => _ColorizableWidgetState();
}

// State class for _ColorizableWidget
class _ColorizableWidgetState extends State<_ColorizableWidget> {
  Color currentColor = Colors.white; // Default color for the widget

  // Builds the code snippet for the colorizable widget
  Widget _buildCode(BuildContext context) {
    return Code("""
Neumorphic(
    style: NeumorphicStyle(
        color: Colors.white,
        boxShape: NeumorphicBoxShape.circle()
    ),
    child: SizedBox(
      height: 100, 
      width: 100,
    ),
),
""");
  }

  // Builds the visual representation of the colorizable widget
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12), // Adds padding around the widget
      child: Row(
        children: <Widget>[
          Text(
            "Color", // Label for the widget
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12), // Spacing between elements
          ColorSelector(
            color: currentColor, // Current selected color
            onColorChanged: (color) {
              setState(() {
                currentColor = color; // Updates color on change
              });
            },
          ),
          SizedBox(width: 12), // Additional spacing
          Neumorphic(
            style: NeumorphicStyle(
              color: currentColor, // Applies selected color
              boxShape: NeumorphicBoxShape.circle(), // Circular shape
            ),
            child: SizedBox(height: 100, width: 100), // Fixed size container
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

// Stateful widget for flat, concave, and convex neumorphic shapes
class _FlatConcaveConvexWidget extends StatefulWidget {
  @override
  createState() => _FlatConcaveConvexWidgetState();
}

// State class for _FlatConcaveConvexWidget
class _FlatConcaveConvexWidgetState extends State<_FlatConcaveConvexWidget> {
  bool isChecked = false; // Tracks checkbox state (not used in this code)

  // Builds the code snippet for flat, concave, and convex shapes
  Widget _buildCode(BuildContext context) {
    return Code("""
Neumorphic(
    style: NeumorphicStyle(
         shape: NeumorphicShape.flat 
         //or convex, concave
    ),
    
    child: ...
),
""");
  }

  // Builds the visual representation of flat, concave, and convex widgets
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12), // Adds padding around the widget
      child: Column(
        children: <Widget>[
          SizedBox(height: 12), // Spacing
          Row(
            children: <Widget>[
              SizedBox(
                width: 100,
                child: Text(
                  "Flat", // Label for flat shape
                  style: TextStyle(
                    color: NeumorphicTheme.defaultTextColor(context),
                  ),
                ),
              ),
              SizedBox(width: 12), // Spacing
              Neumorphic(
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat, // Flat shape
                  boxShape: NeumorphicBoxShape.circle(), // Circular shape
                ),
                padding: EdgeInsets.all(18.0), // Internal padding
                child: Icon(Icons.play_arrow), // Icon inside the widget
              ),
            ],
          ),
          SizedBox(height: 12), // Spacing
          Row(
            children: <Widget>[
              SizedBox(
                width: 100,
                child: Text(
                  "Concave", // Label for concave shape
                  style: TextStyle(
                    color: NeumorphicTheme.defaultTextColor(context),
                  ),
                ),
              ),
              SizedBox(width: 12), // Spacing
              Neumorphic(
                style: NeumorphicStyle(
                  shape: NeumorphicShape.concave, // Concave shape
                  boxShape: NeumorphicBoxShape.circle(), // Circular shape
                ),
                padding: EdgeInsets.all(18.0), // Internal padding
                child: Icon(Icons.play_arrow), // Icon inside the widget
              ),
            ],
          ),
          SizedBox(height: 12), // Spacing
          Row(
            children: <Widget>[
              SizedBox(
                width: 100,
                child: Text(
                  "Convex", // Label for convex shape
                  style: TextStyle(
                    color: NeumorphicTheme.defaultTextColor(context),
                  ),
                ),
              ),
              SizedBox(width: 12), // Spacing
              NeumorphicButton(
                style: NeumorphicStyle(
                  shape: NeumorphicShape.convex, // Convex shape
                  boxShape: NeumorphicBoxShape.circle(), // Circular shape
                ),
                padding: EdgeInsets.all(18.0), // Internal padding
                child: Icon(Icons.play_arrow), // Icon inside the widget
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

// Stateful widget for the embossed neumorphic container
class _EmbossWidget extends StatefulWidget {
  @override
  createState() => _EmbossWidgetState();
}

// State class for _EmbossWidget
class _EmbossWidgetState extends State<_EmbossWidget> {
  // Builds the code snippet for the embossed widget
  Widget _buildCode(BuildContext context) {
    return Code("""
Neumorphic(
    child: Icon(Icons.play_arrow),
    style: NeumorphicStyle(
      depth: -10.0,
    ),
),
""");
  }

  // Builds the visual representation of the embossed widget
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12), // Adds padding around the widget
      child: Column(
        children: <Widget>[
          SizedBox(height: 12), // Spacing
          Row(
            children: <Widget>[
              Text(
                "Emboss", // Label for the widget
                style: TextStyle(
                  color: NeumorphicTheme.defaultTextColor(context),
                ),
              ),
              SizedBox(width: 12), // Spacing
              Neumorphic(
                padding: EdgeInsets.all(18), // Internal padding
                style: NeumorphicStyle(
                  depth: -10.0,
                ), // Negative depth for emboss effect
                child: Icon(Icons.play_arrow), // Icon inside the widget
              ),
              SizedBox(width: 12), // Spacing
              Neumorphic(
                padding: EdgeInsets.all(18), // Internal padding
                style: NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.circle(), // Circular shape
                  depth: -10.0, // Negative depth for emboss effect
                ),
                child: Icon(Icons.play_arrow), // Icon inside the widget
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

// Stateful widget for demonstrating drawSurfaceAboveChild property
class _DrawAboveWidget extends StatefulWidget {
  @override
  createState() => _DrawAboveWidgetState();
}

// State class for _DrawAboveWidget
class _DrawAboveWidgetState extends State<_DrawAboveWidget> {
  // Builds the code snippet for the drawSurfaceAboveChild widget
  Widget _buildCode(BuildContext context) {
    return Code("""
Neumorphic(
    child: ...,
    drawSurfaceAboveChild: true,
    style: NeumorphicStyle(
        surfaceIntensity: 1,
        shape: NeumorphicShape.concave,
    ),
),
""");
  }

  // Builds the visual representation of the drawSurfaceAboveChild widget
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12), // Adds padding around the widget
      child: Column(
        children: <Widget>[
          SizedBox(height: 12), // Spacing
          Text(
            "DrawAbove", // Label for the widget
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(height: 12), // Spacing
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(8), // Margin around the label
                width: 100,
                child: Center(child: Text("false")), // Label for false state
              ),
              SizedBox(width: 12), // Spacing
              Container(
                margin: EdgeInsets.all(8), // Margin around the label
                width: 100,
                child: Center(
                  child: Text("true\n(concave)"),
                ), // Label for true concave state
              ),
              SizedBox(width: 12), // Spacing
              Container(
                margin: EdgeInsets.all(8), // Margin around the label
                width: 100,
                child: Center(
                  child: Text("true\n(convex)"),
                ), // Label for true convex state
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Neumorphic(
                drawSurfaceAboveChild: false, // Surface drawn below child
                margin: EdgeInsets.all(8), // Margin around the widget
                style: NeumorphicStyle(
                  surfaceIntensity: 1, // Surface intensity
                  shape: NeumorphicShape.concave, // Concave shape
                ),
                child: Image.asset(
                  "assets/images/weeknd.jpg", // Image asset
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover, // Image fit
                ),
              ),
              SizedBox(width: 12), // Spacing
              Neumorphic(
                drawSurfaceAboveChild: true, // Surface drawn above child
                margin: EdgeInsets.all(8), // Margin around the widget
                style: NeumorphicStyle(
                  surfaceIntensity: 1, // Surface intensity
                  shape: NeumorphicShape.concave, // Concave shape
                ),
                child: Image.asset(
                  "assets/images/weeknd.jpg", // Image asset
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover, // Image fit
                ),
              ),
              SizedBox(width: 12), // Spacing
              Neumorphic(
                drawSurfaceAboveChild: true, // Surface drawn above child
                margin: EdgeInsets.all(8), // Margin around the widget
                style: NeumorphicStyle(
                  intensity: 1, // Intensity for effect
                  shape: NeumorphicShape.convex, // Convex shape
                ),
                child: Image.asset(
                  "assets/images/weeknd.jpg", // Image asset
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover, // Image fit
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Neumorphic(
                drawSurfaceAboveChild: false, // Surface drawn below child
                margin: EdgeInsets.all(8), // Margin around the widget
                style: NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.circle(), // Circular shape
                  surfaceIntensity: 1, // Surface intensity
                  shape: NeumorphicShape.concave, // Concave shape
                ),
                child: Image.asset(
                  "assets/images/weeknd.jpg", // Image asset
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover, // Image fit
                ),
              ),
              SizedBox(width: 12), // Spacing
              Neumorphic(
                drawSurfaceAboveChild: true, // Surface drawn above child
                margin: EdgeInsets.all(8), // Margin around the widget
                style: NeumorphicStyle(
                  surfaceIntensity: 1, // Surface intensity
                  boxShape: NeumorphicBoxShape.circle(), // Circular shape
                  shape: NeumorphicShape.concave, // Concave shape
                ),
                child: Image.asset(
                  "assets/images/weeknd.jpg", // Image asset
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover, // Image fit
                ),
              ),
              SizedBox(width: 12), // Spacing
              Neumorphic(
                drawSurfaceAboveChild: true, // Surface drawn above child
                margin: EdgeInsets.all(8), // Margin around the widget
                style: NeumorphicStyle(
                  surfaceIntensity: 1, // Surface intensity
                  boxShape: NeumorphicBoxShape.circle(), // Circular shape
                  shape: NeumorphicShape.convex, // Convex shape
                ),
                child: Image.asset(
                  "assets/images/weeknd.jpg", // Image asset
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover, // Image fit
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

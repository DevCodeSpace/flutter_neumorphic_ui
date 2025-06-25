// Importing required packages and local widgets for UI components and theming
import 'package:example/view/widgets/theme/code.dart';
import 'package:example/view/widgets/theme/color_selector.dart';
import 'package:example/view/widgets/theme/theme_configurator.dart';
import 'package:example/view/widgets/theme/top_bar.dart';
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Root widget for the Button demo page
class ButtonWidgetPage extends StatefulWidget {
  // Constructor with optional key
  const ButtonWidgetPage({super.key});

  @override
  createState() => _WidgetPageState();
}

// State class for applying the Neumorphic theme and wrapping the actual content page
class _WidgetPageState extends State<ButtonWidgetPage> {
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

// Container widget for the layout and UI of the Button page
class _Page extends StatefulWidget {
  @override
  createState() => _PageState();
}

// State class for _Page to manage the page's UI
class _PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    // Creates a neumorphic background with a scaffold for the page structure
    return NeumorphicBackground(
      padding: EdgeInsets.all(8), // Adds padding around the content
      child: Scaffold(
        appBar: TopBar(
          title: "Button", // Sets the title of the top bar
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
              _DefaultWidget(), // Displays default button
              _CircleWidget(), // Displays circular button
              _ColorizableWidget(), // Displays color customizable button
              _MinDistanceWidget(), // Displays button with minimum distance effect
              _EnabledDisabledWidget(), // Displays enabled and disabled buttons
              _FlatConcaveConvexWidget(), // Displays buttons with flat, concave, and convex shapes
              _DurationWidget(), // Displays button with custom press duration
              SizedBox(height: 30), // Adds spacing at the bottom
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------
// Default Button Section
// -----------------------
// Stateful widget for the default button demonstration
class _DefaultWidget extends StatefulWidget {
  @override
  createState() => _DefaultWidgetState();
}

// State class for managing default button
class _DefaultWidgetState extends State<_DefaultWidget> {
  // Builds the code snippet for the default button
  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicButton(
     onPressed: () {
        
     },
     child: Text("Click me"),
),
""");
  }

  // Builds the visual representation of the default button
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
          NeumorphicButton(
            onPressed: () {
              setState(() {}); // Triggers rebuild on press
            },
            child: Text("Click me"), // Button text
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

// ----------------------
// Circle Button Section
// ----------------------
// Stateful widget for the circular button demonstration
class _CircleWidget extends StatefulWidget {
  @override
  createState() => _CircleWidgetState();
}

// State class for managing circular button
class _CircleWidgetState extends State<_CircleWidget> {
  // Builds the code snippet for the circular button
  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicButton(
     boxShape: NeumorphicBoxShape.circle(),
     onPressed: () {
       
     },
     padding: EdgeInsets.all(18.0),
     child: Icon(Icons.play_arrow),
),
""");
  }

  // Builds the visual representation of the circular button
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
          NeumorphicButton(
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.circle(),
            ), // Circular shape
            onPressed: () {
              setState(() {}); // Triggers rebuild on press
            },
            padding: EdgeInsets.all(18.0), // Internal padding
            child: Icon(Icons.play_arrow), // Icon inside the button
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

// ----------------------------
// MinDistance Button Section
// ----------------------------
// Stateful widget for the minimum distance button demonstration
class _MinDistanceWidget extends StatefulWidget {
  @override
  createState() => _MinDistanceWidgetState();
}

// State class for managing minimum distance button
class _MinDistanceWidgetState extends State<_MinDistanceWidget> {
  // Builds the code snippet for the minimum distance button
  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicButton(
     boxShape: NeumorphicBoxShape.circle(),
     minDistance: -5.0,
     onPressed: () {
       
     },
     padding: EdgeInsets.all(18.0),
     child: Icon(Icons.play_arrow),
),
""");
  }

  // Builds the visual representation of the minimum distance button
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12), // Adds padding around the widget
      child: Row(
        children: <Widget>[
          Text(
            "MinDistance -5", // Label for the widget
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12), // Spacing between elements
          NeumorphicButton(
            minDistance: -5.0, // Sets minimum distance for press effect
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.circle(),
            ), // Circular shape
            onPressed: () {
              setState(() {}); // Triggers rebuild on press
            },
            padding: EdgeInsets.all(18.0), // Internal padding
            child: Icon(Icons.play_arrow), // Icon inside the button
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

// ---------------------------
// Colorizable Button Section
// ---------------------------
// Stateful widget for the color customizable button demonstration
class _ColorizableWidget extends StatefulWidget {
  @override
  createState() => _ColorizableWidgetState();
}

// State class for managing colorizable button
class _ColorizableWidgetState extends State<_ColorizableWidget> {
  Color currentColor = Colors.green; // Default color for the button

  // Builds the code snippet for the colorizable button
  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicButton(
    onPressed: (){

    },
    style: NeumorphicStyle(
        color: Colors.green
    ),
    child: Text("Click me"),
),
""");
  }

  // Builds the visual representation of the colorizable button
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
          SizedBox(width: 12), // Spacing
          NeumorphicButton(
            onPressed: () {}, // Empty onPressed callback
            style: NeumorphicStyle(
              color: currentColor,
            ), // Applies selected color
            child: Text("Click me"), // Button text
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

// --------------------------------
// Enabled/Disabled Button Section
// --------------------------------
// Stateful widget for demonstrating enabled and disabled buttons
class _EnabledDisabledWidget extends StatefulWidget {
  @override
  createState() => _EnabledDisabledWidgetState();
}

// State class for managing enabled and disabled buttons
class _EnabledDisabledWidgetState extends State<_EnabledDisabledWidget> {
  // Builds the visual representation of enabled and disabled buttons
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12), // Adds padding around the widget
      child: Row(
        children: <Widget>[
          Text(
            "Enabled :", // Label for enabled button
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12), // Spacing
          NeumorphicButton(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 18,
            ), // Custom padding
            child: Text("First"), // Button text
            onPressed: () {
              setState(() {}); // Triggers rebuild on press
            },
          ),
          SizedBox(width: 24), // Wider spacing for visual separation
          Text(
            "Disabled :", // Label for disabled button
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12), // Spacing
          NeumorphicButton(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 18,
            ), // Custom padding
            child: Text("Second"), // Button text
            // No onPressed callback makes the button disabled by default
          ),
        ],
      ),
    );
  }

  // Builds the code snippet for a disabled button
  Widget _buildCode(BuildContext context) {
    return Code("""    
NeumorphicButton(
     isEnabled: false,
     child: Text("Second"),
     onPressed: () {
       
     },
),
""");
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

// -------------------------
// Duration Button Section
// -------------------------
// Stateful widget for demonstrating button with custom press duration
class _DurationWidget extends StatefulWidget {
  @override
  createState() => _DurationWidgetState();
}

// State class for managing duration button
class _DurationWidgetState extends State<_DurationWidget> {
  // Builds the code snippet for the duration button
  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicButton(
    onPressed: (){

    },
    child: Text("Press me all night long"),
    duration: Duration(seconds: 1),
),
""");
  }

  // Builds the visual representation of the duration button
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12), // Adds padding around the widget
      child: Column(
        children: <Widget>[
          SizedBox(height: 12), // Spacing
          Row(
            children: <Widget>[
              Text(
                "Duration", // Label for the widget
                style: TextStyle(
                  color: NeumorphicTheme.defaultTextColor(context),
                ),
              ),
              SizedBox(width: 12), // Spacing
              NeumorphicButton(
                onPressed: () {}, // Empty onPressed callback
                duration: Duration(
                  seconds: 1,
                ), // Sets custom press animation duration
                child: Text("Press me all night long"), // Button text
              ),
              SizedBox(width: 12), // Additional spacing
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

// ----------------------------------
// Flat/Concave/Convex Button Section
// ----------------------------------
// Stateful widget for demonstrating buttons with different shapes
class _FlatConcaveConvexWidget extends StatefulWidget {
  @override
  createState() => _FlatConcaveConvexWidgetState();
}

// State class for managing flat, concave, and convex buttons
class _FlatConcaveConvexWidgetState extends State<_FlatConcaveConvexWidget> {
  bool isChecked = false; // Unused variable, possibly for future functionality

  // Builds the code snippet for buttons with different shapes
  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicButton(
    style: NeumorphicStyle(
         shape: NeumorphicShape.flat 
         //or convex, concave
    ),
    onPressed: () {
        
    },
    child: ...
),
""");
  }

  // Builds the visual representation of flat, concave, and convex buttons
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12), // Adds padding around the widget
      child: Column(
        children: <Widget>[
          SizedBox(height: 12), // Spacing
          Row(
            children: <Widget>[
              SizedBox(
                width: 100, // Fixed width for label alignment
                child: Text(
                  "Flat", // Label for flat shape
                  style: TextStyle(
                    color: NeumorphicTheme.defaultTextColor(context),
                  ),
                ),
              ),
              SizedBox(width: 12), // Spacing
              NeumorphicButton(
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat, // Flat shape
                  boxShape: NeumorphicBoxShape.circle(), // Circular shape
                ),
                onPressed: () {
                  setState(() {}); // Triggers rebuild on press
                },
                padding: EdgeInsets.all(18.0), // Internal padding
                child: Icon(Icons.play_arrow), // Icon inside the button
              ),
            ],
          ),
          SizedBox(height: 12), // Spacing
          Row(
            children: <Widget>[
              SizedBox(
                width: 100, // Fixed width for label alignment
                child: Text(
                  "Concave", // Label for concave shape
                  style: TextStyle(
                    color: NeumorphicTheme.defaultTextColor(context),
                  ),
                ),
              ),
              SizedBox(width: 12), // Spacing
              NeumorphicButton(
                style: NeumorphicStyle(
                  shape: NeumorphicShape.concave, // Concave shape
                  boxShape: NeumorphicBoxShape.circle(), // Circular shape
                ),
                onPressed: () {
                  setState(() {}); // Triggers rebuild on press
                },
                padding: EdgeInsets.all(18.0), // Internal padding
                child: Icon(Icons.play_arrow), // Icon inside the button
              ),
            ],
          ),
          SizedBox(height: 12), // Spacing
          Row(
            children: <Widget>[
              SizedBox(
                width: 100, // Fixed width for label alignment
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
                onPressed: () {
                  setState(() {}); // Triggers rebuild on press
                },
                padding: EdgeInsets.all(18.0), // Internal padding
                child: Icon(Icons.play_arrow), // Icon inside the button
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

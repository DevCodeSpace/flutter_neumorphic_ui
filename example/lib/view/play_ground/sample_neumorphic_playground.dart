// ignore_for_file: unused_local_variable

// Importing the Neumorphic package for UI styling
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Root widget for the Neumorphic Playground demo page (commented out)
// class NeumorphicPlayground extends StatefulWidget {
//   const NeumorphicPlayground({super.key});

//   @override
//   State<NeumorphicPlayground> createState() => _NeumorphicPlaygroundState();
// }

// State class for applying the Neumorphic theme (commented out)
// class _NeumorphicPlaygroundState extends State<NeumorphicPlayground> {
//   @override
//   Widget build(BuildContext context) {
//     return NeumorphicApp(
//       debugShowCheckedModeBanner: false,
//       themeMode: ThemeMode.light, // Sets theme to light mode
//       theme: NeumorphicThemeData(
//         baseColor: Color(0xffDDDDDD), // Light grey base color
//         lightSource: LightSource.topLeft, // Light source from top-left
//         depth: 6, // Depth for neumorphic shadow
//         intensity: 0.5, // Intensity of neumorphic effect
//       ),
//       home: PlayGround(), // Renders the playground page
//     );
//   }
// }

// Main widget for the Neumorphic Playground page
class PlayGround extends StatefulWidget {
  const PlayGround({super.key});

  @override
  PlayGroundState createState() => PlayGroundState();
}

// State class for managing the playground's UI and state
class PlayGroundState extends State<PlayGround> {
  // Initial configuration for neumorphic properties
  LightSource lightSource = LightSource.topLeft; // Light source position
  NeumorphicShape shape = NeumorphicShape.flat; // Shape (flat, concave, convex)
  NeumorphicBoxShape boxShape = NeumorphicBoxShape.roundRect(
    BorderRadius.circular(12), // Rounded rectangle with 12px radius
  );

  double depth = 5; // Depth of neumorphic effect
  double intensity = 0.5; // Intensity of shadows
  double surfaceIntensity = 0.5; // Intensity of surface lighting
  double cornerRadius = 40; // Corner radius (not used in current UI)
  double height = 150.0; // Widget height
  double width = 150.0; // Widget width

  bool haveNeumorphicChild =
      false; // Whether to include a child neumorphic widget
  bool childOppositeLightsourceChild =
      false; // Whether child uses opposite light source
  bool drawAboveChild = false; // Whether to draw surface above child
  double childMargin = 5; // Margin for child widget
  double childDepth = 5; // Depth for child widget

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context), // Theme base color
      appBar: NeumorphicAppBar(title: Text('Playground')), // App bar with title
      body: Column(
        mainAxisSize: MainAxisSize.max, // Maximizes column height
        crossAxisAlignment:
            CrossAxisAlignment.stretch, // Stretches children horizontally
        children: <Widget>[
          // Preview area
          Flexible(
            flex: 1, // Takes half of available space
            child: Stack(
              fit: StackFit.expand, // Expands to fill space
              children: [
                lightSourceWidgets(), // Sliders for light source
                Center(child: neumorphic()), // Neumorphic widget preview
              ],
            ),
          ),
          // Configuration area
          Flexible(flex: 1, child: _configurators()), // Configurator widgets
        ],
      ),
    );
  }

  // Builds configurator widgets
  Widget _configurators() {
    // final Color buttonActiveColor = Theme.of(context).accentColor; // Commented out
    final Color buttonInnactiveColor = Colors.white; // Inactive button color
    final Color textActiveColor = Colors.white; // Active text color
    final Color textInactiveColor = Colors.black.withValues(
      alpha: 0.3,
    ); // Inactive text color

    return Column(children: <Widget>[styleCustomizer()]); // Style customizer
  }

  // Builds style customization widgets
  Widget styleCustomizer() {
    return Column(
      mainAxisSize: MainAxisSize.max, // Maximizes column height
      children: [
        depthSelector(), // Depth slider
        intensitySelector(), // Intensity slider
        surfaceIntensitySelector(), // Surface intensity slider
        shapeWidget(), // Shape selector buttons
      ],
    );
  }

  // Builds the main neumorphic widget for preview
  Widget neumorphic() {
    return NeumorphicButton(
      padding: EdgeInsets.zero, // No padding
      duration: Duration(milliseconds: 300), // Animation duration
      onPressed: () {
        setState(() {}); // Empty callback (triggers rebuild)
      },
      drawSurfaceAboveChild: drawAboveChild, // Surface drawing option
      style: NeumorphicStyle(
        boxShape: boxShape, // Box shape (rounded rectangle)
        shape: shape, // Neumorphic shape
        intensity: intensity, // Shadow intensity
        surfaceIntensity: surfaceIntensity, // Surface lighting intensity
        depth: depth, // Depth of effect
        lightSource: lightSource, // Light source position
      ),
      child: SizedBox(
        height: height, // Widget height
        width: width, // Widget width
        child: haveNeumorphicChild
            ? neumorphicChild() // Child widget if enabled
            : Center(child: Text("")), // Empty text otherwise
      ),
    );
  }

  // Builds the child neumorphic widget
  Widget neumorphicChild() {
    return Neumorphic(
      padding: EdgeInsets.zero, // No padding
      duration: Duration(milliseconds: 300), // Animation duration
      margin: EdgeInsets.all(childMargin), // Child margin
      drawSurfaceAboveChild: true, // Draws surface above child
      style: NeumorphicStyle(
        boxShape: boxShape, // Same box shape as parent
        intensity: intensity, // Same intensity as parent
        surfaceIntensity: surfaceIntensity, // Same surface intensity
        depth: childDepth, // Child depth
        lightSource: lightSource, // Same light source
        oppositeShadowLightSource:
            childOppositeLightsourceChild, // Opposite light source option
      ),
      child: SizedBox.expand(), // Expands to fill space
    );
  }

  // Builds the depth selector slider
  Widget depthSelector() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("Depth"), // Label
        ),
        Expanded(
          child: Slider(
            min: Neumorphic.minDepth, // Minimum depth
            max: Neumorphic.maxDepth, // Maximum depth
            value: depth, // Current depth
            onChanged: (value) {
              setState(() {
                depth = value; // Updates depth
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(depth.floor().toString()), // Displays depth value
        ),
      ],
    );
  }

  // Builds the intensity selector slider
  Widget intensitySelector() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("Intensity"), // Label
        ),
        Expanded(
          child: Slider(
            min: Neumorphic.minIntensity, // Minimum intensity
            max: Neumorphic.maxIntensity, // Maximum intensity
            value: intensity, // Current intensity
            onChanged: (value) {
              setState(() {
                intensity = value; // Updates intensity
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(
            ((intensity * 100).floor() / 100).toString(),
          ), // Displays intensity value
        ),
      ],
    );
  }

  // Builds the surface intensity selector slider
  Widget surfaceIntensitySelector() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("SurfaceIntensity"), // Label
        ),
        Expanded(
          child: Slider(
            min: Neumorphic.minIntensity, // Minimum surface intensity
            max: Neumorphic.maxIntensity, // Maximum surface intensity
            value: surfaceIntensity, // Current surface intensity
            onChanged: (value) {
              setState(() {
                surfaceIntensity = value; // Updates surface intensity
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(
            ((surfaceIntensity * 100).floor() / 100).toString(),
          ), // Displays surface intensity value
        ),
      ],
    );
  }

  // Builds the shape selector buttons
  Widget shapeWidget() {
    // final Color buttonActiveColor = Theme.of(context).accentColor; // Commented out
    final Color buttonInnactiveColor = Colors.white; // Inactive button color
    final Color iconActiveColor = Colors.white; // Active icon color
    final Color iconInactiveColor = Colors.black.withValues(
      alpha: 0.3,
    ); // Inactive icon color

    return Row(
      mainAxisSize: MainAxisSize.max, // Maximizes row width
      children: <Widget>[
        // Concave shape button
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0), // Padding
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  shape = NeumorphicShape.concave; // Sets concave shape
                });
              },
              child: Image.asset(
                "assets/images/concave.png", // Concave icon
                color: shape == NeumorphicShape.concave
                    ? iconActiveColor
                    : iconInactiveColor, // Icon color based on selection
              ),
            ),
          ),
        ),
        // Convex shape button
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0), // Padding
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  shape = NeumorphicShape.convex; // Sets convex shape
                });
              },
              child: Image.asset(
                "assets/images/convex.png", // Convex icon
                color: shape == NeumorphicShape.convex
                    ? iconActiveColor
                    : iconInactiveColor, // Icon color based on selection
              ),
            ),
          ),
        ),
        // Flat shape button
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0), // Padding
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  shape = NeumorphicShape.flat; // Sets flat shape
                });
              },
              child: Image.asset(
                "assets/images/flat.png", // Flat icon
                color: shape == NeumorphicShape.flat
                    ? iconActiveColor
                    : iconInactiveColor, // Icon color based on selection
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Builds sliders for adjusting light source position
  Widget lightSourceWidgets() {
    return Stack(
      children: <Widget>[
        // Horizontal slider for X-axis
        Positioned(
          left: 20,
          right: 20,
          child: Slider(
            min: -1, // Minimum X value
            max: 1, // Maximum X value
            value: lightSource.dx, // Current X value
            onChanged: (value) {
              setState(() {
                lightSource = lightSource.copyWith(
                  dx: value,
                ); // Updates X position
              });
            },
          ),
        ),
        // Vertical slider for Y-axis
        Positioned(
          left: 0,
          top: 20,
          bottom: 20,
          child: RotatedBox(
            quarterTurns: 1, // Rotates slider 90 degrees
            child: Slider(
              min: -1, // Minimum Y value
              max: 1, // Maximum Y value
              value: lightSource.dy, // Current Y value
              onChanged: (value) {
                setState(() {
                  lightSource = lightSource.copyWith(
                    dy: value,
                  ); // Updates Y position
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}

// ignore_for_file: unused_local_variable

// Importing required packages and local widgets for UI components
import 'package:example/view/widgets/theme/color_selector.dart';
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Root widget for the Neumorphic Playground demo page
class NeumorphicPlayground extends StatefulWidget {
  const NeumorphicPlayground({super.key});

  @override
  State<NeumorphicPlayground> createState() => _NeumorphicPlaygroundState();
}

// State class for applying the Neumorphic theme
class _NeumorphicPlaygroundState extends State<NeumorphicPlayground> {
  @override
  Widget build(BuildContext context) {
    // Wraps the page with NeumorphicTheme for consistent styling
    return NeumorphicTheme(
      themeMode: ThemeMode.light, // Sets theme to light mode
      theme: NeumorphicThemeData(
        baseColor: Color(0xffDDDDDD), // Light grey base color
        lightSource: LightSource.topLeft, // Light source from top-left
        depth: 6, // Depth for neumorphic shadow
        intensity: 0.5, // Intensity of neumorphic effect
      ),
      child: _Page(), // Renders the main page content
    );
  }
}

// Container widget for the layout and UI of the Playground page
class _Page extends StatefulWidget {
  @override
  __PageState createState() => __PageState();
}

// State class for managing the page's UI and state
class __PageState extends State<_Page> {
  // Initial configuration for neumorphic properties
  LightSource lightSource = LightSource.topLeft; // Light source position
  NeumorphicShape shape = NeumorphicShape.flat; // Shape (flat, concave, convex)
  late NeumorphicBoxShape boxShape; // Box shape (initialized in initState)
  double depth = 5; // Depth of neumorphic effect
  double intensity = 0.5; // Intensity of shadows
  double surfaceIntensity = 0.5; // Intensity of surface lighting
  double cornerRadius = 20; // Corner radius (not used in current UI)
  double height = 150.0; // Widget height
  double width = 150.0; // Widget width

  bool haveNeumorphicChild =
      false; // Whether to include a child neumorphic widget
  bool childOppositeLightsourceChild =
      false; // Whether child uses opposite light source
  bool drawAboveChild = false; // Whether to draw surface above child
  double childMargin = 5; // Margin for child widget
  double childDepth = 5; // Depth for child widget
  int selectedConfiguratorIndex =
      0; // Index for style/child configurator toggle

  @override
  void initState() {
    super.initState();
    // Initializes box shape with a custom Flutter logo path
    boxShape = NeumorphicBoxShape.path(NeumorphicFlutterLogoPathProvider());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context), // Theme base color
      body: SafeArea(
        // Ensures content avoids system UI areas
        child: Column(
          children: [
            _buildAppBar(context), // Custom app bar
            Expanded(
              child: Stack(
                children: [
                  lightSourceWidgets(), // Sliders for light source
                  Center(child: neumorphic()), // Neumorphic widget preview
                ],
              ),
            ),
            _buildBottomConfigurator(), // Bottom configurator panel
          ],
        ),
      ),
    );
  }

  // Builds the custom app bar
  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ), // Padding
      child: Row(
        children: [
          NeumorphicButton(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ), // Button padding
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat, // Flat shape
              boxShape:
                  NeumorphicBoxShape.stadium(), // Stadium shape (rounded ends)
              depth: 2, // Slight depth
              color: Colors.deepPurpleAccent, // Purple accent color
            ),
            child: const Text(
              "Back", // Button label
              style: TextStyle(
                color: Colors.white, // White text
                fontWeight: FontWeight.bold, // Bold text
              ),
            ),
            onPressed: () => Navigator.pop(context), // Navigates back
          ),
        ],
      ),
    );
  }

  // Builds the bottom configurator panel
  Widget _buildBottomConfigurator() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300], // Light grey background
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ), // Rounded top corners
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)], // Shadow
      ),
      padding: const EdgeInsets.only(top: 16, bottom: 32), // Padding
      child: Column(
        mainAxisSize: MainAxisSize.min, // Minimizes column height
        children: [
          // Toggle buttons for style/child configurators
          ToggleButtons(
            borderRadius: BorderRadius.circular(16), // Rounded corners
            selectedColor: Colors.white, // Selected text color
            fillColor: Colors.deepPurpleAccent, // Selected background color
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.5), // Unselected text color
            isSelected: List.generate(
              2,
              (index) => index == selectedConfiguratorIndex, // Selection state
            ),
            onPressed: (index) => setState(
              () => selectedConfiguratorIndex = index,
            ), // Updates selection
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("Style"), // Style tab
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("Child"), // Child tab
              ),
            ],
          ),
          const SizedBox(height: 16), // Spacing
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ), // Horizontal padding
            child:
                _configuratorsChild() ??
                const SizedBox(), // Configurator content
          ),
        ],
      ),
    );
  }

  // Returns the appropriate configurator based on selected index
  Widget? _configuratorsChild() {
    switch (selectedConfiguratorIndex) {
      case 0:
        return styleCustomizer(); // Style configurator
      case 1:
        return childCustomizer(); // Child configurator
      default:
        return const SizedBox(); // Empty widget
    }
  }

  // Builds the style configurator
  Widget styleCustomizer() {
    return Column(
      mainAxisSize: MainAxisSize.max, // Maximizes column height
      children: [
        depthSelector(), // Depth slider
        intensitySelector(), // Intensity slider
        surfaceIntensitySelector(), // Surface intensity slider
        colorPicker(), // Color selector
      ],
    );
  }

  // Builds the child configurator
  Widget childCustomizer() {
    return Column(
      mainAxisSize: MainAxisSize.max, // Maximizes column height
      children: <Widget>[
        hasChildSelector(), // Toggle for child widget
        drawAboveChildSelector(), // Toggle for drawing above child
        childDepthSelector(), // Child depth slider
        childMarginSelector(), // Child margin slider
        childOppositeLightsourceSelector(), // Toggle for opposite light source
      ],
    );
  }

  // Builds the color picker
  Widget colorPicker() {
    return Row(
      children: <Widget>[
        SizedBox(width: 12), // Spacing
        Text("Color "), // Label
        SizedBox(width: 4), // Spacing
        ColorSelector(
          onColorChanged: (color) {
            setState(() {
              // Updates theme base color
              NeumorphicTheme.of(
                context,
              )?.updateCurrentTheme(NeumorphicThemeData(baseColor: color));
            });
          },
          color: NeumorphicTheme.baseColor(context), // Current base color
        ),
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
        boxShape: boxShape, // Custom box shape (Flutter logo)
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
          child: Text("Depth"),
        ), // Label
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

  // Builds the child depth selector slider
  Widget childDepthSelector() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("Child Depth"),
        ), // Label
        Expanded(
          child: Slider(
            min: Neumorphic.minDepth, // Minimum depth
            max: Neumorphic.maxDepth, // Maximum depth
            value: childDepth, // Current child depth
            onChanged: (value) {
              setState(() {
                childDepth = value; // Updates child depth
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(
            childDepth.floor().toString(),
          ), // Displays child depth value
        ),
      ],
    );
  }

  // Builds the child margin selector slider
  Widget childMarginSelector() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("Child Margin"),
        ), // Label
        Expanded(
          child: Slider(
            min: 0, // Minimum margin
            max: 40, // Maximum margin
            value: childMargin, // Current child margin
            onChanged: (value) {
              setState(() {
                childMargin = value; // Updates child margin
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(
            childMargin.floor().toString(),
          ), // Displays child margin value
        ),
      ],
    );
  }

  // Builds the toggle for enabling/disabling child widget
  Widget hasChildSelector() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text("Has Child"), // Label
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Checkbox(
            value: haveNeumorphicChild, // Current state
            onChanged: (value) {
              setState(() {
                haveNeumorphicChild = value!; // Updates state
              });
            },
          ),
        ),
      ],
    );
  }

  // Builds the toggle for drawing above child
  Widget drawAboveChildSelector() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text("Draw above child"), // Label
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Checkbox(
            value: drawAboveChild, // Current state
            onChanged: (value) {
              setState(() {
                drawAboveChild = value!; // Updates state
              });
            },
          ),
        ),
      ],
    );
  }

  // Builds the toggle for opposite light source
  Widget childOppositeLightsourceSelector() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text("OppositeLight"), // Label
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Checkbox(
            value: childOppositeLightsourceChild, // Current state
            onChanged: (value) {
              setState(() {
                childOppositeLightsourceChild = value!; // Updates state
              });
            },
          ),
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
          child: Text("Intensity"),
        ), // Label
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
          child: Text("SurfaceIntensity"),
        ), // Label
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

  // Builds sliders for adjusting light source position
  Widget lightSourceWidgets() {
    return Stack(
      children: <Widget>[
        // Horizontal slider for X-axis
        Positioned(
          left: 10,
          right: 10,
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
          top: 10,
          bottom: 10,
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

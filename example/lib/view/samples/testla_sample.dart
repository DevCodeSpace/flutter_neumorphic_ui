// Importing the Neumorphic package for UI styling
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Root widget for the Tesla Sample demo page
class TeslaSample extends StatefulWidget {
  // Constructor with optional key
  const TeslaSample({super.key});

  @override
  createState() => _TeslaSampleState();
}

// State class for applying the Neumorphic theme and wrapping the content page
class _TeslaSampleState extends State<TeslaSample> {
  @override
  Widget build(BuildContext context) {
    // Wraps the page with NeumorphicTheme for consistent styling
    return NeumorphicTheme(
      theme: NeumorphicThemeData(
        baseColor: Color(0xFF30353B), // Sets base color (dark grey)
        intensity: 0.3, // Sets intensity of neumorphic effect
        accentColor: Color(0xFF0F95E6), // Sets accent color (blue)
        lightSource:
            LightSource.topLeft, // Defines light source for neumorphic effect
        depth: 2, // Sets depth for neumorphic shadow
      ),
      child: Scaffold(
        body: SafeArea(
          // Ensures content avoids system UI areas
          child: NeumorphicBackground(
            // Applies neumorphic background
            child: _PageContent(), // Renders the main page content
          ),
        ),
      ),
    );
  }
}

// Container widget for the layout and UI of the Tesla Sample page
class _PageContent extends StatefulWidget {
  @override
  __PageContentState createState() => __PageContentState();
}

// State class for managing the page's UI
class __PageContentState extends State<_PageContent> {
  @override
  Widget build(BuildContext context) {
    // Builds a container with a gradient background and column layout
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF373C43),
            Color(0xFF17181C),
          ], // Gradient from dark grey to black
          begin: Alignment.topCenter, // Gradient starts at top
          end: Alignment.bottomCenter, // Gradient ends at bottom
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max, // Maximizes column size
        children: <Widget>[
          _buildTopBar(context), // Top bar with back and settings buttons
          Expanded(flex: 2, child: _buildTitle(context)), // Title section
          Expanded(
            flex: 5,
            child: _buildCenterContent(context),
          ), // Center content with range and image
          _buildBottomAction(context), // Bottom action with lock button
        ],
      ),
    );
  }

  // Builds the top bar with back and settings buttons
  Widget _buildTopBar(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Back button aligned to the left
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ), // Adds padding
            child: _bumpButton(
              Icon(Icons.arrow_back, color: Colors.grey),
            ), // Back button
          ),
        ),
        // Settings button aligned to the right
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ), // Adds padding
            child: _bumpButton(
              Icon(Icons.settings, color: Colors.grey),
            ), // Settings button
          ),
        ),
      ],
    );
  }

  // Builds a neumorphic bump button with a nested button effect
  Widget _bumpButton(Widget child) {
    return Neumorphic(
      drawSurfaceAboveChild: false, // Prevents surface drawing above child
      style: NeumorphicStyle(
        color: Color(0xFF2D3238), // Dark grey background
        depth: 8, // Depth for outer neumorphic effect
        boxShape: NeumorphicBoxShape.circle(), // Circular shape
        intensity: 0.3, // Intensity of outer effect
        shape: NeumorphicShape.concave, // Concave shape for outer effect
      ),
      child: NeumorphicButton(
        onPressed: () {}, // Empty callback
        margin: EdgeInsets.all(3), // Margin around inner button
        padding: EdgeInsets.all(14.0), // Padding inside inner button
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.circle(), // Circular shape
          color: Color(0xFF212528), // Darker grey for inner button
          depth: 0, // No depth for inner button
          shape: NeumorphicShape.convex, // Convex shape for inner button
        ),
        child: child, // Child widget (icon)
      ),
    );
  }

  // Builds the title section with "Tesla" and "CyberTruck"
  Widget _buildTitle(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "Tesla", // Brand name
          style: TextStyle(color: Colors.white30), // Light grey text
        ),
        Text(
          "CyberTruck", // Model name
          style: TextStyle(
            fontSize: 30, // Large font size
            fontWeight: FontWeight.w800, // Bold font weight
            color: Colors.white, // White text
          ),
        ),
      ],
    );
  }

  // Builds the center content with range display and Tesla image
  Widget _buildCenterContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Range display (297 km)
        Row(
          mainAxisSize: MainAxisSize.max, // Maximizes row size
          mainAxisAlignment: MainAxisAlignment.center, // Centers content
          crossAxisAlignment: CrossAxisAlignment.start, // Aligns at top
          children: <Widget>[
            Text(
              "297", // Range value
              style: TextStyle(
                color: Colors.white, // White text
                fontSize: 120, // Large font size
                fontWeight: FontWeight.w200, // Light font weight
              ),
            ),
            Text(
              "km", // Unit
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ), // Small white text
            ),
          ],
        ),
        // Tesla CyberTruck image
        Positioned(
          right: 0, // Aligns to the right
          child: SizedBox(
            height: 280, // Fixed height for image
            child: Padding(
              padding: EdgeInsets.only(top: 35), // Adds top padding
              child: Image.asset(
                "assets/images/tesla_cropped.png", // Tesla image asset
                fit: BoxFit.contain, // Scales image to fit within bounds
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Builds the bottom action section with A/C status and lock button
  Widget _buildBottomAction(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 18), // Adds bottom padding
      child: Column(
        children: <Widget>[
          Text(
            "A/C is turned on", // Status text
            style: TextStyle(color: Colors.white30), // Light grey text
          ),
          SizedBox(height: 20), // Spacing
          // Lock button
          NeumorphicButton(
            drawSurfaceAboveChild:
                false, // Prevents surface drawing above child
            onPressed: () {}, // Empty callback
            padding: EdgeInsets.all(4), // Small padding
            style: NeumorphicStyle(
              depth: 10, // Depth for outer button
              boxShape: NeumorphicBoxShape.circle(), // Circular shape
              color: NeumorphicTheme.accentColor(
                context,
              ), // Uses accent color (blue)
              shape: NeumorphicShape.flat, // Flat shape
            ),
            child: Neumorphic(
              style: NeumorphicStyle(
                surfaceIntensity: 0.7, // Surface intensity for inner effect
                depth: 0, // No depth for inner effect
                boxShape: NeumorphicBoxShape.circle(), // Circular shape
                shape:
                    NeumorphicShape.concave, // Concave shape for inner effect
                color: NeumorphicTheme.accentColor(
                  context,
                ), // Uses accent color (blue)
              ),
              child: SizedBox(
                height: 80, // Fixed height
                width: 80, // Fixed width
                child: Icon(
                  Icons.lock,
                  size: 30,
                  color: Colors.white,
                ), // Lock icon
              ),
            ),
          ),
          SizedBox(height: 20), // Spacing
          Text(
            "Tap to open the car", // Instruction text
            style: TextStyle(color: Colors.white), // White text
          ),
        ],
      ),
    );
  }
}

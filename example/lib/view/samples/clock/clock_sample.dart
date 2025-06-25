// Importing required packages and local widgets for UI components
import 'package:example/view/widgets/theme/top_bar.dart';
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

import 'clock_second_sample.dart';

// Root widget for the Clock sample demo page
class ClockSample extends StatelessWidget {
  // Constructor with optional key
  const ClockSample({super.key});

  @override
  Widget build(BuildContext context) {
    // Wraps the page with NeumorphicTheme for consistent styling
    return NeumorphicTheme(
      theme: NeumorphicThemeData(
        defaultTextColor: Color(0xFF303E57), // Dark blue-grey text color
        accentColor: Color(0xFF7B79FC), // Purple accent color
        variantColor: Colors.black38, // Semi-transparent black variant color
        baseColor: Color(0xFFF8F9FC), // Light grey base color
        depth: 8, // Depth for neumorphic shadow
        intensity: 0.5, // Intensity of neumorphic effect
        lightSource: LightSource.topLeft, // Light source from top-left
      ),
      themeMode: ThemeMode.light, // Sets theme to light mode
      child: Material(
        child: NeumorphicBackground(
          // Applies neumorphic background
          child: _ClockFirstPage(), // Renders the main page content
        ),
      ),
    );
  }
}

// Container widget for the layout and UI of the Clock sample page
class _ClockFirstPage extends StatefulWidget {
  @override
  _ClockFirstPageState createState() => _ClockFirstPageState();
}

// State class for managing the page's UI and state
class _ClockFirstPageState extends State<_ClockFirstPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Ensures content avoids system UI areas
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Centers content horizontally
        children: <Widget>[
          // Top bar
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              top: 9.0,
            ), // Padding for top bar
            child: TopBar(), // Custom top bar widget
          ),
          // Header with title and add alarm button
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
            ), // Horizontal padding
            child: Stack(
              children: <Widget>[
                // Clock title
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Clock", // Page title
                    style: TextStyle(
                      fontWeight: FontWeight.w700, // Bold text
                      fontSize: 28, // Large font size
                      shadows: [
                        Shadow(
                          color: Colors.black38, // Shadow color
                          offset: Offset(1.0, 1.0), // Shadow offset
                          blurRadius: 2, // Shadow blur
                        ),
                      ],
                      color: NeumorphicTheme.defaultTextColor(
                        context,
                      ), // Theme text color
                    ),
                  ),
                ),
                // Add alarm button
                Align(
                  alignment: Alignment.topRight,
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      depth: 20, // High depth for pronounced effect
                      intensity: 0.4, // Intensity of neumorphic effect
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(8),
                      ), // Rounded rectangle
                    ),
                    child: NeumorphicButton(
                      padding: EdgeInsets.all(12.0), // Button padding
                      onPressed: () {
                        // Navigates to the alarm page
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ClockAlarmPage(),
                          ),
                        );
                      },
                      style: NeumorphicStyle(
                        depth: -1, // Negative depth for emboss effect
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(8),
                        ), // Rounded rectangle
                      ),
                      child: Icon(
                        Icons.add,
                        color: Color(0xFFC1CDE5),
                      ), // Add icon with light blue-grey color
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Clock display
          Flexible(child: NeumorphicClock()), // Neumorphic clock widget
          SizedBox(height: 30), // Spacing
          // Current time
          Text(
            "6:21 PM", // Hardcoded time
            style: TextStyle(
              fontWeight: FontWeight.w700, // Bold text
              fontSize: 36, // Large font size
              shadows: [
                Shadow(
                  color: Colors.black38, // Shadow color
                  offset: Offset(1.0, 1.0), // Shadow offset
                  blurRadius: 2, // Shadow blur
                ),
              ],
              color: NeumorphicTheme.defaultTextColor(
                context,
              ), // Theme text color
            ),
          ),
          // Location
          Text(
            "London, UK", // Hardcoded location
            style: TextStyle(
              fontWeight: FontWeight.w500, // Medium text
              fontSize: 16, // Medium font size
              color: NeumorphicTheme.variantColor(
                context,
              ), // Theme variant color
            ),
          ),
          SizedBox(height: 20), // Spacing
          NeumorphicSelector(), // Selector dots
          SizedBox(height: 20), // Spacing
        ],
      ),
    );
  }
}

// Widget for rendering a neumorphic analog clock
class NeumorphicClock extends StatelessWidget {
  const NeumorphicClock({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1, // Square aspect ratio
      child: Neumorphic(
        margin: EdgeInsets.all(14), // Outer margin
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.circle(),
        ), // Circular shape
        child: Neumorphic(
          style: NeumorphicStyle(
            depth: 14, // Depth for middle layer
            boxShape: NeumorphicBoxShape.circle(), // Circular shape
          ),
          margin: EdgeInsets.all(20), // Middle margin
          child: Neumorphic(
            style: NeumorphicStyle(
              depth: -8, // Negative depth for inner emboss
              boxShape: NeumorphicBoxShape.circle(), // Circular shape
            ),
            margin: EdgeInsets.all(10), // Inner margin
            child: Stack(
              fit: StackFit.expand, // Expands to fill space
              alignment: Alignment.center, // Centers content
              children: [
                // Clock center
                Neumorphic(
                  style: NeumorphicStyle(
                    depth: -1, // Slight emboss for center
                    boxShape: NeumorphicBoxShape.circle(), // Circular shape
                  ),
                  margin: EdgeInsets.all(65), // Margin to create small center
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    16.0,
                  ), // Padding for clock elements
                  child: Stack(
                    children: <Widget>[
                      // Hour markers (dots)
                      Align(
                        alignment: Alignment.topCenter,
                        child: _createDot(context),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: _createDot(context),
                      ),
                      Align(
                        alignment: Alignment(-0.7, -0.7),
                        child: _createDot(context),
                      ),
                      Align(
                        alignment: Alignment(0.7, -0.7),
                        child: _createDot(context),
                      ),
                      Align(
                        alignment: Alignment(-0.7, 0.7),
                        child: _createDot(context),
                      ),
                      Align(
                        alignment: Alignment(0.7, 0.7),
                        child: _createDot(context),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: _createDot(context),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: _createDot(context),
                      ),
                      // Clock hands
                      _buildLine(
                        context: context,
                        angle: 0, // Hour hand angle (hardcoded)
                        width: 70, // Hour hand length
                        color: NeumorphicTheme.accentColor(
                          context,
                        ), // Purple color
                      ),
                      _buildLine(
                        context: context,
                        angle: 0.9, // Minute hand angle (hardcoded)
                        width: 100, // Minute hand length
                        color: NeumorphicTheme.accentColor(
                          context,
                        ), // Purple color
                      ),
                      _buildLine(
                        context: context,
                        angle: 2.2, // Second hand angle (hardcoded)
                        width: 120, // Second hand length
                        height: 1, // Thinner second hand
                        color: NeumorphicTheme.variantColor(
                          context,
                        ), // Black variant color
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Builds a clock hand
  Widget _buildLine({
    BuildContext? context,
    double? angle,
    double? width,
    double height = 6,
    Color? color,
  }) {
    return Transform.rotate(
      angle: angle!, // Rotates hand by specified angle
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: width!), // Offsets hand from center
          child: Neumorphic(
            style: NeumorphicStyle(depth: 20), // Pronounced depth for hand
            child: Container(
              width: width, // Hand length
              height: height, // Hand thickness
              color: color, // Hand color
            ),
          ),
        ),
      ),
    );
  }

  // Creates a dot for hour markers
  Widget _createDot(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: -10, // Negative depth for emboss effect
        boxShape: NeumorphicBoxShape.circle(), // Circular shape
      ),
      child: SizedBox(height: 10, width: 10), // Dot size
    );
  }
}

// Widget for rendering a neumorphic selector (carousel dots)
class NeumorphicSelector extends StatelessWidget {
  final double _elementHeight = 14; // Height of selector elements
  final double _spacing = 10; // Spacing between elements

  const NeumorphicSelector({super.key});

  // Builds a non-selected dot
  Widget _buildSimpleButton(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: -4, // Negative depth for emboss
        boxShape: NeumorphicBoxShape.circle(), // Circular shape
      ),
      child: SizedBox(
        height: _elementHeight,
        width: _elementHeight,
      ), // Dot size
    );
  }

  // Builds a selected dot
  Widget _buildSelectedButton(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: -4, // Negative depth for emboss
        boxShape: NeumorphicBoxShape.stadium(), // Stadium shape (rounded ends)
        color: Color(0xffE1E8F5), // Light blue-grey color
      ),
      child: SizedBox(height: _elementHeight, width: 30), // Selected dot size
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Centers dots
      children: <Widget>[
        _buildSimpleButton(context), // Non-selected dot
        SizedBox(width: _spacing), // Spacing
        _buildSelectedButton(context), // Selected dot
        SizedBox(width: _spacing), // Spacing
        _buildSimpleButton(context), // Non-selected dot
        SizedBox(width: _spacing), // Spacing
        _buildSimpleButton(context), // Non-selected dot
      ],
    );
  }
}

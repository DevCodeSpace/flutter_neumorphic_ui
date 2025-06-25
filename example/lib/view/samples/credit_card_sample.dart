// Importing required packages for UI components and effects
import 'dart:ui';

import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Root widget for the Credit Card sample demo page
class CreditCardSample extends StatefulWidget {
  // Constructor with optional key
  const CreditCardSample({super.key});

  @override
  createState() => _CreditCardSampleState();
}

// State class for applying the Neumorphic theme and wrapping the content page
class _CreditCardSampleState extends State<CreditCardSample> {
  @override
  Widget build(BuildContext context) {
    // Wraps the page with NeumorphicTheme for consistent styling
    return NeumorphicTheme(
      theme: NeumorphicThemeData(
        intensity: 0.6, // Intensity of neumorphic effect
        lightSource: LightSource.topLeft, // Light source from top-left
        depth: 5, // Depth for neumorphic shadow
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

// Container widget for the layout and UI of the Credit Card sample page
class _PageContent extends StatefulWidget {
  @override
  __PageContentState createState() => __PageContentState();
}

// State class for managing the page's UI and state
class __PageContentState extends State<_PageContent> {
  int _dotIndex = 1; // Tracks the selected dot (carousel indicator)
  bool _useDark = false; // Toggles between light and dark theme

  @override
  Widget build(BuildContext context) {
    return NeumorphicBackground(
      borderRadius: BorderRadius.circular(12), // Rounded corners for background
      margin: EdgeInsets.all(12), // Margin around content
      child: Column(
        children: <Widget>[
          SizedBox(height: 14), // Spacing
          _buildTopBar(context), // Top bar with navigation and theme toggle
          SizedBox(height: 30), // Spacing
          Expanded(child: _buildCard(context)), // Credit card display
          SizedBox(height: 30), // Spacing
          _buildDots(context), // Carousel dots
          SizedBox(height: 30), // Spacing
          _buildBalance(context), // Balance display
          SizedBox(height: 30), // Spacing
          _buildIndicator(context), // Credit limit indicator
          SizedBox(height: 30), // Spacing
        ],
      ),
    );
  }

  // Builds the credit card widget
  Widget _buildCard(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: 10, // Depth for outer neumorphic effect
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(20),
        ), // Rounded rectangle shape
        shape: NeumorphicShape.flat, // Flat shape
      ),
      child: Neumorphic(
        margin: EdgeInsets.all(8), // Margin for inner card
        style: NeumorphicStyle(
          depth: 10, // Depth for inner neumorphic effect
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(20),
          ), // Rounded rectangle shape
          shape: NeumorphicShape.flat, // Flat shape
        ),
        child: SizedBox(
          height: 200, // Fixed height
          child: AspectRatio(
            aspectRatio: 16 / 9, // Aspect ratio for card
            child: Stack(
              fit: StackFit.expand, // Expands to fill space
              children: <Widget>[
                // Commented-out background image
                // Image.asset("assets/images/map.jpg", fit: BoxFit.cover),
                // Blurred gradient overlay
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), // Blur effect
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight, // Gradient start
                        end: Alignment.bottomLeft, // Gradient end
                        colors: [
                          Colors.purple.withValues(
                            alpha: 0.5,
                          ), // Semi-transparent purple
                          Colors.red.withValues(
                            alpha: 0.5,
                          ), // Semi-transparent red
                        ],
                      ),
                    ),
                  ),
                ),
                // Card content
                Stack(
                  children: <Widget>[
                    // Card details (VISA, card number)
                    Positioned(
                      top: 12,
                      left: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "VISA", // Card brand
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 30), // Spacing
                          Text(
                            "1234 5678", // Partial card number
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black.withValues(alpha: 0.7),
                            ),
                          ),
                          SizedBox(height: 3), // Spacing
                          Text(
                            "1234 5678", // Partial card number
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Credit card chip
                    Positioned(
                      top: 12,
                      right: 16,
                      child: SizedBox(
                        height: 60,
                        child: Neumorphic(
                          style: NeumorphicStyle(
                            depth: 5, // Depth for chip
                            intensity: 0.8, // Intensity for chip
                            lightSource: LightSource.topLeft, // Light source
                            boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(12),
                            ), // Rounded rectangle
                          ),
                          child: RotatedBox(
                            quarterTurns: 1, // Rotates chip 90 degrees
                            child: Image.asset(
                              "assets/images/credit_card_chip.png", // Chip image
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Expiry date and logo
                    Positioned(
                      bottom: 12,
                      right: 16,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "09/24", // Expiry date
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                          SizedBox(height: 8), // Spacing
                          // Overlapping circles for logo
                          Stack(
                            children: <Widget>[
                              Neumorphic(
                                style: NeumorphicStyle(
                                  shape: NeumorphicShape.convex, // Convex shape
                                  depth: -10, // Negative depth for emboss
                                  boxShape:
                                      NeumorphicBoxShape.circle(), // Circular shape
                                  color: Colors.grey[300], // Light grey color
                                ),
                                child: const SizedBox(height: 30, width: 30),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 18,
                                ), // Offset for overlap
                                child: Neumorphic(
                                  style: NeumorphicStyle(
                                    shape:
                                        NeumorphicShape.convex, // Convex shape
                                    boxShape:
                                        NeumorphicBoxShape.circle(), // Circular shape
                                    depth: 10, // Positive depth
                                  ),
                                  child: const SizedBox(height: 30, width: 30),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Builds the top bar with back and theme toggle buttons
  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16), // Horizontal padding
      child: Stack(
        alignment: Alignment.center, // Centers content
        children: <Widget>[
          // Back button
          Align(
            alignment: Alignment.centerLeft,
            child: NeumorphicButton(
              onPressed: () {
                Navigator.of(context).pop(); // Navigates back
              },
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat, // Flat shape
                boxShape: NeumorphicBoxShape.circle(), // Circular shape
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(Icons.navigate_before), // Back icon
              ),
            ),
          ),
          // Title
          Align(
            alignment: Alignment.center,
            child: Text("Card"), // Page title
          ),
          // Theme toggle button
          Align(
            alignment: Alignment.centerRight,
            child: NeumorphicButton(
              onPressed: () {
                setState(() {
                  _useDark = !_useDark; // Toggles theme
                  NeumorphicTheme.of(context)?.themeMode = _useDark
                      ? ThemeMode.dark
                      : ThemeMode.light; // Updates theme
                });
              },
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat, // Flat shape
                boxShape: NeumorphicBoxShape.circle(), // Circular shape
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(Icons.loop), // Toggle icon
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Builds the balance display
  Widget _buildBalance(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 28.0,
      ), // Horizontal padding
      child: Stack(
        alignment: Alignment.center, // Centers content
        children: <Widget>[
          // Balance label
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Balance", // Label
              style: TextStyle(
                fontWeight: FontWeight.w800, // Bold text
                fontSize: 30,
                color: Color(0xFF3E3E3E), // Dark grey color
              ),
            ),
          ),
          // Balance amount
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "\$ 14,020.44", // Balance value
              style: TextStyle(
                fontWeight: FontWeight.w400, // Regular text
                fontSize: 14,
                color: Color(0xFF3E3E3E), // Dark grey color
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Builds the credit limit indicator
  Widget _buildIndicator(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 28.0,
      ), // Horizontal padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Centers content
        children: <Widget>[
          SizedBox(height: 8), // Spacing
          // Progress indicator
          NeumorphicIndicator(
            percent: 0.3, // 30% filled
            padding: EdgeInsets.all(3), // Padding around indicator
            orientation: NeumorphicIndicatorOrientation
                .horizontal, // Horizontal orientation
            height: 20, // Indicator height
            style: IndicatorStyle(
              accent: Colors.grey[100], // Light grey accent
              variant: Colors.grey[400], // Medium grey variant
            ),
          ),
          SizedBox(height: 8), // Spacing
          // Credit limit details
          Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Credit limit"), // Label
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text("\$ 220 / \$ 1000"), // Used vs total limit
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Builds the carousel dots
  Widget _buildDots(BuildContext context) {
    final double dotsSize = 18; // Size of dots
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Centers dots
      children: <Widget>[
        // First dot
        SizedBox(
          width: dotsSize,
          height: dotsSize,
          child: NeumorphicRadio(
            groupValue: _dotIndex, // Current selected dot
            value: 0, // Dot value
            onChanged: (value) {
              setState(() {
                _dotIndex = 0; // Updates dot index
              });
            },
            style: NeumorphicRadioStyle(
              boxShape: NeumorphicBoxShape.circle(), // Circular shape
              shape: NeumorphicShape.convex, // Convex shape
            ),
          ),
        ),
        SizedBox(width: 10), // Spacing
        // Second dot
        SizedBox(
          width: dotsSize,
          height: dotsSize,
          child: NeumorphicRadio(
            groupValue: _dotIndex, // Current selected dot
            value: 1, // Dot value
            onChanged: (value) {
              setState(() {
                _dotIndex = 1; // Updates dot index
              });
            },
            style: NeumorphicRadioStyle(
              boxShape: NeumorphicBoxShape.circle(), // Circular shape
              shape: NeumorphicShape.convex, // Convex shape
            ),
          ),
        ),
        SizedBox(width: 10), // Spacing
        // Third dot
        SizedBox(
          width: dotsSize,
          height: dotsSize,
          child: NeumorphicRadio(
            groupValue: _dotIndex, // Current selected dot
            value: 2, // Dot value
            onChanged: (value) {
              setState(() {
                _dotIndex = 2; // Updates dot index
              });
            },
            style: NeumorphicRadioStyle(
              boxShape: NeumorphicBoxShape.circle(), // Circular shape
              shape: NeumorphicShape.convex, // Convex shape
            ),
          ),
        ),
      ],
    );
  }
}

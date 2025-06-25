// Importing the Neumorphic package for UI styling
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Root widget for the Calculator sample demo page
class CalculatorSample extends StatefulWidget {
  // Constructor with optional key
  const CalculatorSample({super.key});

  @override
  createState() => _CalculatorSampleState();
}

// Constant text color for calculator display and buttons
final Color _calcTextColor = Color(0xFF484848);

// State class for applying the Neumorphic theme and wrapping the content page
class _CalculatorSampleState extends State<CalculatorSample> {
  @override
  Widget build(BuildContext context) {
    // Wraps the page with NeumorphicTheme for consistent styling
    return NeumorphicTheme(
      theme: NeumorphicThemeData(
        baseColor: Color(0xFFF4F5F5), // Light grey base color
        intensity: 0.3, // Intensity of neumorphic effect
        lightSource: LightSource.topLeft, // Light source from top-left
        variantColor: Colors.red, // Red variant color for specific buttons
        depth: 4, // Depth for neumorphic shadow
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

// Container widget for the layout and UI of the Calculator sample page
class _PageContent extends StatefulWidget {
  @override
  __PageContentState createState() => __PageContentState();
}

// Model class for calculator buttons
class CalcButton {
  final String label; // Button label (e.g., "1", "+", "C")
  final bool textAccent; // Whether to use accent color for text
  final bool textVariant; // Whether to use variant color for text
  final bool backgroundAccent; // Whether to use accent color for background

  CalcButton(
    this.label, {
    this.textAccent = false,
    this.backgroundAccent = false,
    this.textVariant = false,
  });
}

// Widget for rendering individual calculator buttons
class WidgetCalcButton extends StatelessWidget {
  final CalcButton button; // Button configuration

  const WidgetCalcButton(this.button, {super.key});

  // Determines the text color based on button properties
  Color _textColor(BuildContext context) {
    if (button.backgroundAccent) {
      return Colors.white; // White text for accent background
    } else if (button.textAccent) {
      return NeumorphicTheme.accentColor(context); // Accent color for text
    } else if (button.textVariant) {
      return NeumorphicTheme.variantColor(context); // Variant color for text
    } else {
      return _calcTextColor; // Default dark grey text color
    }
  }

  // Determines the background color based on button properties
  Color? _backgroundColor(BuildContext context) {
    return button.backgroundAccent
        ? NeumorphicTheme.accentColor(context) // Accent color for background
        : null; // No background color
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 14), // Top padding for spacing
      child: NeumorphicButton(
        onPressed: () {}, // Empty callback (no functionality implemented)
        style: NeumorphicStyle(
          surfaceIntensity: 0.15, // Surface intensity for neumorphic effect
          boxShape: NeumorphicBoxShape.circle(), // Circular shape
          shape: NeumorphicShape.concave, // Concave shape
          color: _backgroundColor(context), // Background color
        ),
        child: Center(
          child: Text(
            button.label, // Button label
            style: TextStyle(
              fontSize: 24,
              color: _textColor(context),
            ), // Text styling
          ),
        ),
      ),
    );
  }
}

// Widget for the calculator's top display screen
class _TopScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12),
        ), // Rounded rectangle shape
        depth:
            -1 *
            NeumorphicTheme.of(
              context,
            )!.current!.depth, // Inverted depth for emboss effect
      ),
      child: FractionallySizedBox(
        widthFactor: 1, // Full width
        child: Padding(
          padding: const EdgeInsets.all(18.0), // Padding inside screen
          child: Column(
            mainAxisSize: MainAxisSize.max, // Maximizes column size
            crossAxisAlignment: CrossAxisAlignment.end, // Aligns to the right
            mainAxisAlignment: MainAxisAlignment.end, // Aligns to the bottom
            children: <Widget>[
              Text(
                "3 x 7 =", // Expression display
                style: TextStyle(
                  fontSize: 30,
                  color: _calcTextColor,
                ), // Text styling
              ),
              Text(
                "21", // Result display
                style: TextStyle(
                  fontSize: 56,
                  color: _calcTextColor,
                ), // Larger text styling
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// State class for managing the calculator's UI and state
class __PageContentState extends State<_PageContent> {
  // List of calculator buttons
  final buttons = [
    CalcButton("%", textAccent: true), // Percentage, accent text
    CalcButton("^", textAccent: true), // Power, accent text
    CalcButton("sqrt", textAccent: true), // Square root, accent text
    CalcButton("C", textVariant: true), // Clear, variant text
    //----
    CalcButton("7"), // Number 7
    CalcButton("8"), // Number 8
    CalcButton("9"), // Number 9
    CalcButton("/", textAccent: true), // Division, accent text
    //----
    CalcButton("4"), // Number 4
    CalcButton("5"), // Number 5
    CalcButton("6"), // Number 6
    CalcButton("X", textAccent: true), // Multiplication, accent text
    //----
    CalcButton("1"), // Number 1
    CalcButton("2"), // Number 2
    CalcButton("3"), // Number 3
    CalcButton("-", textAccent: true), // Subtraction, accent text
    //----
    CalcButton("0"), // Number 0
    CalcButton("."), // Decimal point
    CalcButton("=", backgroundAccent: true), // Equals, accent background
    CalcButton("+", textAccent: true), // Addition, accent text
  ];

  @override
  Widget build(BuildContext context) {
    return NeumorphicBackground(
      child: Column(
        mainAxisSize: MainAxisSize.max, // Maximizes column size
        children: [
          // Back button
          Align(
            alignment: Alignment.topLeft, // Aligns to top-left
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 8), // Padding
              child: NeumorphicButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Navigates back
                },
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat, // Flat shape
                  boxShape: NeumorphicBoxShape.circle(), // Circular shape
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0), // Padding inside button
                  child: Icon(Icons.navigate_before), // Back icon
                ),
              ),
            ),
          ),
          // Top display screen
          Expanded(
            flex: 1, // Takes 1/3 of available space
            child: Padding(
              padding: const EdgeInsets.all(18.0), // Padding around screen
              child: _TopScreenWidget(),
            ),
          ),
          // Button grid
          Expanded(
            flex: 2, // Takes 2/3 of available space
            child: GridView.count(
              crossAxisCount: 4, // 4 columns
              padding: const EdgeInsets.only(
                left: 40,
                right: 40.0,
              ), // Horizontal padding
              children: List.generate(buttons.length, (index) {
                return WidgetCalcButton(
                  buttons[index],
                ); // Generates button widgets
              }),
            ),
          ),
          // Theme style toggle buttons
          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // Updates theme to style 1
                    NeumorphicTheme.of(context)?.updateCurrentTheme(
                      NeumorphicThemeData(
                        depth: 1, // Low depth
                        intensity: 0.5, // Medium intensity
                        accentColor: Colors.cyan, // Cyan accent
                      ),
                    );
                  });
                },
                child: Text("style 1"), // Button label
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // Updates theme to style 2
                    NeumorphicTheme.of(context)?.updateCurrentTheme(
                      NeumorphicThemeData(
                        depth: 8, // High depth
                        intensity: 0.3, // Low intensity
                        accentColor: Colors.greenAccent, // Green accent
                      ),
                    );
                  });
                },
                child: Text("style 2"), // Button label
              ),
            ],
          ),
        ],
      ),
    );
  }
}

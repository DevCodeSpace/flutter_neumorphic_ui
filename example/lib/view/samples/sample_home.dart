// Importing required packages and sample pages for navigation
import 'package:example/view/samples/audio_player_sample.dart';
import 'package:example/view/samples/calculator_sample.dart';
import 'package:example/view/samples/clock/clock_sample.dart';
import 'package:example/view/samples/credit_card_sample.dart';
import 'package:example/view/samples/form_sample.dart';
import 'package:example/view/samples/testla_sample.dart'; // Note: Likely a typo, should be 'tesla_sample.dart'
import 'package:example/view/widgets/theme/top_bar.dart';
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

import 'galaxy_sample.dart';
import 'widgets_sample.dart';

// Root widget for the Samples Home page
class SamplesHome extends StatelessWidget {
  // Constructor with optional key
  const SamplesHome({super.key});

  // Builds a neumorphic button with consistent styling
  Widget _buildButton({String? text, VoidCallback? onClick}) {
    return NeumorphicButton(
      margin: EdgeInsets.only(bottom: 12), // Adds bottom margin for spacing
      padding: EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 24,
      ), // Sets vertical and horizontal padding
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat, // Flat shape for the button
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12),
        ), // Rounded rectangle shape
      ),
      onPressed: onClick, // Callback triggered on button press
      child: Center(child: Text(text!)), // Centers the button text
    );
  }

  @override
  Widget build(BuildContext context) {
    // Wraps the page with NeumorphicTheme for consistent styling
    return NeumorphicTheme(
      theme: NeumorphicThemeData(depth: 8), // Sets depth for light theme
      darkTheme: NeumorphicThemeData(depth: 8), // Sets depth for dark theme
      child: Scaffold(
        backgroundColor:
            NeumorphicColors.background, // Uses neumorphic background color
        body: SafeArea(
          // Ensures content avoids system UI areas
          child: SingleChildScrollView(
            // Enables scrolling for the content
            child: Padding(
              padding: const EdgeInsets.all(
                18.0,
              ), // Adds padding around the content
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .stretch, // Stretches children horizontally
                mainAxisAlignment:
                    MainAxisAlignment.start, // Aligns children at the start
                mainAxisSize: MainAxisSize.max, // Maximizes column size
                children: [
                  TopBar(), // Displays the top bar
                  // Button to navigate to Tesla sample
                  _buildButton(
                    text: "Tesla",
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => TeslaSample()),
                      );
                    },
                  ),
                  // Button to navigate to Audio Player sample
                  _buildButton(
                    text: "Audio Player",
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AudioPlayerSample(),
                        ),
                      );
                    },
                  ),
                  // Button to navigate to Clock sample
                  _buildButton(
                    text: "Clock",
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ClockSample()),
                      );
                    },
                  ),
                  // Button to navigate to Galaxy sample
                  _buildButton(
                    text: "Galaxy",
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => GalaxySample()),
                      );
                    },
                  ),
                  // Button to navigate to Calculator sample
                  _buildButton(
                    text: "Calculator",
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CalculatorSample(),
                        ),
                      );
                    },
                  ),
                  // Button to navigate to Form sample
                  _buildButton(
                    text: "Form",
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FormSample()),
                      );
                    },
                  ),
                  // Button to navigate to Credit Card sample
                  _buildButton(
                    text: "CreditCard",
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CreditCardSample(),
                        ),
                      );
                    },
                  ),
                  // Button to navigate to Widgets sample
                  _buildButton(
                    text: "Widgets",
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => WidgetsSample(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

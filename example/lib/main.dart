import 'package:example/view/play_ground/sample_neumorphic_playground.dart';
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

import 'view/accessibility/neumorphic_accessibility.dart';
import 'view/neumorphic_playground/neumorphic_playground.dart';
import 'view/samples/sample_home.dart';
import 'view/text_playground/text_playground.dart';
import 'view/tips/tips_home.dart';
import 'view/widgets/widgets_home.dart';

// Entry point of the application
void main() => runApp(MyApp());

// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Neumorphic',
      themeMode: ThemeMode.light, // Default theme mode
      theme: const NeumorphicThemeData(
        baseColor: Color(0xFFFFFFFF), // White base color for light theme
        lightSource: LightSource.topLeft, // Light source direction
        shadowLightColor: Color(0xFF3E3E3E), // Shadow color for light theme
        depth: 2, // Default depth
        intensity: 1, // Default intensity
      ),
      darkTheme: const NeumorphicThemeData(
        baseColor: Color(0xFF3E3E3E), // Dark grey base color for dark theme
        depth: 10, // Depth for dark theme
        intensity: 85, // Intensity for dark theme
      ),
      home: FullSampleHomePage(), // Main home page
    );
  }
}

// Home page widget with navigation buttons
class FullSampleHomePage extends StatelessWidget {
  const FullSampleHomePage({super.key});

  // Reusable neumorphic button widget with improved design
  Widget _buildButton({
    required String text,
    required VoidCallback onClick,
    BuildContext? context,
  }) {
    return NeumorphicButton(
      margin: const EdgeInsets.only(bottom: 12), // Margin between buttons
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 24,
      ), // Padding inside button
      style: NeumorphicStyle(
        shape:
            NeumorphicShape.convex, // Convex shape for better neumorphic effect
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(16),
        ), // Rounded corners
        depth: 6, // Increased depth for more pronounced shadow
        intensity: 0.7, // Adjusted intensity for better contrast
        lightSource: LightSource.topLeft, // Consistent light source
        color: NeumorphicTheme.isUsingDark(context!)
            ? Colors.grey[800] // Darker color for dark theme
            : Colors.white, // White for light theme
        shadowDarkColor: Colors.black45, // Darker shadow for depth
        shadowLightColor: Colors.white70, // Lighter shadow for highlights
      ),
      onPressed: onClick,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16, // Slightly larger font size
            fontWeight: FontWeight.w600, // Semi-bold for better readability
            color: NeumorphicTheme.isUsingDark(context)
                ? Colors
                      .white70 // Light text for dark theme
                : Colors.black87, // Dark text for light theme
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(
        context,
      ), // Theme background color
      body: NeumorphicTheme(
        theme: NeumorphicThemeData(depth: 8), // Local theme override for depth
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0), // Padding around content
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.stretch, // Stretch buttons horizontally
                mainAxisAlignment:
                    MainAxisAlignment.start, // Align content at the top
                children: [
                  // Toggle theme button
                  _buildButton(
                    text: "Toggle Theme",
                    onClick: () {
                      NeumorphicTheme.of(
                        context,
                      )?.themeMode = NeumorphicTheme.isUsingDark(context)
                          ? ThemeMode.light
                          : ThemeMode.dark;
                    },
                    context: context,
                  ),
                  const SizedBox(height: 24), // Spacing between buttons
                  // Neumorphic Playground button
                  _buildButton(
                    text: "Neumorphic Playground",
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => NeumorphicPlayground(),
                        ),
                      );
                    },
                    context: context,
                  ),
                  const SizedBox(height: 24), // Spacing
                  // Text Playground button
                  _buildButton(
                    text: "Text Playground",
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => NeumorphicTextPlayground(),
                        ),
                      );
                    },
                    context: context,
                  ),
                  const SizedBox(height: 24), // Spacing
                  // Samples button
                  _buildButton(
                    text: "Samples",
                    onClick: () {
                      Navigator.of(
                        context,
                      ).push(MaterialPageRoute(builder: (_) => SamplesHome()));
                    },
                    context: context,
                  ),
                  const SizedBox(height: 24), // Spacing
                  // Widgets button
                  _buildButton(
                    text: "Widgets",
                    onClick: () {
                      Navigator.of(
                        context,
                      ).push(MaterialPageRoute(builder: (_) => WidgetsHome()));
                    },
                    context: context,
                  ),
                  const SizedBox(height: 24), // Spacing
                  // Tips button
                  _buildButton(
                    text: "Tips",
                    onClick: () {
                      Navigator.of(
                        context,
                      ).push(MaterialPageRoute(builder: (_) => TipsHome()));
                    },
                    context: context,
                  ),
                  const SizedBox(height: 24), // Spacing
                  // Play Ground button
                  _buildButton(
                    text: "Play Ground",
                    onClick: () {
                      Navigator.of(
                        context,
                      ).push(MaterialPageRoute(builder: (_) => PlayGround()));
                    },
                    context: context,
                  ),
                  const SizedBox(height: 24), // Spacing
                  // Accessibility button
                  _buildButton(
                    text: "Accessibility",
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => NeumorphicAccessibility(),
                        ),
                      );
                    },
                    context: context,
                  ),
                  const SizedBox(height: 12), // Final spacing
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

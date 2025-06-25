import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart'; // Importing Neumorphic UI package

import 'theme_color_selector.dart'; // Importing custom theme color selector widget

/// Widget that shows a Neumorphic settings button
/// which opens a dialog to configure theme properties
class ThemeConfigurator extends StatelessWidget {
  const ThemeConfigurator({super.key});

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      padding: EdgeInsets.all(18), // Padding inside the button
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat, // Flat neumorphic appearance
        boxShape: NeumorphicBoxShape.circle(), // Circular button
      ),
      child: Icon(
        Icons.settings, // Settings icon
        color: NeumorphicTheme.isUsingDark(context)
            ? Colors
                  .white70 // White color for dark theme
            : Colors.black87, // Black color for light theme
      ),
      onPressed: () {
        _changeColor(context); // Show theme configuration dialog
      },
    );
  }

  /// Opens a dialog to change theme settings
  void _changeColor(BuildContext context) {
    showDialog(
      useRootNavigator: false, // Use current context's navigator
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Theme'),
          content: SingleChildScrollView(
            // Inject the theme-aware configurator dialog
            child: _ThemeConfiguratorDialog(contextContainingTheme: context),
          ),
          actions: <Widget>[
            // Close button to dismiss the dialog
            NeumorphicButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

/// Internal widget shown inside the dialog to configure theme
class _ThemeConfiguratorDialog extends StatefulWidget {
  final BuildContext contextContainingTheme;

  const _ThemeConfiguratorDialog({required this.contextContainingTheme});

  @override
  _ThemeConfiguratorState createState() => _ThemeConfiguratorState();
}

class _ThemeConfiguratorState extends State<_ThemeConfiguratorDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Allows selecting the primary color for the theme
        ThemeColorSelector(customContext: widget.contextContainingTheme),

        // Slider to change intensity of the neumorphic design
        intensitySelector(),

        // Slider to change depth of the neumorphic components
        depthSelector(),
      ],
    );
  }

  /// Builds a slider for changing the neumorphic intensity
  Widget intensitySelector() {
    final intensity = NeumorphicTheme.intensity(widget.contextContainingTheme);

    return Row(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(left: 12), child: Text("Intensity")),
        Expanded(
          child: Slider(
            min: Neumorphic.minIntensity,
            max: Neumorphic.maxIntensity,
            value: intensity ?? 0.0,
            onChanged: (value) {
              setState(() {
                // Update the theme's intensity
                NeumorphicTheme.update(
                  widget.contextContainingTheme,
                  (current) => current!.copyWith(intensity: value),
                );
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: SizedBox(
            width: 40,
            child: Text(((intensity! * 100).floor() / 100).toString()),
          ),
        ),
      ],
    );
  }

  /// Builds a slider for changing the neumorphic depth
  Widget depthSelector() {
    final depth = NeumorphicTheme.depth(widget.contextContainingTheme);

    return Row(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(left: 12), child: Text("Depth")),
        Expanded(
          child: Slider(
            min: Neumorphic.minDepth,
            max: Neumorphic.maxDepth,
            value: depth ?? 0.0,
            onChanged: (value) {
              setState(() {
                // Update the theme's depth
                NeumorphicTheme.update(
                  widget.contextContainingTheme,
                  (current) => current!.copyWith(depth: value),
                );
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: SizedBox(width: 40, child: Text(depth!.floor().toString())),
        ),
      ],
    );
  }
}

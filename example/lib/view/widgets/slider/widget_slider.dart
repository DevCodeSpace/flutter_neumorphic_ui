// Importing required packages and widgets
import 'package:example/view/widgets/theme/code.dart';
import 'package:example/view/widgets/theme/color_selector.dart';
import 'package:example/view/widgets/theme/theme_configurator.dart';
import 'package:example/view/widgets/theme/top_bar.dart';
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Main widget class for the slider demo page
class SliderWidgetPage extends StatefulWidget {
  const SliderWidgetPage({super.key});

  @override
  createState() => _WidgetPageState();
}

// Sets up the Neumorphic theme for the page
class _WidgetPageState extends State<SliderWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        lightSource: LightSource.topLeft,
        accentColor: NeumorphicColors.accent,
        depth: 4,
        intensity: 0.5,
      ),
      child: _Page(), // Main content page
    );
  }
}

// Main content widget
class _Page extends StatefulWidget {
  @override
  createState() => _PageState();
}

// Page content layout
class _PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicBackground(
      padding: EdgeInsets.all(8),
      child: Scaffold(
        appBar: TopBar(title: "Slider", actions: <Widget>[ThemeConfigurator()]),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _DefaultWidget(), // Default slider demo
              _ColorWidget(), // Color custom slider demo
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// Default slider example widget
class _DefaultWidget extends StatefulWidget {
  @override
  createState() => _DefaultWidgetState();
}

class _DefaultWidgetState extends State<_DefaultWidget> {
  double age = 20; // Initial slider value

  // Displays the Dart code for default slider
  Widget _buildCode(BuildContext context) {
    return Code("""
double age = 20;  

Expanded(
  child: NeumorphicSlider(
      value: age,
      min: 18,
      max: 90,
      onChanged: (value) {
        setState(() {
          age = value;
        });
      },
  ),
),
""");
  }

  // Builds the slider UI
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Default",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          Expanded(
            child: NeumorphicSlider(
              value: age,
              min: 18,
              max: 90,
              onChanged: (value) {
                setState(() {
                  age = value;
                });
              },
            ),
          ),
          SizedBox(width: 12),
          Text(
            "${age.round()}",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
        ],
      ),
    );
  }

  // Returns the full widget and code block
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[_buildWidget(context), _buildCode(context)],
    );
  }
}

// Colored slider widget
class _ColorWidget extends StatefulWidget {
  @override
  createState() => _ColorWidgetState();
}

class _ColorWidgetState extends State<_ColorWidget> {
  double age = 50; // Initial value for slider
  Color accent = Colors.green; // Initial accent color
  Color variant = Colors.purple; // Initial variant color

  // Dart code representation for colored slider
  Widget _buildCode(BuildContext context) {
    return Code("""
double age = 50;  

Expanded(
  child: NeumorphicSlider(
      style: SliderStyle(
           accent: Colors.green,
           variant: Colors.purple,
      ),
      value: age,
      min: 18,
      max: 90,
      onChanged: (value) {
        setState(() {
          age = value;
        });
      },
  ),
),
""");
  }

  // Builds the slider with color selectors
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          // Color pickers for accent and variant
          Row(
            children: <Widget>[
              Text("Accent : "),
              ColorSelector(
                onColorChanged: (color) {
                  setState(() {
                    accent = color;
                  });
                },
                color: accent,
              ),
              SizedBox(width: 12),
              Text("Variant : "),
              ColorSelector(
                onColorChanged: (color) {
                  setState(() {
                    variant = color;
                  });
                },
                color: variant,
              ),
            ],
          ),
          SizedBox(height: 12),
          // Slider row with selected colors
          Row(
            children: <Widget>[
              Text(
                "Default",
                style: TextStyle(
                  color: NeumorphicTheme.defaultTextColor(context),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: NeumorphicSlider(
                  style: SliderStyle(accent: accent, variant: variant),
                  value: age,
                  min: 18,
                  max: 90,
                  onChanged: (value) {
                    setState(() {
                      age = value;
                    });
                  },
                ),
              ),
              SizedBox(width: 12),
              Text(
                "${age.round()}",
                style: TextStyle(
                  color: NeumorphicTheme.defaultTextColor(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Returns the full widget with the code example
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[_buildWidget(context), _buildCode(context)],
    );
  }
}

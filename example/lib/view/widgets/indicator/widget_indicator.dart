// Importing required Dart library
import 'dart:math' show Random;

// Importing custom widgets and packages
import 'package:example/view/widgets/theme/code.dart'; // For showing code snippets
import 'package:example/view/widgets/theme/color_selector.dart'; // Color picker widget
import 'package:example/view/widgets/theme/theme_configurator.dart'; // Toggle themes
import 'package:example/view/widgets/theme/top_bar.dart'; // Top bar widget
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart'; // Neumorphic design package

/// Main page entry for the Indicator demo screen
class IndicatorWidgetPage extends StatefulWidget {
  const IndicatorWidgetPage({super.key});

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<IndicatorWidgetPage> {
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
      child: _Page(), // Main content widget
    );
  }
}

/// Core container for the Indicator content page
class _Page extends StatefulWidget {
  @override
  createState() => _PageState();
}

class _PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicBackground(
      padding: EdgeInsets.all(8),
      child: Scaffold(
        appBar: TopBar(
          title: "Indicator",
          actions: <Widget>[ThemeConfigurator()],
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _DefaultWidget(), // Basic vertical indicator
              _DefaultOrientationWidget(), // Horizontal indicator
              _DurationWidget(), // Indicator with animation duration
              _ColorWidget(), // Custom color indicators
              _CurveWidget(), // Indicator with animation curve
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

/// Vertical indicator with random value update
class _DefaultWidget extends StatefulWidget {
  @override
  createState() => _DefaultWidgetState();
}

class _DefaultWidgetState extends State<_DefaultWidget> {
  double percent = 0.6;

  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicIndicator(
    height: 100,
    width: 20,
    percent: 0.6,
),
""");
  }

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

          // Vertical indicator bar
          NeumorphicIndicator(height: 100, width: 20, percent: percent),

          SizedBox(width: 12),

          // Tap to update indicator with random percentage
          GestureDetector(
            child: Text('Update'),
            onTap: () {
              setState(() {
                percent = Random().nextDouble();
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [_buildWidget(context), _buildCode(context)],
    );
  }
}

/// Horizontal layout orientation example
class _DefaultOrientationWidget extends StatefulWidget {
  @override
  createState() => _DefaultOrientationWidgetState();
}

class _DefaultOrientationWidgetState extends State<_DefaultOrientationWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicIndicator(
     width: 150,
     height: 15,
     orientation: NeumorphicIndicatorOrientation.horizontal,
     percent: 0.7,
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Text(
            "Orientation\nHorizontal",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),

          // Horizontal indicator bar
          NeumorphicIndicator(
            width: 150,
            height: 15,
            orientation: NeumorphicIndicatorOrientation.horizontal,
            percent: 0.7,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [_buildWidget(context), _buildCode(context)],
    );
  }
}

/// Example showing how to apply custom colors using [accent] and [variant]
class _ColorWidget extends StatefulWidget {
  @override
  createState() => _ColorWidgetState();
}

class _ColorWidgetState extends State<_ColorWidget> {
  Color accent = Colors.green;
  Color variant = Colors.purple;

  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicIndicator(
      width: 150,
      height: 15,
      orientation: NeumorphicIndicatorOrientation.horizontal,
      percent: 0.7,
      style: IndicatorStyle(
        variant: variant,
        accent: accent
      ),
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          // Color pickers for accent and variant
          Row(
            children: [
              Text("Accent : "),
              ColorSelector(
                onColorChanged: (color) => setState(() => accent = color),
                color: accent,
              ),
              SizedBox(width: 12),
              Text("Variant : "),
              ColorSelector(
                onColorChanged: (color) => setState(() => variant = color),
                color: variant,
              ),
            ],
          ),
          SizedBox(height: 12),

          // Colored indicator bar
          Row(
            children: [
              Text(
                "Colorized",
                style: TextStyle(
                  color: NeumorphicTheme.defaultTextColor(context),
                ),
              ),
              SizedBox(width: 12),
              NeumorphicIndicator(
                width: 150,
                height: 15,
                orientation: NeumorphicIndicatorOrientation.horizontal,
                percent: 0.7,
                style: IndicatorStyle(variant: variant, accent: accent),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [_buildWidget(context), _buildCode(context)],
    );
  }
}

/// Shows indicator with animation duration
class _DurationWidget extends StatefulWidget {
  @override
  createState() => _DurationWidgetState();
}

class _DurationWidgetState extends State<_DurationWidget> {
  double percent = 0.3;

  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicIndicator(
    height: 100,
    width: 20,
    percent: 0.3,
    duration: Duration(seconds: 1),
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Duration",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),

          // Animated duration indicator
          NeumorphicIndicator(
            height: 100,
            width: 20,
            percent: percent,
            duration: Duration(seconds: 1),
          ),

          SizedBox(width: 12),
          GestureDetector(
            child: Text('Update'),
            onTap: () {
              setState(() {
                percent = Random().nextDouble();
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [_buildWidget(context), _buildCode(context)],
    );
  }
}

/// Shows animated curve effect on indicator update
class _CurveWidget extends StatefulWidget {
  @override
  createState() => _CurveWidgetState();
}

class _CurveWidgetState extends State<_CurveWidget> {
  double percent = 0.3;

  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicIndicator(
    height: 100,
    width: 20,
    percent: 0.3,
    curve: Curves.bounceOut,
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Curve",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),

          // Curved animation indicator
          NeumorphicIndicator(
            height: 100,
            width: 20,
            percent: percent,
            curve: Curves.bounceOut,
          ),
          SizedBox(width: 12),
          GestureDetector(
            child: Text('Update'),
            onTap: () {
              setState(() {
                percent = Random().nextDouble();
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [_buildWidget(context), _buildCode(context)],
    );
  }
}

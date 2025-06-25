import 'dart:math' show Random;

import 'package:example/view/widgets/theme/code.dart';
import 'package:example/view/widgets/theme/color_selector.dart';
import 'package:example/view/widgets/theme/top_bar.dart';
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

/// Main page widget showing different variations of NeumorphicProgress
class ProgressWidgetPage extends StatefulWidget {
  const ProgressWidgetPage({super.key});

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<ProgressWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      // Apply light theme with default Neumorphic settings
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        lightSource: LightSource.topLeft,
        accentColor: NeumorphicColors.accent,
        depth: 4,
        intensity: 0.5,
      ),
      child: _Page(), // Child widget with actual UI
    );
  }
}

/// Scaffold wrapper with TopBar and content layout
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
        appBar: TopBar(title: "Progress"), // Custom top bar
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _DefaultWidget(), // Default progress
              _ColorWidget(), // Custom colors
              _SizedWidget(), // Custom height
              _DurationWidget(), // Animation duration
              _CurveWidget(), // Animation curve
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

/// Default progress bar widget with random percent update
class _DefaultWidget extends StatefulWidget {
  @override
  createState() => _DefaultWidgetState();
}

class _DefaultWidgetState extends State<_DefaultWidget> {
  double percent = 0.2;

  /// Code preview widget
  Widget _buildCode(BuildContext context) {
    return Code("""
double percent = 0.2;  

Expanded(
  child: NeumorphicProgress(
      percent: percent,
  ),
),
""");
  }

  /// Actual progress UI with update trigger
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
          Expanded(child: NeumorphicProgress(percent: percent)),
          SizedBox(width: 12),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildWidget(context),
        // Updates percent randomly on tap
        TextButton(
          child: Text('Update'),
          onPressed: () {
            setState(() {
              percent = Random().nextDouble();
            });
          },
        ),
        _buildCode(context),
      ],
    );
  }
}

/// Progress bar with customizable accent and variant colors
class _ColorWidget extends StatefulWidget {
  @override
  createState() => _ColorWidgetState();
}

class _ColorWidgetState extends State<_ColorWidget> {
  double percent = 0.5;
  Color accent = Colors.green;
  Color variant = Colors.purple;

  /// Code preview
  Widget _buildCode(BuildContext context) {
    return Code("""
double percent = 0.5;  

Expanded(
  child: NeumorphicProgress(
      style: ProgressStyle(
           accent: Colors.green,
           variant: Colors.purple,
      ),
      percent: percent,
  ),
),
""");
  }

  /// UI with color selectors and customized progress
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          // Color selectors
          Row(
            children: <Widget>[
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
          // Progress bar with selected colors
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
                child: NeumorphicProgress(
                  style: ProgressStyle(accent: accent, variant: variant),
                  percent: percent,
                ),
              ),
              SizedBox(width: 12),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[_buildWidget(context), _buildCode(context)],
  );
}

/// Progress bar with custom height
class _SizedWidget extends StatefulWidget {
  @override
  createState() => _SizedWidgetState();
}

class _SizedWidgetState extends State<_SizedWidget> {
  double percent = 0.5;

  /// Code snippet
  Widget _buildCode(BuildContext context) {
    return Code("""
double percent = 0.5;  

Expanded(
  child: NeumorphicProgress(
      height: 30,
      percent: percent,
  ),
),
""");
  }

  /// Progress bar with height = 30
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Sized",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          Expanded(child: NeumorphicProgress(height: 30, percent: percent)),
          SizedBox(width: 12),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[_buildWidget(context), _buildCode(context)],
  );
}

/// Progress bar with animation duration of 1 second
class _DurationWidget extends StatefulWidget {
  @override
  createState() => _DurationWidgetState();
}

class _DurationWidgetState extends State<_DurationWidget> {
  double percent = 0.2;

  /// Code preview
  Widget _buildCode(BuildContext context) {
    return Code("""
double percent = 0.2;  

Expanded(
  child: NeumorphicProgress(
      percent: percent,
      duration: Duration(seconds: 1),
  ),
),
""");
  }

  /// UI with animated duration progress
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
          Expanded(
            child: NeumorphicProgress(
              percent: percent,
              duration: Duration(seconds: 1),
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildWidget(context),
      // Update button to randomize percent
      TextButton(
        child: Text('Update'),
        onPressed: () {
          setState(() {
            percent = Random().nextDouble();
          });
        },
      ),
      _buildCode(context),
    ],
  );
}

/// Progress bar with animation curve (bounceOut)
class _CurveWidget extends StatefulWidget {
  @override
  createState() => _CurveWidgetState();
}

class _CurveWidgetState extends State<_CurveWidget> {
  double percent = 0.2;

  /// Code display
  Widget _buildCode(BuildContext context) {
    return Code("""
double percent = 0.2;  

Expanded(
  child: NeumorphicProgress(
      percent: percent,
      curve: Curves.bounceOut,
  ),
),
""");
  }

  /// Widget with bounceOut animation
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
          Expanded(
            child: NeumorphicProgress(
              percent: percent,
              curve: Curves.bounceOut,
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildWidget(context),
      TextButton(
        child: Text('Update'),
        onPressed: () {
          setState(() {
            percent = Random().nextDouble();
          });
        },
      ),
      _buildCode(context),
    ],
  );
}

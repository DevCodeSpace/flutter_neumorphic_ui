import 'package:example/view/widgets/theme/code.dart';
import 'package:example/view/widgets/theme/color_selector.dart';
import 'package:example/view/widgets/theme/theme_configurator.dart';
import 'package:example/view/widgets/theme/top_bar.dart';
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

/// Entry page for displaying variations of NeumorphicProgressIndeterminate
class IndeterminateProgressWidgetPage extends StatefulWidget {
  const IndeterminateProgressWidgetPage({super.key});

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<IndeterminateProgressWidgetPage> {
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
      child: _Page(), // Loads the main content
    );
  }
}

/// Main layout of the page with top bar and scrollable content
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
          title: "IndeterminateProgress",
          actions: <Widget>[
            ThemeConfigurator(), // Theme switcher action
          ],
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _DefaultWidget(),
              _ColorWidget(),
              _SizedWidget(),
              _DurationWidget(),
              _ReversedWidget(),
              _CurveWidget(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

/// Default indeterminate progress example
class _DefaultWidget extends StatefulWidget {
  @override
  createState() => _DefaultWidgetState();
}

class _DefaultWidgetState extends State<_DefaultWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
Expanded(
  child: NeumorphicProgressIndeterminate(),
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
          Expanded(child: NeumorphicProgressIndeterminate()),
          SizedBox(width: 12),
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

/// Custom accent and variant color demonstration
class _ColorWidget extends StatefulWidget {
  @override
  createState() => _ColorWidgetState();
}

class _ColorWidgetState extends State<_ColorWidget> {
  Color accent = Colors.green;
  Color variant = Colors.purple;

  Widget _buildCode(BuildContext context) {
    return Code("""
Expanded(
  child: NeumorphicProgressIndeterminate(
    style: ProgressStyle(
      accent: Colors.green,
      variant: Colors.purple,
    ),
  ),
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          // Color selector for accent and variant
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
          // Progress bar with applied colors
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
                child: NeumorphicProgressIndeterminate(
                  style: ProgressStyle(accent: accent, variant: variant),
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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [_buildWidget(context), _buildCode(context)],
    );
  }
}

/// Custom height demonstration
class _SizedWidget extends StatefulWidget {
  @override
  createState() => _SizedWidgetState();
}

class _SizedWidgetState extends State<_SizedWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
Expanded(
  child: NeumorphicProgressIndeterminate(
    height: 30,
  ),
),
""");
  }

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
          Expanded(child: NeumorphicProgressIndeterminate(height: 30)),
          SizedBox(width: 12),
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

/// Custom animation duration demonstration
class _DurationWidget extends StatefulWidget {
  @override
  createState() => _DurationWidgetState();
}

class _DurationWidgetState extends State<_DurationWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
Expanded(
  child: NeumorphicProgressIndeterminate(
    duration: Duration(seconds: 10),
  ),
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
          Expanded(
            child: NeumorphicProgressIndeterminate(
              duration: Duration(seconds: 10),
            ),
          ),
          SizedBox(width: 12),
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

/// Reverse animation direction
class _ReversedWidget extends StatefulWidget {
  @override
  createState() => _ReversedWidgetState();
}

class _ReversedWidgetState extends State<_ReversedWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
Expanded(
  child: NeumorphicProgressIndeterminate(
    reverse: true,
  ),
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Reversed",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          Expanded(child: NeumorphicProgressIndeterminate(reverse: true)),
          SizedBox(width: 12),
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

/// Animation curve customization
class _CurveWidget extends StatefulWidget {
  @override
  createState() => _CurveWidgetState();
}

class _CurveWidgetState extends State<_CurveWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
Expanded(
  child: NeumorphicProgressIndeterminate(
    curve: Curves.bounceOut,
  ),
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
          Expanded(
            child: NeumorphicProgressIndeterminate(curve: Curves.bounceOut),
          ),
          SizedBox(width: 12),
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

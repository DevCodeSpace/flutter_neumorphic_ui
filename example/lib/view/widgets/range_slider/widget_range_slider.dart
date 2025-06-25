// Importing required packages and widgets
import 'package:example/view/widgets/theme/code.dart';
import 'package:example/view/widgets/theme/color_selector.dart';
import 'package:example/view/widgets/theme/theme_configurator.dart';
import 'package:example/view/widgets/theme/top_bar.dart';
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Main StatefulWidget for the RangeSlider demo page
class RangeSliderWidgetPage extends StatefulWidget {
  const RangeSliderWidgetPage({super.key});

  @override
  createState() => _RangeWidgetPageState();
}

// Wrapper for setting the Neumorphic theme
class _RangeWidgetPageState extends State<RangeSliderWidgetPage> {
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
      child: _Page(), // Embeds the actual UI in the theme
    );
  }
}

// The actual page content widget
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
          title: "Range Slider",
          actions: <Widget>[ThemeConfigurator()],
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _DefaultWidget(), // Default style range slider
              _ColorWidget(), // Custom-colored range slider
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// Default range slider widget with initial values
class _DefaultWidget extends StatefulWidget {
  @override
  createState() => _DefaultWidgetState();
}

class _DefaultWidgetState extends State<_DefaultWidget> {
  double lowVal = 30;
  double highVal = 70;

  // Displays the source code of this widget
  Widget _buildCode(BuildContext context) {
    return Code("""
double lowVal = 30;
double highVal = 70;

Expanded(
  child: NeumorphicRangeSlider(
    valueLow: lowVal,
    valueHigh: highVal,
    min: 18,
    max: 90,
    onChangedLow: (value) {
      setState(() {
        lowVal = value;
      });
    },
    onChangeHigh: (value) {
      setState(() {
        highVal = value;
      });
    },
  ),
),
""");
  }

  // Builds the actual default range slider
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
            child: NeumorphicRangeSlider(
              valueLow: lowVal,
              valueHigh: highVal,
              min: 18,
              max: 90,
              onChangedLow: (value) {
                setState(() {
                  lowVal = value;
                });
              },
              onChangeHigh: (value) {
                setState(() {
                  highVal = value;
                });
              },
            ),
          ),
          SizedBox(width: 12),
          Text(
            "${lowVal.round()} - ${highVal.round()}",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
        ],
      ),
    );
  }

  // Combines the UI and its code sample
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[_buildWidget(context), _buildCode(context)],
    );
  }
}

// Widget for colored range slider
class _ColorWidget extends StatefulWidget {
  @override
  createState() => _ColorWidgetState();
}

class _ColorWidgetState extends State<_ColorWidget> {
  double lowVal = 30;
  double highVal = 80;

  Color accent = Colors.green;
  Color variant = Colors.purple;

  // Displays the code snippet for the colored slider
  Widget _buildCode(BuildContext context) {
    return Code("""
double lowVal = 30;
double highVal = 80;

Expanded(
  child: NeumorphicRangeSlider(
    style: RangeSliderStyle(
      accent: accent,
      variant: variant,
    ),
    valueLow: lowVal,
    valueHigh: highVal,
    min: 18,
    max: 90,
    onChangedLow: (value) {
      setState(() {
        lowVal = value;
      });
    },
    onChangeHigh: (value) {
      setState(() {
        highVal = value;
      });
    },
  ),
),
""");
  }

  // Builds the colored range slider with color pickers
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          // Color selector for accent and variant
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
          // Range slider with customized colors
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
                child: NeumorphicRangeSlider(
                  style: RangeSliderStyle(accent: accent, variant: variant),
                  valueLow: lowVal,
                  valueHigh: highVal,
                  min: 18,
                  max: 90,
                  onChangedLow: (value) {
                    setState(() {
                      lowVal = value;
                    });
                  },
                  onChangeHigh: (value) {
                    setState(() {
                      highVal = value;
                    });
                  },
                ),
              ),
              SizedBox(width: 12),
              Text(
                "${lowVal.round()} - ${highVal.round()}",
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

  // Combines the customized range slider and its code display
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[_buildWidget(context), _buildCode(context)],
    );
  }
}

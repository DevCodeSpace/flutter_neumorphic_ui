// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:example/view/widgets/theme/code.dart'; // Widget to show code snippet block
import 'package:example/view/widgets/theme/theme_configurator.dart'; // Widget to toggle themes
import 'package:example/view/widgets/theme/top_bar.dart'; // Custom top bar widget
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart'; // Neumorphic UI package

/// Entry widget for the RadioButton demo page
class RadioButtonWidgetPage extends StatefulWidget {
  const RadioButtonWidgetPage({super.key});

  @override
  createState() => _WidgetPageState();
}

/// Wraps the page in a NeumorphicTheme
class _WidgetPageState extends State<RadioButtonWidgetPage> {
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

/// Main content container widget
class _Page extends StatefulWidget {
  @override
  createState() => _PageState();
}

/// Holds the layout and structure of the demo UI
class _PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicBackground(
      padding: EdgeInsets.all(8),
      child: Scaffold(
        appBar: TopBar(title: "Radios", actions: <Widget>[ThemeConfigurator()]),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _DefaultWidget(), // Standard horizontal radio buttons
              CircleRadios(), // Circular radio buttons
              _EnabledDisabledWidget(), // Enabled + disabled radio buttons
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

/// Default-style Neumorphic radio buttons with int values
class _DefaultWidget extends StatefulWidget {
  @override
  createState() => _DefaultWidgetState();
}

class _DefaultWidgetState extends State<_DefaultWidget> {
  var groupValue; // Tracks the currently selected value

  /// Shows code snippet for this example
  Widget _buildCode(BuildContext context) {
    return Code("""
int groupValue;

NeumorphicRadio(
    groupValue: groupValue,
    value: 1991,
    onChanged: (value) {
        setState(() {
          groupValue = value;
        });
    },
    child: Text("2012"),
),
""");
  }

  /// UI for horizontal default radio buttons
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

          /// First radio button
          NeumorphicRadio(
            groupValue: groupValue,
            value: 1991,
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            padding: EdgeInsets.all(8.0),
            child: Text("1991"),
          ),

          SizedBox(width: 12),

          /// Second radio button
          NeumorphicRadio(
            value: 2000,
            groupValue: groupValue,
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            padding: EdgeInsets.all(8.0),
            child: Text("2000"),
          ),

          SizedBox(width: 12),

          /// Third radio button
          NeumorphicRadio(
            groupValue: groupValue,
            value: 2012,
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            padding: EdgeInsets.all(8.0),
            child: Text("2012"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[_buildWidget(context), _buildCode(context)],
    );
  }
}

/// Circle-shaped radio buttons using strings as values
class CircleRadios extends StatefulWidget {
  const CircleRadios({super.key});

  @override
  createState() => _CircleRadiosState();
}

class _CircleRadiosState extends State<CircleRadios> {
  var groupValue; // Tracks selected circle radio value

  /// Shows code snippet
  Widget _buildCode(BuildContext context) {
    return Code("""
String groupValue;

NeumorphicRadio(
    groupValue: groupValue,
    style: NeumorphicRadioStyle(boxShape: NeumorphicBoxShape.circle()),
    value: "A",
    onChanged: (value) {
        setState(() {
          groupValue = value;
        });
    },
    child: Text("A"),
),
""");
  }

  /// UI for circular-shaped radio buttons
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Circle",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),

          /// Circle Radio A
          NeumorphicRadio(
            style: NeumorphicRadioStyle(boxShape: NeumorphicBoxShape.circle()),
            groupValue: groupValue,
            value: "A",
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            padding: EdgeInsets.all(18.0),
            child: Text("A"),
          ),

          SizedBox(width: 12),

          /// Circle Radio B
          NeumorphicRadio(
            value: "B",
            style: NeumorphicRadioStyle(boxShape: NeumorphicBoxShape.circle()),
            groupValue: groupValue,
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            padding: EdgeInsets.all(18.0),
            child: Text("B"),
          ),

          SizedBox(width: 12),

          /// Circle Radio C
          NeumorphicRadio(
            style: NeumorphicRadioStyle(boxShape: NeumorphicBoxShape.circle()),
            groupValue: groupValue,
            value: "C",
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            padding: EdgeInsets.all(18.0),
            child: Text("C"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[_buildWidget(context), _buildCode(context)],
    );
  }
}

/// Widget to show both enabled and disabled radio buttons
class _EnabledDisabledWidget extends StatefulWidget {
  @override
  createState() => _EnabledDisabledWidgetState();
}

class _EnabledDisabledWidgetState extends State<_EnabledDisabledWidget> {
  var groupValue; // Tracks selection between enabled/disabled radios

  /// UI widget with one active and one disabled radio
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Enabled :",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),

          /// Active radio button
          NeumorphicRadio(
            groupValue: groupValue,
            value: 1,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            child: Text("First"),
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
          ),

          SizedBox(width: 24),

          Text(
            "Disabled :",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),

          /// Disabled radio button (not clickable)
          NeumorphicRadio(
            isEnabled: false,
            groupValue: groupValue,
            value: 2,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            child: Text("Second"),
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
          ),
        ],
      ),
    );
  }

  /// Code snippet display
  Widget _buildCode(BuildContext context) {
    return Code("""    
int groupValue;

NeumorphicRadio(
     isEnabled: false,
     groupValue: groupValue,
     value: 2,
     onChanged: (value) {
       setState(() {
         groupValue = value;
       });
     },
     child: Text("Second"),
),
""");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[_buildWidget(context), _buildCode(context)],
    );
  }
}

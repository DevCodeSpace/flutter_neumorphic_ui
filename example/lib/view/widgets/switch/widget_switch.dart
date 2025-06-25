import 'package:example/view/widgets/theme/code.dart';
import 'package:example/view/widgets/theme/color_selector.dart';
import 'package:example/view/widgets/theme/theme_configurator.dart';
import 'package:example/view/widgets/theme/top_bar.dart';
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

/// Main entry page for displaying various Neumorphic switch examples.
class SwitchWidgetPage extends StatefulWidget {
  const SwitchWidgetPage({super.key});

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<SwitchWidgetPage> {
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
      child: _Page(), // Child widget where switches are listed
    );
  }
}

/// Internal page that hosts the actual content within the Neumorphic background.
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
        appBar: TopBar(title: "Switch", actions: <Widget>[ThemeConfigurator()]),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              _DefaultWidget(),
              _ColorizableWidget(),
              ColorizableThumbSwitch(),
              _FlatConcaveConvexWidget(),
              _EnabledDisabledWidget(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget to display a default switch with enable/disable toggle.
class _DefaultWidget extends StatefulWidget {
  @override
  createState() => _DefaultWidgetState();
}

class _DefaultWidgetState extends State<_DefaultWidget> {
  bool isChecked = false;
  bool isEnabled = true;

  /// Shows code snippet related to the default switch.
  Widget _buildCode(BuildContext context) {
    return Code("""
bool isChecked;

NeumorphicSwitch(
    value: isChecked,
    onChanged: (value) {
        setState(() {
          isChecked = value;
        });
    },
),
""");
  }

  /// Displays a switch and an enable/disable toggle.
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
          NeumorphicSwitch(
            isEnabled: isEnabled,
            value: isChecked,
            onChanged: (value) {
              setState(() {
                isChecked = value;
              });
            },
          ),
          SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              setState(() {
                isEnabled = !isEnabled;
              });
            },
            child: Text(isEnabled ? 'Disable' : 'Enable'),
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

/// Widget to demonstrate different thumb shapes for the switch.
class _FlatConcaveConvexWidget extends StatefulWidget {
  @override
  createState() => _FlatConcaveConvexWidgetState();
}

class _FlatConcaveConvexWidgetState extends State<_FlatConcaveConvexWidget> {
  bool isChecked = false;

  /// Shows the code snippet demonstrating switch with thumb shapes.
  Widget _buildCode(BuildContext context) {
    return Code("""
bool isChecked;

NeumorphicSwitch(
    value: isChecked,
    style: NeumorphicSwitchStyle(
         thumbShape: NeumorphicShape.flat 
         //or convex, concave
    ),
    onChanged: (value) {
        setState(() {
          isChecked = value;
        });
    },
),
""");
  }

  /// Shows flat, concave, and convex styled switches.
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          SizedBox(height: 12),
          Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  "Flat",
                  style: TextStyle(
                    color: NeumorphicTheme.defaultTextColor(context),
                  ),
                ),
              ),
              SizedBox(width: 12),
              NeumorphicSwitch(
                style: NeumorphicSwitchStyle(thumbShape: NeumorphicShape.flat),
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  "Concave",
                  style: TextStyle(
                    color: NeumorphicTheme.defaultTextColor(context),
                  ),
                ),
              ),
              SizedBox(width: 12),
              NeumorphicSwitch(
                style: NeumorphicSwitchStyle(
                  thumbShape: NeumorphicShape.concave,
                ),
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  "Convex",
                  style: TextStyle(
                    color: NeumorphicTheme.defaultTextColor(context),
                  ),
                ),
              ),
              SizedBox(width: 12),
              NeumorphicSwitch(
                style: NeumorphicSwitchStyle(
                  thumbShape: NeumorphicShape.convex,
                ),
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value;
                  });
                },
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

/// Widget to show how the switch color can be customized.
class _ColorizableWidget extends StatefulWidget {
  @override
  createState() => _ColorizableWidgetState();
}

class _ColorizableWidgetState extends State<_ColorizableWidget> {
  bool isChecked = false;
  Color currentColor = Colors.green;

  /// Code preview for customizing the active track color.
  Widget _buildCode(BuildContext context) {
    return Code("""
bool isChecked;

NeumorphicSwitch(
    value: isChecked,
    style: NeumorphicSwitchStyle(
        activeTrackColor: Colors.green
    ),
    onChanged: (value) {
        setState(() {
          isChecked = value;
        });
    },
),
""");
  }

  /// Widget section to choose a color and display a switch with that color.
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Text(
            "Color",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          ColorSelector(
            color: currentColor,
            onColorChanged: (color) {
              setState(() {
                currentColor = color;
              });
            },
          ),
          SizedBox(width: 12),
          NeumorphicSwitch(
            value: isChecked,
            style: NeumorphicSwitchStyle(activeTrackColor: currentColor),
            onChanged: (value) {
              setState(() {
                isChecked = value;
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

/// Widget to demonstrate both thumb and track color customization.
class ColorizableThumbSwitch extends StatefulWidget {
  const ColorizableThumbSwitch({super.key});

  @override
  createState() => _ColorizableThumbSwitchState();
}

class _ColorizableThumbSwitchState extends State<ColorizableThumbSwitch> {
  bool isChecked = false;
  Color thumbColor = Colors.purple;
  Color trackColor = Colors.lightGreen;

  /// Code block showing thumb and track color styling.
  Widget _buildCode(BuildContext context) {
    return Code("""
bool isChecked;

NeumorphicSwitch(
    value: isChecked,
    style: NeumorphicSwitchStyle(
          activeTrackColor: Colors.lightGreen,
          activeThumbColor: Colors.purple
    ),
    onChanged: (value) {
        setState(() {
          isChecked = value;
        });
    },
),
""");
  }

  /// UI to customize track and thumb colors using ColorSelector.
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Text(
            "Track",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          ColorSelector(
            color: trackColor,
            onColorChanged: (color) {
              setState(() {
                trackColor = color;
              });
            },
          ),
          SizedBox(width: 12),
          Text(
            "Thumb",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          ColorSelector(
            color: thumbColor,
            onColorChanged: (color) {
              setState(() {
                thumbColor = color;
              });
            },
          ),
          SizedBox(width: 12),
          NeumorphicSwitch(
            value: isChecked,
            style: NeumorphicSwitchStyle(
              activeTrackColor: trackColor,
              activeThumbColor: thumbColor,
            ),
            onChanged: (value) {
              setState(() {
                isChecked = value;
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

/// Widget to show difference between enabled and disabled states of the switch.
class _EnabledDisabledWidget extends StatefulWidget {
  @override
  createState() => _EnabledDisabledWidgetState();
}

class _EnabledDisabledWidgetState extends State<_EnabledDisabledWidget> {
  bool isChecked1 = false;
  bool isChecked2 = false;

  /// Code snippet for a disabled switch.
  Widget _buildCode(BuildContext context) {
    return Code("""
bool isChecked;

NeumorphicSwitch(
    value: isChecked,
    isEnabled: false,
    onChanged: (value) {
        setState(() {
          isChecked = value;
        });
    },
),
""");
  }

  /// Displays an enabled and a disabled switch with different shapes.
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          SizedBox(height: 12),
          Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  "Enabled",
                  style: TextStyle(
                    color: NeumorphicTheme.defaultTextColor(context),
                  ),
                ),
              ),
              SizedBox(width: 12),
              NeumorphicSwitch(
                style: NeumorphicSwitchStyle(
                  thumbShape: NeumorphicShape.concave,
                ),
                value: isChecked1,
                onChanged: (value) {
                  setState(() {
                    isChecked1 = value;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  "Disabled",
                  style: TextStyle(
                    color: NeumorphicTheme.defaultTextColor(context),
                  ),
                ),
              ),
              SizedBox(width: 12),
              NeumorphicSwitch(
                isEnabled: false,
                style: NeumorphicSwitchStyle(
                  thumbShape: NeumorphicShape.convex,
                ),
                value: isChecked2,
                onChanged: (value) {
                  setState(() {
                    isChecked2 = value;
                  });
                },
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

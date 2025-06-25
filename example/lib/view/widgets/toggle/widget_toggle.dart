// ignore_for_file: avoid_print

import 'package:example/view/widgets/theme/code.dart';
import 'package:example/view/widgets/theme/theme_configurator.dart';
import 'package:example/view/widgets/theme/top_bar.dart';
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Main toggle widget demo page
class ToggleWidgetPage extends StatefulWidget {
  const ToggleWidgetPage({super.key});

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<ToggleWidgetPage> {
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
      child: _Page(),
    );
  }
}

// Inner page to layout UI and scroll content
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
        appBar: TopBar(title: "Toggle", actions: <Widget>[ThemeConfigurator()]),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [_DefaultWidget(), _SmallWidget(), SizedBox(height: 30)],
          ),
        ),
      ),
    );
  }
}

// Default large toggle with text options
class _DefaultWidget extends StatefulWidget {
  @override
  createState() => _DefaultWidgetState();
}

class _DefaultWidgetState extends State<_DefaultWidget> {
  int _selectedIndex = 0;

  // Shows code sample in UI
  Widget _buildCode(BuildContext context) {
    return Code("""
Expanded(
  child: NeumorphicToggle(
    height: 50,
    selectedIndex: _selectedIndex,
    displayForegroundOnlyIfSelected: true,
    children: [
      ToggleElement(
        background: Center(child: Text("This week")),
        foreground: Center(child: Text("This week")),
      ),
      ToggleElement(
        background: Center(child: Text("This month")),
        foreground: Center(child: Text("This month")),
      ),
      ToggleElement(
        background: Center(child: Text("This year")),
        foreground: Center(child: Text("This year")),
      )
    ],
    thumb: Neumorphic(...),
    onChanged: (value) {
      setState(() {
        _selectedIndex = value;
        print("_firstSelected: \$_selectedIndex");
      });
    },
  ),
),
""");
  }

  // NeumorphicToggle with labels
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
            child: NeumorphicToggle(
              height: 50,
              selectedIndex: _selectedIndex,
              displayForegroundOnlyIfSelected: true,
              children: [
                ToggleElement(
                  background: Center(
                    child: Text(
                      "This week",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  foreground: Center(
                    child: Text(
                      "This week",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                ToggleElement(
                  background: Center(
                    child: Text(
                      "This month",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  foreground: Center(
                    child: Text(
                      "This month",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                ToggleElement(
                  background: Center(
                    child: Text(
                      "This year",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  foreground: Center(
                    child: Text(
                      "This year",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
              thumb: Neumorphic(
                style: NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(12),
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _selectedIndex = value;
                  print("_firstSelected: $_selectedIndex");
                });
              },
            ),
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

// Smaller toggle with icons only
class _SmallWidget extends StatefulWidget {
  @override
  createState() => _SmallWidgetState();
}

class _SmallWidgetState extends State<_SmallWidget> {
  int _selectedIndex = 1;

  // Shows code sample in UI
  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicToggle(
  height: 45,
  width: 100,
  selectedIndex: _selectedIndex,
  children: [
    ToggleElement(
      background: Center(child: Icon(Icons.arrow_back)),
    ),
    ToggleElement(),
  ],
  thumb: Neumorphic(
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
    child: Icon(Icons.blur_on),
  ),
  onAnimationChangedFinished: (value) {
    if(value == 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('on back!')));
    }
  },
  onChanged: (value) {
    setState(() {
      _selectedIndex = value;
    });
  },
),
""");
  }

  // NeumorphicToggle with icon-only and snack bar
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Small",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          NeumorphicToggle(
            height: 45,
            width: 100,
            selectedIndex: _selectedIndex,
            children: [
              ToggleElement(
                background: Center(
                  child: Icon(Icons.arrow_back, color: Colors.grey[800]),
                ),
              ),
              ToggleElement(),
            ],
            thumb: Neumorphic(
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(12),
                ),
              ),
              child: Icon(Icons.blur_on, color: Colors.grey),
            ),
            onAnimationChangedFinished: (value) {
              if (value == 0) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('on back!')));
              }
            },
            onChanged: (value) {
              setState(() {
                _selectedIndex = value;
                print("_firstSelected: $_selectedIndex");
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

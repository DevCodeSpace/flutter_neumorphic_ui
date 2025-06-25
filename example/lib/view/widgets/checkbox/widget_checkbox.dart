// Importing required packages and local widgets for UI components and theming
import 'package:example/view/widgets/theme/code.dart';
import 'package:example/view/widgets/theme/color_selector.dart';
import 'package:example/view/widgets/theme/theme_configurator.dart';
import 'package:example/view/widgets/theme/top_bar.dart';
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Root widget for the Checkbox demo page
class CheckboxWidgetPage extends StatefulWidget {
  const CheckboxWidgetPage({super.key});

  @override
  createState() => _WidgetPageState();
}

// Applies the Neumorphic theme and wraps the actual content page
class _WidgetPageState extends State<CheckboxWidgetPage> {
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
      child: _Page(), // Main page content
    );
  }
}

// Container widget for the layout and UI of the Checkbox page
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
          title: "Checkbox",
          actions: <Widget>[ThemeConfigurator()], // Button to change theme
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _DefaultWidget(), // Shows default checkboxes
              _ColorWidget(), // Checkboxes with customizable color
              _EnabledDisabledWidget(), // Enabled and disabled states
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------------
// Default Checkbox Section
// ------------------------
class _DefaultWidget extends StatefulWidget {
  @override
  createState() => _DefaultWidgetState();
}

class _DefaultWidgetState extends State<_DefaultWidget> {
  // Three independent checkbox values
  bool check1 = false;
  bool check2 = false;
  bool check3 = false;

  // Sample code display
  Widget _buildCode(BuildContext context) {
    return Code("""
bool isChecked = false;  

NeumorphicCheckbox(
    value: isChecked,
    onChanged: (value) {
        setState(() {
          isChecked = value;
        });
    },
),
""");
  }

  // Row of checkboxes for default UI
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
          NeumorphicCheckbox(
            value: check1,
            onChanged: (value) => setState(() => check1 = value),
          ),
          SizedBox(width: 12),
          NeumorphicCheckbox(
            value: check2,
            onChanged: (value) => setState(() => check2 = value),
          ),
          SizedBox(width: 12),
          NeumorphicCheckbox(
            value: check3,
            onChanged: (value) => setState(() => check3 = value),
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

// ----------------------------
// Custom Color Checkbox Section
// ----------------------------
class _ColorWidget extends StatefulWidget {
  @override
  createState() => _ColorWidgetState();
}

class _ColorWidgetState extends State<_ColorWidget> {
  Color customColor = Colors.green;

  bool checkColor1 = false;
  bool checkColor2 = false;
  bool checkColor3 = false;

  // Row of colorized checkboxes with color selector
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Colorizable",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          // Color picker widget
          ColorSelector(
            color: customColor,
            onColorChanged: (color) => setState(() => customColor = color),
          ),
          SizedBox(width: 12),
          NeumorphicCheckbox(
            style: NeumorphicCheckboxStyle(selectedColor: customColor),
            value: checkColor1,
            onChanged: (value) => setState(() => checkColor1 = value),
          ),
          SizedBox(width: 12),
          NeumorphicCheckbox(
            style: NeumorphicCheckboxStyle(selectedColor: customColor),
            value: checkColor2,
            onChanged: (value) => setState(() => checkColor2 = value),
          ),
          SizedBox(width: 12),
          NeumorphicCheckbox(
            style: NeumorphicCheckboxStyle(selectedColor: customColor),
            value: checkColor3,
            onChanged: (value) => setState(() => checkColor3 = value),
          ),
        ],
      ),
    );
  }

  // Sample code for colorized checkbox
  Widget _buildCode(BuildContext context) {
    return Code("""
bool isChecked = false;  

NeumorphicCheckbox(
    value: isChecked,
    style: NeumorphicCheckboxStyle(
        selectedColor: Colors.green,
    ),
    onChanged: (value) {
        setState(() {
          isChecked = value;
        });
    },
),
""");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [_buildWidget(context), _buildCode(context)],
    );
  }
}

// ---------------------------------
// Enabled/Disabled Checkbox Section
// ---------------------------------
class _EnabledDisabledWidget extends StatefulWidget {
  @override
  createState() => _EnabledDisabledWidgetState();
}

class _EnabledDisabledWidgetState extends State<_EnabledDisabledWidget> {
  bool check1 = false;
  bool check2 = false;

  // Row showing an enabled and a disabled checkbox
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Enabled",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          NeumorphicCheckbox(
            value: check1,
            onChanged: (value) => setState(() => check1 = value),
          ),
          SizedBox(width: 24),
          Text(
            "Disabled",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          NeumorphicCheckbox(
            isEnabled: false,
            value: check2,
            onChanged: (value) =>
                setState(() => check2 = value), // No effect when disabled
          ),
        ],
      ),
    );
  }

  // Code snippet for a disabled checkbox
  Widget _buildCode(BuildContext context) {
    return Code("""
bool isChecked = false;  

NeumorphicCheckbox(
     isEnabled: false,
     value: isChecked,
     onChanged: (value) {
       setState(() {
         isChecked = value;
       });
     },
),
""");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [_buildWidget(context), _buildCode(context)],
    );
  }
}

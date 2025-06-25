import 'package:example/view/widgets/appbar/widget_app_bar.dart';
import 'package:example/view/widgets/theme/top_bar.dart';
import 'package:example/view/widgets/toggle/widget_toggle.dart';
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

import 'background/widget_background.dart';
import 'button/widget_button.dart';
import 'checkbox/widget_checkbox.dart';
import 'container/widget_container.dart';
import 'icon/widget_icon.dart';
import 'indeterminate_progress/widget_indeterminate_progress.dart';
import 'indicator/widget_indicator.dart';
import 'progress/widget_progress.dart';
import 'radiobutton/widget_radio_button.dart';
import 'range_slider/widget_range_slider.dart';
import 'slider/widget_slider.dart';
import 'switch/widget_switch.dart';

class WidgetsHome extends StatelessWidget {
  const WidgetsHome({super.key});

  // Reusable neumorphic button to navigate to each widget demo
  Widget _buildButton(context, {String? text, VoidCallback? onClick}) {
    return NeumorphicButton(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        color: NeumorphicTheme.isUsingDark(context!)
            ? Colors.grey[800] // Darker color for dark theme
            : Colors.white,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
      ),
      onPressed: onClick,
      child: Center(
        child: Text(
          text!,
          style: TextStyle(
            color: NeumorphicTheme.isUsingDark(context)
                ? Colors
                      .white70 // Light text for dark theme
                : Colors.black87,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      // Local depth override for all child widgets
      theme: NeumorphicThemeData(depth: 8),
      child: Scaffold(
        backgroundColor: NeumorphicColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title bar at the top
                  TopBar(title: "Widgets"),

                  // List of buttons, each navigating to a widget example
                  _buildButton(
                    context,
                    text: "Container",
                    onClick: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ContainerWidgetPage()),
                    ),
                  ),
                  _buildButton(
                    context,
                    text: "App bar",
                    onClick: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => AppBarWidgetPage()),
                    ),
                  ),
                  _buildButton(
                    context,
                    text: "Button",
                    onClick: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ButtonWidgetPage()),
                    ),
                  ),
                  _buildButton(
                    context,
                    text: "Icon",
                    onClick: () => Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (_) => IconWidgetPage())),
                  ),
                  _buildButton(
                    context,
                    text: "RadioButton",
                    onClick: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RadioButtonWidgetPage(),
                      ),
                    ),
                  ),
                  _buildButton(
                    context,
                    text: "Checkbox",
                    onClick: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => CheckboxWidgetPage()),
                    ),
                  ),
                  _buildButton(
                    context,
                    text: "Switch",
                    onClick: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => SwitchWidgetPage()),
                    ),
                  ),
                  _buildButton(
                    context,
                    text: "Toggle",
                    onClick: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ToggleWidgetPage()),
                    ),
                  ),
                  _buildButton(
                    context,
                    text: "Slider",
                    onClick: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => SliderWidgetPage()),
                    ),
                  ),
                  _buildButton(
                    context,
                    text: "Range slider",
                    onClick: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RangeSliderWidgetPage(),
                      ),
                    ),
                  ),
                  _buildButton(
                    context,
                    text: "Indicator",
                    onClick: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => IndicatorWidgetPage()),
                    ),
                  ),
                  _buildButton(
                    context,
                    text: "Progress",
                    onClick: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ProgressWidgetPage()),
                    ),
                  ),
                  _buildButton(
                    context,
                    text: "IndeterminateProgress",
                    onClick: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => IndeterminateProgressWidgetPage(),
                      ),
                    ),
                  ),
                  _buildButton(
                    context,
                    text: "Background",
                    onClick: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => BackgroundWidgetPage()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

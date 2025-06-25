// Importing required packages and local widgets for UI components
import 'package:example/view/widgets/theme/top_bar.dart';
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Root widget for the Clock Alarm sample demo page
class ClockAlarmPage extends StatelessWidget {
  // Constructor with optional key
  const ClockAlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Wraps the page with NeumorphicTheme for consistent styling
    return NeumorphicTheme(
      theme: NeumorphicThemeData(
        defaultTextColor: Color(0xFF303E57), // Dark blue-grey text color
        accentColor: Color(0xFF7B79FC), // Purple accent color
        variantColor: Colors.black38, // Semi-transparent black variant color
        baseColor: Color(0xFFF8F9FC), // Light grey base color
        depth: 8, // Depth for neumorphic shadow
        intensity: 0.5, // Intensity of neumorphic effect
        lightSource: LightSource.topLeft, // Light source from top-left
      ),
      themeMode: ThemeMode.light, // Sets theme to light mode
      child: Material(
        child: NeumorphicBackground(
          // Applies neumorphic background
          child: _Page(), // Renders the main page content
        ),
      ),
    );
  }
}

// Container widget for the layout and UI of the Clock Alarm page
class _Page extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

// State class for managing the page's UI and state
class _ClockPageState extends State<_Page> {
  // List of predefined alarms
  final List<Alarm> items = [
    Alarm(enabled: true, time: "8:30 AM", label: "Awake !"),
    Alarm(enabled: false, time: "8:45 AM", label: "Wake up !"),
    Alarm(enabled: false, time: "9:00 AM", label: "Hurry up !"),
    Alarm(enabled: false, time: "2:00 AM", label: "Lunchtime"),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Ensures content avoids system UI areas
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Centers content horizontally
        children: <Widget>[
          // Top bar
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              top: 9.0,
            ), // Padding for top bar
            child: TopBar(), // Custom top bar widget
          ),
          // Header with title and add button
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
            ), // Horizontal padding
            child: Stack(
              children: <Widget>[
                // Alarm title
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Alarm", // Page title
                    style: TextStyle(
                      fontWeight: FontWeight.w700, // Bold text
                      fontSize: 28, // Large font size
                      shadows: [
                        Shadow(
                          color: Colors.black38, // Shadow color
                          offset: Offset(1.0, 1.0), // Shadow offset
                          blurRadius: 2, // Shadow blur
                        ),
                      ],
                      color: NeumorphicTheme.defaultTextColor(
                        context,
                      ), // Theme text color
                    ),
                  ),
                ),
                // Add alarm button
                Align(
                  alignment: Alignment.topRight,
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      depth: 20, // High depth for pronounced effect
                      intensity: 0.4, // Intensity of neumorphic effect
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(8),
                      ), // Rounded rectangle
                    ),
                    child: NeumorphicButton(
                      padding: EdgeInsets.all(12.0), // Button padding
                      style: NeumorphicStyle(
                        depth: -1, // Negative depth for emboss effect
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(8),
                        ), // Rounded rectangle
                      ),
                      child: Icon(
                        Icons.add,
                        color: Color(0xFFC1CDE5),
                      ), // Add icon with light blue-grey color
                      onPressed:
                          () {}, // Empty callback (no functionality implemented)
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20), // Spacing
          _Divider(), // Divider line
          // List of alarms
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return AlarmCell(
                  items[index],
                ); // Builds alarm cell for each item
              },
              itemCount: items.length, // Number of alarms
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for displaying individual alarm cells
class AlarmCell extends StatelessWidget {
  final Alarm alarm; // Alarm data

  const AlarmCell(this.alarm, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0), // Padding around cell
          child: Row(
            children: <Widget>[
              // Alarm time and label
              Padding(
                padding: const EdgeInsets.only(left: 12.0), // Left padding
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Aligns to start
                  children: <Widget>[
                    Text(
                      alarm.time, // Alarm time
                      style: TextStyle(
                        fontWeight: FontWeight.w700, // Bold text
                        fontSize: 36, // Large font size
                        shadows: [
                          Shadow(
                            color: Colors.black38, // Shadow color
                            offset: Offset(1.0, 1.0), // Shadow offset
                            blurRadius: 2, // Shadow blur
                          ),
                        ],
                        color: NeumorphicTheme.defaultTextColor(
                          context,
                        ), // Theme text color
                      ),
                    ),
                    SizedBox(height: 4), // Spacing
                    Text(
                      alarm.label, // Alarm label
                      style: TextStyle(
                        fontWeight: FontWeight.w300, // Light text
                        fontSize: 14, // Small font size
                        color: NeumorphicTheme.variantColor(
                          context,
                        ), // Theme variant color
                      ),
                    ),
                  ],
                ),
              ),
              // Switch for enabling/disabling alarm
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.max, // Maximizes row width
                  mainAxisAlignment: MainAxisAlignment.end, // Aligns to end
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 20), // Right padding
                      child: Neumorphic(
                        style: NeumorphicStyle(
                          depth: 8, // Depth for switch container
                          intensity: 0.5, // Intensity of neumorphic effect
                          boxShape:
                              NeumorphicBoxShape.stadium(), // Stadium shape (rounded ends)
                        ),
                        child: NeumorphicSwitch(
                          style: NeumorphicSwitchStyle(
                            inactiveTrackColor: Color(
                              0xffC1CDE5,
                            ), // Light blue-grey for inactive track
                          ),
                          height: 30, // Switch height
                          value: alarm.enabled, // Switch state
                          onChanged: null, // No callback (read-only display)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        _Divider(), // Divider line below cell
      ],
    );
  }
}

// Widget for rendering a divider line
class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1, // Full width
      child: Neumorphic(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ), // Margin around divider
        style: NeumorphicStyle(
          depth: -4, // Negative depth for emboss effect
          boxShape:
              NeumorphicBoxShape.stadium(), // Stadium shape (rounded ends)
        ),
        child: SizedBox(height: 6), // Divider height
      ),
    );
  }
}

// Data class for representing an alarm
class Alarm {
  final bool enabled; // Whether the alarm is enabled
  final String time; // Alarm time (e.g., "8:30 AM")
  final String label; // Alarm label (e.g., "Awake !")

  const Alarm({required this.enabled, required this.time, required this.label});
}

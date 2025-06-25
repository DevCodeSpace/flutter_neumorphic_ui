// Importing required packages and local widgets for UI components and theming
import 'package:example/view/widgets/theme/theme_configurator.dart';
import 'package:example/view/widgets/theme/top_bar.dart';
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Root widget for the Form sample demo page
class FormSample extends StatelessWidget {
  // Constructor with optional key
  const FormSample({super.key});

  @override
  Widget build(BuildContext context) {
    // Wraps the page with NeumorphicTheme for consistent styling
    return NeumorphicTheme(
      theme: NeumorphicThemeData(
        defaultTextColor: Color(0xFF3E3E3E), // Dark grey text color
        accentColor: Colors.grey, // Grey accent color
        variantColor: Colors.black38, // Semi-transparent black variant color
        depth: 8, // Depth for neumorphic shadow
        intensity: 0.65, // Intensity of neumorphic effect
      ),
      themeMode: ThemeMode.light, // Sets the theme to light mode
      child: Material(
        child: NeumorphicBackground(
          // Applies neumorphic background
          child: _Page(), // Renders the main page content
        ),
      ),
    );
  }
}

// Container widget for the layout and UI of the Form sample page
class _Page extends StatefulWidget {
  @override
  __PageState createState() => __PageState();
}

// Enum to represent gender options
enum Gender { male, female, nonBinary }

// State class for managing the form's state and UI
class __PageState extends State<_Page> {
  String firstName = ""; // Stores first name input
  String lastName = ""; // Stores last name input
  double age = 12; // Stores age input (default: 12)
  late Gender gender = Gender.male; // Stores selected gender (default: male)
  Set<String> rides = {}; // Stores selected rides (commented out in UI)

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Ensures content avoids system UI areas
      child: SingleChildScrollView(
        // Enables scrolling for the content
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Aligns children to the start
          children: <Widget>[
            // Top bar with theme configurator
            Container(
              margin: EdgeInsets.only(
                left: 12,
                right: 12,
                top: 10,
              ), // Margin for spacing
              child: TopBar(
                actions: <Widget>[ThemeConfigurator()],
              ), // Top bar with configurator
            ),
            // Main form container
            Neumorphic(
              margin: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ), // Margin around form
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ), // Padding inside form
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(12),
                ), // Rounded rectangle shape
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 8), // Spacing
                  // Sign Up button
                  Align(
                    alignment: Alignment.centerRight, // Aligns to the right
                    child: NeumorphicButton(
                      onPressed: _isButtonEnabled()
                          ? () {}
                          : null, // Enabled only if form is valid
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ), // Button padding
                      child: Text(
                        "Sign Up", // Button text
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ), // Bold text
                      ),
                    ),
                  ),
                  _AvatarField(), // Avatar display
                  SizedBox(height: 8), // Spacing
                  // First name input field
                  _TextField(
                    label: "First name",
                    hint: "",
                    onChanged: (firstName) {
                      setState(() {
                        this.firstName = firstName; // Updates first name
                      });
                    },
                  ),
                  SizedBox(height: 8), // Spacing
                  // Last name input field
                  _TextField(
                    label: "Last name",
                    hint: "",
                    onChanged: (lastName) {
                      setState(() {
                        this.lastName = lastName; // Updates last name
                      });
                    },
                  ),
                  SizedBox(height: 8), // Spacing
                  // Age slider field
                  _AgeField(
                    age: age,
                    onChanged: (age) {
                      setState(() {
                        this.age = age; // Updates age
                      });
                    },
                  ),
                  SizedBox(height: 8), // Spacing
                  // Gender selection field
                  _GenderField(
                    gender: gender,
                    onChanged: (gender) {
                      setState(() {
                        this.gender = gender; // Updates gender
                      });
                    },
                  ),
                  SizedBox(height: 8), // Spacing
                  // Commented-out Ride field
                  /*
                  _RideField(
                    rides: this.rides,
                    onChanged: (rides) {
                      setState(() {
                        this.rides = rides; // Updates rides
                      });
                    },
                  ),
                  SizedBox(height: 28), // Extra spacing
                  */
                  SizedBox(height: 20), // Final spacing
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Checks if the Sign Up button should be enabled
  bool _isButtonEnabled() {
    return firstName.isNotEmpty &&
        lastName.isNotEmpty; // Enabled if both names are filled
  }
}

// Widget for displaying an avatar icon
class _AvatarField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Neumorphic(
        padding: EdgeInsets.all(10), // Padding around icon
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.circle(), // Circular shape
          depth: NeumorphicTheme.embossDepth(
            context,
          ), // Emboss depth from theme
        ),
        child: Icon(
          Icons.insert_emoticon, // Smiley icon
          size: 120, // Large icon size
          color: Colors.black.withValues(alpha: 0.2), // Semi-transparent black
        ),
      ),
    );
  }
}

// Widget for selecting age via a slider
class _AgeField extends StatelessWidget {
  final double age; // Current age value
  final ValueChanged<double>? onChanged; // Callback for age changes

  const _AgeField({required this.age, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Aligns to the start
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 8,
          ), // Padding for label
          child: Text(
            "Age", // Label
            style: TextStyle(
              fontWeight: FontWeight.w700, // Bold text
              color: NeumorphicTheme.defaultTextColor(
                context,
              ), // Theme text color
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                ), // Padding for slider
                child: NeumorphicSlider(
                  min: 8, // Minimum age
                  max: 75, // Maximum age
                  value: age, // Current age
                  onChanged: (value) {
                    onChanged!(value); // Updates age
                  },
                ),
              ),
            ),
            Text("${age.floor()}"), // Displays age as integer
            SizedBox(width: 18), // Spacing
          ],
        ),
      ],
    );
  }
}

// Widget for text input fields
class _TextField extends StatefulWidget {
  final String label; // Field label
  final String hint; // Hint text
  final ValueChanged<String>? onChanged; // Callback for text changes

  const _TextField({required this.label, required this.hint, this.onChanged});

  @override
  __TextFieldState createState() => __TextFieldState();
}

// State class for managing text field state
class __TextFieldState extends State<_TextField> {
  late TextEditingController _controller; // Controller for text input

  @override
  void initState() {
    _controller = TextEditingController(
      text: widget.hint,
    ); // Initializes with hint text
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Aligns to the start
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 8,
          ), // Padding for label
          child: Text(
            widget.label, // Label
            style: TextStyle(
              fontWeight: FontWeight.w700, // Bold text
              color: NeumorphicTheme.defaultTextColor(
                context,
              ), // Theme text color
            ),
          ),
        ),
        Neumorphic(
          margin: EdgeInsets.only(
            left: 8,
            right: 8,
            top: 2,
            bottom: 4,
          ), // Margin around field
          style: NeumorphicStyle(
            depth: NeumorphicTheme.embossDepth(
              context,
            ), // Emboss depth from theme
            boxShape:
                NeumorphicBoxShape.stadium(), // Stadium (rounded ends) shape
          ),
          padding: EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 18,
          ), // Padding inside field
          child: TextField(
            onChanged: widget.onChanged, // Updates text
            controller: _controller, // Text controller
            decoration: InputDecoration.collapsed(
              hintText: widget.hint,
            ), // No border, only hint
          ),
        ),
      ],
    );
  }
}

// Widget for selecting gender via radio buttons
class _GenderField extends StatelessWidget {
  final Gender gender; // Current selected gender
  final ValueChanged<Gender> onChanged; // Callback for gender changes

  const _GenderField({required this.gender, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Aligns to the start
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 8,
          ), // Padding for label
          child: Text(
            "Gender", // Label
            style: TextStyle(
              fontWeight: FontWeight.w700, // Bold text
              color: NeumorphicTheme.defaultTextColor(
                context,
              ), // Theme text color
            ),
          ),
        ),
        Row(
          children: <Widget>[
            SizedBox(width: 12), // Spacing
            // Male radio button
            NeumorphicRadio(
              groupValue: gender, // Current group value
              padding: EdgeInsets.all(20), // Padding around icon
              style: NeumorphicRadioStyle(
                boxShape: NeumorphicBoxShape.circle(), // Circular shape
              ),
              value: Gender.male, // Radio value
              child: Icon(Icons.account_box), // Male icon
              onChanged: (value) => onChanged(Gender.male), // Updates gender
            ),
            SizedBox(width: 12), // Spacing
            // Female radio button
            NeumorphicRadio(
              groupValue: gender, // Current group value
              padding: EdgeInsets.all(20), // Padding around icon
              style: NeumorphicRadioStyle(
                boxShape: NeumorphicBoxShape.circle(), // Circular shape
              ),
              value: Gender.female, // Radio value
              child: Icon(Icons.pregnant_woman), // Female icon
              onChanged: (value) => onChanged(Gender.female), // Updates gender
            ),
            SizedBox(width: 12), // Spacing
            // Non-binary radio button
            NeumorphicRadio(
              groupValue: gender, // Current group value
              padding: EdgeInsets.all(20), // Padding around icon
              style: NeumorphicRadioStyle(
                boxShape: NeumorphicBoxShape.circle(), // Circular shape
              ),
              value: Gender.nonBinary, // Radio value
              child: Icon(Icons.supervised_user_circle), // Non-binary icon
              onChanged: (value) =>
                  onChanged(Gender.nonBinary), // Updates gender
            ),
            SizedBox(width: 18), // Spacing
          ],
        ),
      ],
    );
  }
}

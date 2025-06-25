// Importing the Neumorphic package for UI styling
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Root widget for the AppBar demo page
class AppBarWidgetPage extends StatelessWidget {
  // Constructor with optional key
  const AppBarWidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Builds a column containing different AppBar theme demonstrations
    return Column(
      mainAxisSize: MainAxisSize.max, // Maximizes column size
      children: [
        _FirstThemeWidgetPage(), // First themed AppBar
        _SecondThemeWidgetPage(), // Second themed AppBar
        _ThirdThemeWidgetPage(), // Third themed AppBar with custom size
        _CustomIcon(), // AppBar with custom icons and drawer
      ],
    );
  }
}

// -----------------------------
// First Theme AppBar Section
// -----------------------------
// Stateless widget for the first themed AppBar demonstration
class _FirstThemeWidgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Wraps the AppBar with a specific Neumorphic theme
    return NeumorphicTheme(
      themeMode: ThemeMode.light, // Sets the theme to light mode
      theme: NeumorphicThemeData(
        lightSource:
            LightSource.topLeft, // Defines light source for neumorphic effect
        accentColor: NeumorphicColors.accent, // Sets accent color
        appBarTheme: NeumorphicAppBarThemeData(
          buttonStyle: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.circle(), // Circular button shape
          ),
          textStyle: TextStyle(color: Colors.black54), // Text style for title
          iconTheme: IconThemeData(
            color: Colors.black54,
            size: 30,
          ), // Icon styling
        ),
        depth: 4, // Sets depth for neumorphic shadow
        intensity: 0.9, // Sets intensity of neumorphic effect
      ),
      child: AppBarPageUsingTheme(), // Renders the AppBar with this theme
    );
  }
}

// -----------------------------
// Second Theme AppBar Section
// -----------------------------
// Stateless widget for the second themed AppBar demonstration
class _SecondThemeWidgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Wraps the AppBar with a different Neumorphic theme
    return NeumorphicTheme(
      themeMode: ThemeMode.light, // Sets the theme to light mode
      theme: NeumorphicThemeData(
        lightSource:
            LightSource.topLeft, // Defines light source for neumorphic effect
        accentColor: NeumorphicColors.accent, // Sets accent color
        appBarTheme: NeumorphicAppBarThemeData(
          buttonStyle: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.beveled(
              BorderRadius.circular(12),
            ), // Beveled button shape
          ),
          textStyle: TextStyle(color: Colors.black54), // Text style for title
          iconTheme: IconThemeData(
            color: Colors.black54,
            size: 30,
          ), // Icon styling
        ),
        depth: 4, // Sets depth for neumorphic shadow
        intensity: 0.9, // Sets intensity of neumorphic effect
      ),
      child: AppBarPageUsingTheme(), // Renders the AppBar with this theme
    );
  }
}

// -----------------------------
// Third Theme AppBar Section
// -----------------------------
// Stateless widget for the third themed AppBar demonstration with custom size
class _ThirdThemeWidgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Wraps the AppBar with another Neumorphic theme
    return NeumorphicTheme(
      themeMode: ThemeMode.light, // Sets the theme to light mode
      theme: NeumorphicThemeData(
        lightSource:
            LightSource.topLeft, // Defines light source for neumorphic effect
        accentColor: NeumorphicColors.accent, // Sets accent color
        appBarTheme: NeumorphicAppBarThemeData(
          buttonStyle: NeumorphicStyle(
            color: Colors.black54, // Button background color
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(12),
            ), // Rounded rectangle shape
          ),
          textStyle: TextStyle(
            color: Colors.black54,
            fontSize: 20,
          ), // Text style for title
          iconTheme: IconThemeData(
            color: Colors.white,
            size: 20,
          ), // Icon styling
        ),
        depth: 4, // Sets depth for neumorphic shadow
        intensity: 0.9, // Sets intensity of neumorphic effect
      ),
      child: SizedAppBarPageUsingTheme(), // Renders the AppBar with custom size
    );
  }
}

// -----------------------------------
// Standard AppBar with Theme Section
// -----------------------------------
// Stateless widget for a standard AppBar using the applied theme
class AppBarPageUsingTheme extends StatelessWidget {
  const AppBarPageUsingTheme({super.key});

  @override
  Widget build(BuildContext context) {
    // Builds a sized scaffold with a Neumorphic AppBar
    return SizedBox(
      height: 100, // Fixed height for the AppBar section
      child: Scaffold(
        appBar: NeumorphicAppBar(
          title: Text("App bar"), // AppBar title
          actions: <Widget>[
            // Action button with add icon
            NeumorphicButton(child: Icon(Icons.add), onPressed: () {}),
          ],
        ),
        body: Container(), // Empty body
      ),
    );
  }
}

// ---------------------------------------
// Custom Sized AppBar with Theme Section
// ---------------------------------------
// Stateless widget for a custom-sized AppBar using the applied theme
class SizedAppBarPageUsingTheme extends StatelessWidget {
  const SizedAppBarPageUsingTheme({super.key});

  @override
  Widget build(BuildContext context) {
    // Builds a sized scaffold with a custom-sized Neumorphic AppBar
    return SizedBox(
      height: 100, // Fixed height for the AppBar section
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // Custom AppBar height
          child: NeumorphicAppBar(
            title: Text("App bar custom size"), // AppBar title
            actions: <Widget>[
              // Action button with add icon
              NeumorphicButton(child: Icon(Icons.add), onPressed: () {}),
            ],
          ),
        ),
        body: Container(), // Empty body
      ),
    );
  }
}

// --------------------------------
// First Theme Content Section
// --------------------------------
// Stateless widget for the first themed AppBar content (appears unused)
class FirstThemeContent extends StatelessWidget {
  const FirstThemeContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Builds a sized scaffold with a Neumorphic AppBar
    return SizedBox(
      height: 100, // Fixed height for the AppBar section
      child: Scaffold(
        appBar: NeumorphicAppBar(
          title: Text("App bar"), // AppBar title
          actions: <Widget>[
            // Action button with add icon
            NeumorphicButton(child: Icon(Icons.add), onPressed: () {}),
          ],
        ),
        body: Container(), // Empty body
      ),
    );
  }
}

// -----------------------
// Drawer Section
// -----------------------
// Stateless widget for a custom drawer with Neumorphic AppBar
class _MyDrawer extends StatelessWidget {
  final bool isLead; // Determines if drawer uses leading or trailing behavior

  // Constructor with optional isLead parameter
  const _MyDrawer({this.isLead = true});

  @override
  Widget build(BuildContext context) {
    // Builds a drawer with a Neumorphic AppBar
    return Drawer(
      child: Container(
        color: NeumorphicTheme.baseColor(context), // Uses theme's base color
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                height: NeumorphicAppBar.toolbarHeight, // Matches AppBar height
              ),
              child: NeumorphicAppBar(
                title: Text('Menu'), // Drawer title
                leading: isLead
                    ? NeumorphicBackButton() // Back button for leading drawer
                    : NeumorphicCloseButton(), // Close button for non-leading drawer
                actions: <Widget>[
                  // Action button with style icon
                  NeumorphicButton(child: Icon(Icons.style), onPressed: () {}),
                  isLead
                      ? NeumorphicCloseButton() // Close button for leading drawer
                      : NeumorphicBackButton(
                          forward: true,
                        ), // Forward back button for non-leading
                ],
              ),
            ),
            Spacer(), // Pushes content to the top
          ],
        ),
      ),
    );
  }
}

// -----------------------------
// Custom Icon AppBar Section
// -----------------------------
// Stateless widget for an AppBar with custom icons and drawer
class _CustomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Wraps the AppBar with a Neumorphic theme for custom icons
    return SizedBox(
      height: 300, // Fixed height for the section
      child: NeumorphicTheme(
        themeMode: ThemeMode.light, // Sets the theme to light mode
        theme: NeumorphicThemeData(
          lightSource:
              LightSource.topLeft, // Defines light source for neumorphic effect
          accentColor: NeumorphicColors.accent, // Sets accent color
          appBarTheme: NeumorphicAppBarThemeData(
            buttonStyle: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.circle(), // Circular button shape
              shape: NeumorphicShape.concave, // Concave button shape
              depth: 10, // Button depth
              intensity: 1, // Button intensity
            ),
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ), // Text style for title
            iconTheme: IconThemeData(
              color: Colors.green,
              size: 25,
            ), // Icon styling
            icons: NeumorphicAppBarIcons(
              menuIcon: Icon(
                Icons.list,
                color: Colors.pink,
              ), // Custom menu icon
              closeIcon: Icon(Icons.delete), // Custom close icon
              backIcon: Icon(Icons.reply), // Custom back icon
            ),
          ),
          depth: 2, // Sets depth for neumorphic shadow
          intensity: 0.5, // Sets intensity of neumorphic effect
        ),
        child: Scaffold(
          appBar: NeumorphicAppBar(
            title: Text("Custom icons + drawer"),
          ), // AppBar with custom title
          endDrawer: _MyDrawer(isLead: false), // Drawer on the right side
          body: Container(), // Empty body
        ),
      ),
    );
  }
}

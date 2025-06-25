// Importing the Neumorphic package for UI styling
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Root widget for the Audio Player sample demo page
class AudioPlayerSample extends StatefulWidget {
  // Constructor with optional key
  const AudioPlayerSample({super.key});

  @override
  State<AudioPlayerSample> createState() => _AudioPlayerSampleState();
}

// State class for applying the Neumorphic theme and wrapping the content page
class _AudioPlayerSampleState extends State<AudioPlayerSample> {
  @override
  Widget build(BuildContext context) {
    // Wraps the page with NeumorphicTheme for consistent styling
    return NeumorphicTheme(
      themeMode: ThemeMode.light, // Sets initial theme to light mode
      theme: NeumorphicThemeData(
        defaultTextColor: Color(0xFF3E3E3E), // Dark grey text color
        baseColor: Color(0xFFDDE6E8), // Light blue-grey base color
        intensity: 0.5, // Intensity of neumorphic effect
        lightSource: LightSource.topLeft, // Light source from top-left
        depth: 10, // Depth for neumorphic shadow
      ),
      darkTheme: neumorphicDefaultDarkTheme.copyWith(
        defaultTextColor: Colors.white70, // Light grey text for dark theme
      ),
      child: _Page(), // Renders the main page content
    );
  }
}

// Container widget for the layout and UI of the Audio Player sample page
class _Page extends StatefulWidget {
  @override
  __PageState createState() => __PageState();
}

// State class for managing the page's UI and state
class __PageState extends State<_Page> {
  bool _useDark = false; // Toggles between light and dark theme

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // Ensures content avoids system UI areas
        child: NeumorphicBackground(
          // Applies neumorphic background
          child: Column(
            children: <Widget>[
              SizedBox(height: 14), // Spacing
              _buildTopBar(context), // Top bar with navigation and theme toggle
              SizedBox(height: 80), // Spacing
              _buildImage(context), // Album artwork
              SizedBox(height: 30), // Spacing
              _buildTitle(context), // Song title and artist
              SizedBox(height: 30), // Spacing
              _buildSeekBar(context), // Seek bar with time indicators
              SizedBox(height: 30), // Spacing
              _buildControlsBar(context), // Playback controls
            ],
          ),
        ),
      ),
    );
  }

  // Builds the top bar with back, title, and theme toggle
  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16), // Horizontal padding
      child: Stack(
        alignment: Alignment.center, // Centers content
        children: <Widget>[
          // Back button
          Align(
            alignment: Alignment.centerLeft,
            child: NeumorphicButton(
              padding: const EdgeInsets.all(18.0), // Button padding
              onPressed: () {
                Navigator.of(context).pop(); // Navigates back
              },
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat, // Flat shape
                boxShape: NeumorphicBoxShape.circle(), // Circular shape
              ),
              child: Icon(
                Icons.navigate_before,
                color: _iconsColor(),
              ), // Back icon
            ),
          ),
          // Title
          Align(
            alignment: Alignment.center,
            child: Text(
              "Now Playing", // Page title
              style: TextStyle(
                color: NeumorphicTheme.defaultTextColor(
                  context,
                ), // Theme text color
              ),
            ),
          ),
          // Theme toggle button (favorite icon as placeholder)
          Align(
            alignment: Alignment.centerRight,
            child: NeumorphicButton(
              padding: const EdgeInsets.all(18.0), // Button padding
              onPressed: () {
                setState(() {
                  _useDark = !_useDark; // Toggles theme
                  NeumorphicTheme.of(context)?.themeMode = _useDark
                      ? ThemeMode.dark
                      : ThemeMode.light; // Updates theme
                });
              },
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat, // Flat shape
                boxShape: NeumorphicBoxShape.circle(), // Circular shape
              ),
              child: Icon(
                Icons.favorite_border,
                color: _iconsColor(),
              ), // Favorite icon
            ),
          ),
        ],
      ),
    );
  }

  // Builds the album artwork
  Widget _buildImage(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.circle(),
      ), // Circular shape
      child: SizedBox(
        height: 200, // Fixed height
        width: 200, // Fixed width
        child: Image.asset(
          "assets/images/weeknd.jpg", // Album artwork image
          fit: BoxFit.cover, // Covers the area
        ),
      ),
    );
  }

  // Builds the song title and artist
  Widget _buildTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // Centers content
      children: <Widget>[
        Text(
          "Blinding Lights", // Song title
          style: TextStyle(
            fontWeight: FontWeight.w800, // Bold text
            fontSize: 34, // Large font size
            color: NeumorphicTheme.defaultTextColor(
              context,
            ), // Theme text color
          ),
        ),
        const SizedBox(height: 4), // Spacing
        Text(
          "The Weeknd", // Artist name
          style: TextStyle(
            fontWeight: FontWeight.w400, // Regular text
            fontSize: 14, // Small font size
            color: NeumorphicTheme.defaultTextColor(
              context,
            ), // Theme text color
          ),
        ),
      ],
    );
  }

  // Builds the seek bar with time indicators
  Widget _buildSeekBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 28.0,
      ), // Horizontal padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Centers content
        children: <Widget>[
          Stack(
            children: <Widget>[
              // Current time
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "2.00", // Hardcoded current time
                  style: TextStyle(
                    color: NeumorphicTheme.defaultTextColor(
                      context,
                    ), // Theme text color
                  ),
                ),
              ),
              // Total time
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "3.14", // Hardcoded total time
                  style: TextStyle(
                    color: NeumorphicTheme.defaultTextColor(
                      context,
                    ), // Theme text color
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8), // Spacing
          NeumorphicSlider(
            height: 8, // Slider height
            min: 0, // Minimum value
            max: 314, // Maximum value (3:14 in seconds)
            value: 100, // Current value (hardcoded)
            onChanged: (value) {}, // Empty callback
          ),
        ],
      ),
    );
  }

  // Builds the playback controls (previous, play, next)
  Widget _buildControlsBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Centers buttons
      children: <Widget>[
        // Previous track button
        NeumorphicButton(
          padding: const EdgeInsets.all(18.0), // Button padding
          onPressed: () {}, // Empty callback
          style: NeumorphicStyle(
            shape: NeumorphicShape.flat, // Flat shape
            boxShape: NeumorphicBoxShape.circle(), // Circular shape
          ),
          child: Icon(
            Icons.skip_previous,
            color: _iconsColor(),
          ), // Previous icon
        ),
        const SizedBox(width: 12), // Spacing
        // Play button
        NeumorphicButton(
          padding: const EdgeInsets.all(24.0), // Larger padding for play button
          onPressed: () {}, // Empty callback
          style: NeumorphicStyle(
            shape: NeumorphicShape.flat, // Flat shape
            boxShape: NeumorphicBoxShape.circle(), // Circular shape
          ),
          child: Icon(
            Icons.play_arrow,
            size: 42,
            color: _iconsColor(),
          ), // Play icon
        ),
        const SizedBox(width: 12), // Spacing
        // Next track button
        NeumorphicButton(
          padding: const EdgeInsets.all(18.0), // Button padding
          onPressed: () {}, // Empty callback
          style: NeumorphicStyle(
            shape: NeumorphicShape.flat, // Flat shape
            boxShape: NeumorphicBoxShape.circle(), // Circular shape
          ),
          child: Icon(Icons.skip_next, color: _iconsColor()), // Next icon
        ),
      ],
    );
  }

  // Determines icon color based on theme
  Color? _iconsColor() {
    final theme = NeumorphicTheme.of(context);
    if (theme!.isUsingDark) {
      return theme.current?.accentColor; // Accent color for dark theme
    } else {
      return null; // Default color for light theme
    }
  }
}

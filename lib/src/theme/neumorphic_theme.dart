// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Export related theme classes for external use
export 'inherited_neumorphic_theme.dart';
export 'theme.dart';
export 'theme_wrapper.dart';

/// The NeumorphicTheme (provider)
/// 1. Defines the used neumorphic theme used in child widgets
///
///   @see NeumorphicThemeData
///
///   NeumorphicTheme(
///     theme: NeumorphicThemeData(...),
///     darkTheme: NeumorphicThemeData(...),
///     currentTheme: CurrentTheme.LIGHT,
///     child: ...
///
/// 2. Provide by static methods the current theme
///
///   NeumorphicThemeData theme = NeumorphicTheme.getCurrentTheme(context);
///
/// 3. Provide by static methods the current theme's colors
///
///   Color baseColor = NeumorphicTheme.baseColor(context);
///   Color accent = NeumorphicTheme.accentColor(context);
///   Color variant = NeumorphicTheme.variantColor(context);
///
/// 4. Tells if the current theme is dark
///
///   bool dark = NeumorphicTheme.isUsingDark(context);
///
/// 5. Provides a way to update the current theme
///
///   NeumorphicTheme.of(context).updateCurrentTheme(
///     NeumorphicThemeData(
///       /* new values */
///     )
///   )
///
class NeumorphicTheme extends StatefulWidget {
  // Light theme configuration
  final NeumorphicThemeData theme;
  // Dark theme configuration
  final NeumorphicThemeData darkTheme;
  // The child widget that will inherit the theme
  final Widget child;
  // Theme mode (system, light, or dark)
  final ThemeMode themeMode;

  // Constructor for NeumorphicTheme with default values
  const NeumorphicTheme({
    super.key,
    required this.child,
    this.theme = neumorphicDefaultTheme,
    this.darkTheme = neumorphicDefaultDarkTheme,
    this.themeMode = ThemeMode.system,
  });

  @override
  _NeumorphicThemeState createState() => _NeumorphicThemeState();

  // Retrieves the NeumorphicThemeInherited widget from the context
  static NeumorphicThemeInherited? of(BuildContext context) {
    try {
      return context
          .dependOnInheritedWidgetOfExactType<NeumorphicThemeInherited>();
    } catch (t) {
      return null;
    }
  }

  // Updates the current theme using a provided updater function
  static void update(BuildContext context, NeumorphicThemeUpdater updater) {
    final theme = of(context);
    if (theme == null) return;
    return theme.update(updater);
  }

  // Checks if the current theme is dark
  static bool isUsingDark(BuildContext context) {
    final theme = of(context);
    if (theme == null) return false;
    return theme.isUsingDark;
  }

  // Gets the accent color from the current theme
  static Color accentColor(BuildContext context) {
    return currentTheme(context).accentColor;
  }

  // Gets the base color from the current theme
  static Color baseColor(BuildContext context) {
    return currentTheme(context).baseColor;
  }

  // Gets the variant color from the current theme
  static Color variantColor(BuildContext context) {
    return currentTheme(context).variantColor;
  }

  // Gets the disabled color from the current theme
  static Color disabledColor(BuildContext context) {
    return currentTheme(context).disabledColor;
  }

  // Gets the intensity value from the current theme
  static double? intensity(BuildContext context) {
    return currentTheme(context).intensity;
  }

  // Gets the depth value from the current theme
  static double? depth(BuildContext context) {
    return currentTheme(context).depth;
  }

  // Calculates the emboss depth (negative of the current theme's depth)
  static double? embossDepth(BuildContext context) {
    return -currentTheme(context).depth.abs();
  }

  // Gets the default text color from the current theme
  static Color defaultTextColor(BuildContext context) {
    return currentTheme(context).defaultTextColor;
  }

  // Retrieves the current theme, falling back to default if none is found
  static NeumorphicThemeData currentTheme(BuildContext context) {
    final provider = NeumorphicTheme.of(context);
    if (provider == null) return neumorphicDefaultTheme;
    return provider.current == null
        ? neumorphicDefaultTheme
        : provider.current!;
  }
}

// Applies depth based on theme settings and provided parameters
double applyThemeDepthEnable({
  required BuildContext context,
  required bool styleEnableDepth,
  required double depth,
}) {
  // Get the current theme
  final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);
  // Wrap depth with theme data logic
  return wrapDepthWithThemeData(
    themeData: theme,
    styleEnableDepth: styleEnableDepth,
    depth: depth,
  );
}

// Wraps depth logic based on theme's disableDepth setting
double wrapDepthWithThemeData({
  required NeumorphicThemeData themeData,
  required bool styleEnableDepth,
  required double depth,
}) {
  // Return 0 if depth is disabled in the theme, otherwise return the provided depth
  if (themeData.disableDepth) {
    return 0;
  } else {
    return depth;
  }
}

// State class for NeumorphicTheme to manage theme updates
class _NeumorphicThemeState extends State<NeumorphicTheme> {
  // Theme wrapper to hold light/dark theme and mode
  late ThemeWrapper _themeHost;

  @override
  void initState() {
    super.initState();
    // Initialize theme wrapper with widget's theme properties
    _themeHost = ThemeWrapper(
      theme: widget.theme,
      themeMode: widget.themeMode,
      darkTheme: widget.darkTheme,
    );
  }

  @override
  void didUpdateWidget(NeumorphicTheme oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update theme wrapper when widget properties change
    setState(() {
      _themeHost = ThemeWrapper(
        theme: widget.theme,
        themeMode: widget.themeMode,
        darkTheme: widget.darkTheme,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Provide theme data to child widgets via NeumorphicThemeInherited
    return NeumorphicThemeInherited(
      value: _themeHost,
      onChanged: (value) {
        // Update state when theme wrapper changes
        setState(() {
          _themeHost = value;
        });
      },
      child: widget.child,
    );
  }
}

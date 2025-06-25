// ignore_for_file: overridden_fields

import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

export 'theme.dart';
export 'theme_wrapper.dart';

// Type definition for a function that updates the NeumorphicThemeData
typedef NeumorphicThemeUpdater =
    NeumorphicThemeData Function(NeumorphicThemeData? current);

// Inherited widget for providing neumorphic theme data to the widget tree
class NeumorphicThemeInherited extends InheritedWidget {
  // The child widget that this inherited widget wraps
  @override
  final Widget child;
  // The current theme wrapper containing light and dark theme data
  final ThemeWrapper value;
  // Callback triggered when the theme changes
  final ValueChanged<ThemeWrapper> onChanged;

  // Constructor for initializing the inherited widget
  const NeumorphicThemeInherited({
    super.key,
    required this.child, // Child widget to be wrapped
    required this.value, // Theme wrapper instance
    required this.onChanged, // Callback for theme changes
  }) : super(child: child);

  // Determines if dependent widgets should be notified of updates
  @override
  bool updateShouldNotify(NeumorphicThemeInherited old) => value != old.value;

  // Gets the current theme data (light or dark based on useDark)
  NeumorphicThemeData? get current {
    return value.current;
  }

  // Indicates whether the dark theme is currently in use
  bool get isUsingDark {
    return value.useDark;
  }

  // Gets the current theme mode (light, dark, or system)
  ThemeMode get themeMode => value.themeMode;

  // Sets the theme mode and notifies listeners of the change
  set themeMode(ThemeMode currentTheme) {
    onChanged(value.copyWith(currentTheme: currentTheme)); // Update theme mode
  }

  // Updates the current theme (light or dark) with a new NeumorphicThemeData
  void updateCurrentTheme(NeumorphicThemeData update) {
    if (value.useDark) {
      // Update dark theme if dark mode is active
      final newValue = value.copyWith(darkTheme: update);
      onChanged(newValue); // Notify listeners of the new theme
    } else {
      // Update light theme if light mode is active
      final newValue = value.copyWith(theme: update);
      onChanged(newValue); // Notify listeners of the new theme
    }
  }

  // Updates the current theme using a provided theme updater function
  void update(NeumorphicThemeUpdater themeUpdater) {
    // Apply the updater function to get the new theme data
    final update = themeUpdater(value.current);
    if (value.useDark) {
      // Update dark theme if dark mode is active
      final newValue = value.copyWith(darkTheme: update);
      onChanged(newValue); // Notify listeners of the new theme
    } else {
      // Update light theme if light mode is active
      final newValue = value.copyWith(theme: update);
      onChanged(newValue); // Notify listeners of the new theme
    }
  }
}

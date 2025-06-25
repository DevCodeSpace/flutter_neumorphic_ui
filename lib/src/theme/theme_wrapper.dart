import 'dart:ui';

import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Export the theme definition for external use
export 'theme.dart';

/// An immutable container for the NeumorphicTheme.
/// Stores the current theme definition and makes it accessible to child widgets via an InheritedWidget.
class ThemeWrapper {
  // Light theme configuration
  final NeumorphicThemeData theme;
  // Dark theme configuration, nullable if not provided
  final NeumorphicThemeData? darkTheme;
  // Theme mode (system, light, or dark)
  final ThemeMode themeMode;

  // Constructor for ThemeWrapper with default theme mode set to system
  const ThemeWrapper({
    required this.theme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
  });

  // Determines if the dark theme should be used based on themeMode or platform brightness
  bool get useDark =>
      // Forced to use dark theme if themeMode is explicitly set to dark
      themeMode == ThemeMode.dark ||
      // Use dark theme if themeMode is system and platform brightness is dark
      (themeMode == ThemeMode.system &&
          PlatformDispatcher.instance.platformBrightness == Brightness.dark);

  // Returns the current theme based on useDark; returns darkTheme if useDark is true, otherwise returns theme
  NeumorphicThemeData? get current {
    if (useDark) {
      return darkTheme;
    } else {
      return theme;
    }
  }

  // Overrides equality operator to compare ThemeWrapper instances
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeWrapper &&
          runtimeType == other.runtimeType &&
          theme == other.theme &&
          darkTheme == other.darkTheme &&
          themeMode == other.themeMode;

  // Generates a hash code based on theme, darkTheme, and themeMode
  @override
  int get hashCode => theme.hashCode ^ darkTheme.hashCode ^ themeMode.hashCode;

  // Creates a new ThemeWrapper with updated values, preserving existing ones if not provided
  ThemeWrapper copyWith({
    NeumorphicThemeData? theme,
    NeumorphicThemeData? darkTheme,
    ThemeMode? currentTheme,
  }) {
    return ThemeWrapper(
      theme: theme ?? this.theme,
      darkTheme: darkTheme ?? this.darkTheme,
      themeMode: currentTheme ?? themeMode,
    );
  }
}

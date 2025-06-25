import 'dart:io';

import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Immutable theme data class for configuring a neumorphic app bar
@immutable
class NeumorphicAppBarThemeData {
  // Background color of the app bar
  final Color color;
  // Theme data for icons in the app bar
  final IconThemeData? iconTheme;
  // Neumorphic style for app bar buttons
  final NeumorphicStyle buttonStyle;
  // Padding for app bar buttons
  final EdgeInsets buttonPadding;
  // Whether the title should be centered
  final bool? centerTitle;
  // Text style for the app bar title
  final TextStyle? textStyle;
  // Icons configuration for the app bar
  final NeumorphicAppBarIcons icons;

  // Constructor for initializing the app bar theme data
  const NeumorphicAppBarThemeData({
    this.color = Colors.transparent, // Default to transparent background
    this.iconTheme, // Optional icon theme
    this.textStyle, // Optional text style for title
    this.buttonStyle =
        const NeumorphicStyle(), // Default neumorphic button style
    this.centerTitle, // Optional title centering
    this.buttonPadding = const EdgeInsets.all(0), // Default button padding
    this.icons = const NeumorphicAppBarIcons(), // Default icons configuration
  });
}

// Class for managing icons used in a neumorphic app bar
class NeumorphicAppBarIcons {
  // Icon for closing the app bar
  final Icon closeIcon;
  // Icon for opening the menu
  final Icon menuIcon;
  // Private back icon, can be null
  final Icon? _backIcon;
  // Private forward icon, can be null
  final Icon? _forwardIcon;

  // Constructor for initializing app bar icons
  const NeumorphicAppBarIcons({
    this.menuIcon = const Icon(Icons.menu), // Default menu icon
    this.closeIcon = const Icon(Icons.close), // Default close icon
    Icon? backIcon, // Optional back icon
    Icon? forwardIcon, // Optional forward icon
  }) : _backIcon = backIcon,
       _forwardIcon = forwardIcon;

  // Returns the back icon, using platform-specific default if null
  Icon get backIcon => _backIcon ?? _getBackIcon;
  // Provides platform-oriented back icon (iOS/macOS vs. others)
  Icon get _getBackIcon => Platform.isIOS || Platform.isMacOS
      ? const Icon(Icons.arrow_back_ios) // iOS/macOS back icon
      : const Icon(Icons.arrow_back); // Default back icon for other platforms

  // Returns the forward icon, using platform-specific default if null
  Icon get forwardIcon => _forwardIcon ?? _getForwardIcon;
  // Provides platform-oriented forward icon (iOS/macOS vs. others)
  Icon get _getForwardIcon => Platform.isIOS || Platform.isMacOS
      ? const Icon(Icons.arrow_forward_ios) // iOS/macOS forward icon
      : const Icon(
          Icons.arrow_forward,
        ); // Default forward icon for other platforms

  // Creates a copy of the icon set with optional overrides
  NeumorphicAppBarIcons copyWith({
    Icon? backIcon,
    Icon? closeIcon,
    Icon? menuIcon,
    Icon? forwardIcon,
  }) {
    return NeumorphicAppBarIcons(
      backIcon: backIcon ?? this.backIcon, // Use provided or existing back icon
      closeIcon:
          closeIcon ?? this.closeIcon, // Use provided or existing close icon
      menuIcon: menuIcon ?? this.menuIcon, // Use provided or existing menu icon
      forwardIcon:
          forwardIcon ??
          this.forwardIcon, // Use provided or existing forward icon
    );
  }

  // Equality comparison for NeumorphicAppBarIcons objects
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NeumorphicAppBarIcons &&
        other.backIcon == backIcon &&
        other.closeIcon == closeIcon &&
        other.menuIcon == menuIcon &&
        other.forwardIcon == forwardIcon;
  }

  // Generates hash code for the icon set
  @override
  int get hashCode =>
      backIcon.hashCode ^
      closeIcon.hashCode ^
      menuIcon.hashCode ^
      forwardIcon.hashCode;

  // String representation of the icon set
  @override
  String toString() =>
      'NeumorphicAppBarIcons(backIcon: $backIcon, closeIcon: $closeIcon, menuIcon: $menuIcon, forwardIcon: $forwardIcon)';
}

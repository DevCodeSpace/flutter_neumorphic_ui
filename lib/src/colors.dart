import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

/// Defines default colors used in Neumorphic theme & shadows generators
@immutable
class NeumorphicColors {
  static const background = Color(
    0xFFDDE6E8,
  ); // Default background color for light theme
  static const accent = Color(
    0xFF2196F3,
  ); // Default accent color for light theme
  static const variant = Color(
    0xFF00BCD4,
  ); // Default variant color for light theme
  static const disabled = Color(
    0xFF9E9E9E,
  ); // Default disabled color for light theme

  static const darkBackground = Color(
    0xFF2D2F2F,
  ); // Default background color for dark theme
  static const darkAccent = Color(
    0xFF4CAF50,
  ); // Default accent color for dark theme
  static const darkVariant = Color(
    0xFF607D8B,
  ); // Default variant color for dark theme
  static const darkDisabled = Color(
    0xB3FFFFFF,
  ); // Default disabled color for dark theme
  static const darkDefaultTextColor = Color(
    0xB3FFFFFF,
  ); // Default text color for dark theme

  static const Color defaultBorder = Color(
    0x33000000,
  ); // Default border color for light theme
  static const Color darkDefaultBorder = Color(
    0x33FFFFFF,
  ); // Default border color for dark theme

  static const Color decorationMaxWhiteColor = Color(
    0xFFFFFFFF,
  ); // Maximum white color for decoration (intensity = 1)
  static const Color decorationMaxDarkColor = Color(
    0x8A000000,
  ); // Maximum dark color for decoration (intensity = 1)

  static const Color embossMaxWhiteColor = Color(
    0x99FFFFFF,
  ); // Maximum white color for emboss effect (intensity = 1)
  static const Color embossMaxDarkColor = Color(
    0x73000000,
  ); // Maximum dark color for emboss effect (intensity = 1)

  static const Color _gradientShaderDarkColor = Color(
    0x8A000000,
  ); // Dark color for gradient shader
  static const Color _gradientShaderWhiteColor = Color(
    0xFFFFFFFF,
  ); // White color for gradient shader

  static const Color defaultTextColor = Color(
    0xFF000000,
  ); // Default text color for light theme

  const NeumorphicColors._(); // Private constructor to prevent instantiation

  /// Applies intensity to the opacity of a decoration white color
  static Color decorationWhiteColor(Color color, {required double intensity}) {
    // intensity acts on opacity
    return _applyPercentageOnOpacity(maxColor: color, percent: intensity);
  }

  /// Applies intensity to the opacity of a decoration dark color
  static Color decorationDarkColor(Color color, {required double intensity}) {
    // intensity acts on opacity
    return _applyPercentageOnOpacity(maxColor: color, percent: intensity);
  }

  /// Applies intensity to the opacity of an emboss white color
  static Color embossWhiteColor(Color color, {required double intensity}) {
    // intensity acts on opacity
    return _applyPercentageOnOpacity(maxColor: color, percent: intensity);
  }

  /// Applies intensity to the opacity of an emboss dark color
  static Color embossDarkColor(Color color, {required double intensity}) {
    // intensity acts on opacity
    return _applyPercentageOnOpacity(maxColor: color, percent: intensity);
  }

  /// Applies intensity to the opacity of a gradient shader dark color
  static Color gradientShaderDarkColor({required double intensity}) {
    // intensity acts on opacity
    return _applyPercentageOnOpacity(
      maxColor: NeumorphicColors._gradientShaderDarkColor,
      percent: intensity,
    );
  }

  /// Applies intensity to the opacity of a gradient shader white color
  static Color gradientShaderWhiteColor({required double intensity}) {
    // intensity acts on opacity
    return _applyPercentageOnOpacity(
      maxColor: NeumorphicColors._gradientShaderWhiteColor,
      percent: intensity,
    );
  }

  /// Adjusts the opacity of a color based on the given intensity percentage
  static Color _applyPercentageOnOpacity({
    required Color maxColor,
    required double percent,
  }) {
    final maxOpacity = maxColor.a; // Gets the maximum opacity of the color
    const maxIntensity = Neumorphic.maxIntensity; // Maximum intensity value
    final newOpacity =
        percent * maxOpacity / maxIntensity; // Calculates new opacity
    final newColor = maxColor.withValues(
      alpha: newOpacity,
    ); // Applies new opacity to the color
    return newColor;
  }
}

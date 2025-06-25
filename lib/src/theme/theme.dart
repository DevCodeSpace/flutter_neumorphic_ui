import 'dart:ui';

import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

export '../colors.dart';
export '../light_source.dart';
export '../shape.dart';

//region theme
// Default values for neumorphic theme properties
const double _defaultDepth = 4; // Default depth for shadows
const double _defaultIntensity = 0.7; // Default intensity for shadows
const Color _defaultAccent = NeumorphicColors.accent; // Default accent color
const Color _defaultVariant = NeumorphicColors.variant; // Default variant color
const Color _defaultDisabledColor =
    NeumorphicColors.disabled; // Default disabled color
const Color _defaultTextColor =
    NeumorphicColors.defaultTextColor; // Default text color
const LightSource _defaultLightSource =
    LightSource.topLeft; // Default light source position
const Color _defaultBaseColor =
    NeumorphicColors.background; // Default base color
const double _defaultBorderSize = 0.3; // Default border width

/// Used with the NeumorphicTheme
///
/// ```
/// NeumorphicTheme(
///   theme: NeumorphicThemeData(...)
///   darkTheme: : NeumorphicThemeData(...)
///   child: ...
/// )`
/// ``
///
/// Contains all default values used in child Neumorphic Elements as
/// default colors : baseColor, accentColor, variantColor
/// default depth & intensities, used to generate white / dark shadows
/// default lightsource, used to calculate the angle of the shadow
/// @see [LightSource]
///
@immutable
class NeumorphicThemeData {
  // Base color for the theme
  final Color baseColor;
  // Accent color for the theme
  final Color accentColor;
  // Variant color for the theme
  final Color variantColor;
  // Disabled color for the theme
  final Color disabledColor;

  // Light shadow color for flat/convex/concave shapes
  final Color shadowLightColor;
  // Dark shadow color for flat/convex/concave shapes
  final Color shadowDarkColor;
  // Light shadow color for embossed shapes
  final Color shadowLightColorEmboss;
  // Dark shadow color for embossed shapes
  final Color shadowDarkColorEmboss;

  // Private box shape, nullable
  final NeumorphicBoxShape? _boxShape;
  // Public getter for box shape, defaults to rounded rectangle with 8px radius
  NeumorphicBoxShape get boxShape =>
      _boxShape ?? NeumorphicBoxShape.roundRect(BorderRadius.circular(8));
  // Border color for elements
  final Color borderColor;
  // Border width for elements
  final double borderWidth;

  // Default text color for the theme
  final Color defaultTextColor;
  // Private depth value
  final double _depth;
  // Private intensity value
  final double _intensity;
  // Light source position for shadow calculations
  final LightSource lightSource;
  // Flag to disable depth effects
  final bool disableDepth;

  // Default text theme for the app
  final TextTheme textTheme;

  // Default button style for the app
  final NeumorphicStyle? buttonStyle;

  // Default icon theme for the app
  final IconThemeData iconTheme;
  // App bar theme configuration
  final NeumorphicAppBarThemeData appBarTheme;

  /// Clamps depth to min/max neumorphic constants
  double get depth => _depth.clamp(Neumorphic.minDepth, Neumorphic.maxDepth);

  /// Clamps intensity to min/max neumorphic constants
  double get intensity =>
      _intensity.clamp(Neumorphic.minIntensity, Neumorphic.maxIntensity);

  // Constructor for light theme
  const NeumorphicThemeData({
    this.baseColor = _defaultBaseColor,
    double depth = _defaultDepth,
    NeumorphicBoxShape? boxShape,
    double intensity = _defaultIntensity,
    this.accentColor = _defaultAccent,
    this.variantColor = _defaultVariant,
    this.disabledColor = _defaultDisabledColor,
    this.shadowLightColor = NeumorphicColors.decorationMaxWhiteColor,
    this.shadowDarkColor = NeumorphicColors.decorationMaxDarkColor,
    this.shadowLightColorEmboss = NeumorphicColors.embossMaxWhiteColor,
    this.shadowDarkColorEmboss = NeumorphicColors.embossMaxDarkColor,
    this.defaultTextColor = _defaultTextColor,
    this.lightSource = _defaultLightSource,
    this.textTheme = const TextTheme(),
    this.iconTheme = const IconThemeData(),
    this.buttonStyle,
    this.appBarTheme = const NeumorphicAppBarThemeData(),
    this.borderColor = NeumorphicColors.defaultBorder,
    this.borderWidth = _defaultBorderSize,
    this.disableDepth = false,
  }) : _depth = depth,
       _boxShape = boxShape,
       _intensity = intensity;

  // Constructor for dark theme
  const NeumorphicThemeData.dark({
    this.baseColor = NeumorphicColors.darkBackground,
    double depth = _defaultDepth,
    NeumorphicBoxShape? boxShape,
    double intensity = _defaultIntensity,
    this.accentColor = _defaultAccent,
    this.textTheme = const TextTheme(),
    this.buttonStyle,
    this.iconTheme = const IconThemeData(),
    this.appBarTheme = const NeumorphicAppBarThemeData(),
    this.variantColor = NeumorphicColors.darkVariant,
    this.disabledColor = NeumorphicColors.darkDisabled,
    this.shadowLightColor = NeumorphicColors.decorationMaxWhiteColor,
    this.shadowDarkColor = NeumorphicColors.decorationMaxDarkColor,
    this.shadowLightColorEmboss = NeumorphicColors.embossMaxWhiteColor,
    this.shadowDarkColorEmboss = NeumorphicColors.embossMaxDarkColor,
    this.defaultTextColor = NeumorphicColors.darkDefaultTextColor,
    this.lightSource = _defaultLightSource,
    this.borderColor = NeumorphicColors.darkDefaultBorder,
    this.borderWidth = _defaultBorderSize,
    this.disableDepth = false,
  }) : _depth = depth,
       _boxShape = boxShape,
       _intensity = intensity;

  // String representation of the theme data
  @override
  String toString() {
    return 'NeumorphicTheme{baseColor: $baseColor, boxShape: $boxShape, disableDepth: $disableDepth, accentColor: $accentColor, variantColor: $variantColor, disabledColor: $disabledColor, _depth: $_depth, intensity: $intensity, lightSource: $lightSource}';
  }

  // Equality comparison for NeumorphicThemeData objects
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicThemeData &&
          runtimeType == other.runtimeType &&
          baseColor == other.baseColor &&
          boxShape == other.boxShape &&
          textTheme == other.textTheme &&
          iconTheme == other.iconTheme &&
          buttonStyle == other.buttonStyle &&
          appBarTheme == other.appBarTheme &&
          accentColor == other.accentColor &&
          shadowDarkColor == other.shadowDarkColor &&
          shadowLightColor == other.shadowLightColor &&
          shadowDarkColorEmboss == other.shadowDarkColorEmboss &&
          shadowLightColorEmboss == other.shadowLightColorEmboss &&
          disabledColor == other.disabledColor &&
          variantColor == other.variantColor &&
          disableDepth == other.disableDepth &&
          defaultTextColor == other.defaultTextColor &&
          borderWidth == other.borderWidth &&
          borderColor == other.borderColor &&
          _depth == other._depth &&
          _intensity == other._intensity &&
          lightSource == other.lightSource;

  // Generates hash code for the theme data
  @override
  int get hashCode =>
      baseColor.hashCode ^
      textTheme.hashCode ^
      iconTheme.hashCode ^
      buttonStyle.hashCode ^
      appBarTheme.hashCode ^
      accentColor.hashCode ^
      variantColor.hashCode ^
      disabledColor.hashCode ^
      shadowDarkColor.hashCode ^
      shadowLightColor.hashCode ^
      shadowDarkColorEmboss.hashCode ^
      shadowLightColorEmboss.hashCode ^
      defaultTextColor.hashCode ^
      disableDepth.hashCode ^
      borderWidth.hashCode ^
      borderColor.hashCode ^
      _depth.hashCode ^
      boxShape.hashCode ^
      _intensity.hashCode ^
      lightSource.hashCode;

  /// Creates a copy of this theme with optional new values
  NeumorphicThemeData copyWith({
    Color? baseColor,
    Color? accentColor,
    Color? variantColor,
    Color? disabledColor,
    Color? shadowLightColor,
    Color? shadowDarkColor,
    Color? shadowLightColorEmboss,
    Color? shadowDarkColorEmboss,
    Color? defaultTextColor,
    NeumorphicBoxShape? boxShape,
    TextTheme? textTheme,
    NeumorphicStyle? buttonStyle,
    IconThemeData? iconTheme,
    NeumorphicAppBarThemeData? appBarTheme,
    NeumorphicStyle? defaultStyle,
    bool? disableDepth,
    double? depth,
    double? intensity,
    Color? borderColor,
    double? borderSize,
    LightSource? lightSource,
  }) {
    return NeumorphicThemeData(
      baseColor: baseColor ?? this.baseColor,
      textTheme: textTheme ?? this.textTheme,
      iconTheme: iconTheme ?? this.iconTheme,
      buttonStyle: buttonStyle ?? this.buttonStyle,
      boxShape: boxShape ?? this.boxShape,
      appBarTheme: appBarTheme ?? this.appBarTheme,
      accentColor: accentColor ?? this.accentColor,
      variantColor: variantColor ?? this.variantColor,
      disabledColor: disabledColor ?? this.disabledColor,
      defaultTextColor: defaultTextColor ?? this.defaultTextColor,
      disableDepth: disableDepth ?? this.disableDepth,
      shadowDarkColor: shadowDarkColor ?? this.shadowDarkColor,
      shadowLightColor: shadowLightColor ?? this.shadowLightColor,
      shadowDarkColorEmboss:
          shadowDarkColorEmboss ?? this.shadowDarkColorEmboss,
      shadowLightColorEmboss:
          shadowLightColorEmboss ?? this.shadowLightColorEmboss,
      depth: depth ?? _depth,
      borderWidth: borderSize ?? borderWidth,
      borderColor: borderColor ?? this.borderColor,
      intensity: intensity ?? _intensity,
      lightSource: lightSource ?? this.lightSource,
    );
  }

  /// Creates a copy of this theme using values from another theme
  NeumorphicThemeData copyFrom({required NeumorphicThemeData other}) {
    return NeumorphicThemeData(
      baseColor: other.baseColor,
      accentColor: other.accentColor,
      variantColor: other.variantColor,
      disableDepth: other.disableDepth,
      disabledColor: other.disabledColor,
      defaultTextColor: other.defaultTextColor,
      shadowDarkColor: other.shadowDarkColor,
      shadowLightColor: other.shadowLightColor,
      shadowDarkColorEmboss: other.shadowDarkColorEmboss,
      shadowLightColorEmboss: other.shadowLightColorEmboss,
      textTheme: other.textTheme,
      iconTheme: other.iconTheme,
      buttonStyle: other.buttonStyle,
      appBarTheme: other.appBarTheme,
      depth: other.depth,
      boxShape: other.boxShape,
      borderColor: other.borderColor,
      borderWidth: other.borderWidth,
      intensity: other.intensity,
      lightSource: other.lightSource,
    );
  }
}
//endregion

//region style
// Default shape for neumorphic elements
const NeumorphicShape _defaultShape = NeumorphicShape.flat;
//const double _defaultBorderRadius = 5;

// Default light and dark themes
const neumorphicDefaultTheme = NeumorphicThemeData();
const neumorphicDefaultDarkTheme = NeumorphicThemeData.dark();

// Class for configuring neumorphic borders
class NeumorphicBorder {
  // Whether the border is enabled
  final bool isEnabled;
  // Border color, nullable
  final Color? color;
  // Border width, nullable
  final double? width;

  // Constructor for border with optional properties
  const NeumorphicBorder({this.isEnabled = true, this.color, this.width});

  // Constructor for a disabled border
  const NeumorphicBorder.none()
    : isEnabled = true,
      color = const Color(0x00000000), // Transparent color
      width = 0;

  // Equality comparison for NeumorphicBorder objects
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicBorder &&
          runtimeType == other.runtimeType &&
          isEnabled == other.isEnabled &&
          color == other.color &&
          width == other.width;

  // Generates hash code for the border
  @override
  int get hashCode => isEnabled.hashCode ^ color.hashCode ^ width.hashCode;

  // String representation of the border
  @override
  String toString() {
    return 'NeumorphicBorder{isEnabled: $isEnabled, color: $color, width: $width}';
  }

  // Interpolates between two borders
  static NeumorphicBorder? lerp(
    NeumorphicBorder? a,
    NeumorphicBorder? b,
    double t,
  ) {
    if (a == null && b == null) return null;

    if (t == 0.0) return a;
    if (t == 1.0) return b;

    return NeumorphicBorder(
      color: Color.lerp(a!.color, b!.color, t), // Interpolate color
      isEnabled: a.isEnabled,
      width: lerpDouble(a.width, b.width, t), // Interpolate width
    );
  }

  // Creates a copy with theme defaults if properties are null
  NeumorphicBorder copyWithThemeIfNull({Color? color, double? width}) {
    return NeumorphicBorder(
      isEnabled: isEnabled,
      color: this.color ?? color, // Use theme color if null
      width: this.width ?? width, // Use theme width if null
    );
  }
}

// Class for configuring neumorphic styles
class NeumorphicStyle {
  // Background color, nullable
  final Color? color;
  // Private depth value, nullable
  final double? _depth;
  // Private intensity value, nullable
  final double? _intensity;
  // Surface intensity for gradients
  final double _surfaceIntensity;
  // Light source position for shadows
  final LightSource lightSource;
  // Flag to disable depth effects, nullable
  final bool? disableDepth;

  // Border configuration
  final NeumorphicBorder border;

  // Whether to use opposite light source for shadows
  final bool oppositeShadowLightSource;

  // Shape of the neumorphic element
  final NeumorphicShape shape;
  // Box shape, nullable
  final NeumorphicBoxShape? boxShape;
  // Theme data, nullable
  final NeumorphicThemeData? theme;

  // Override for light shadow color
  final Color? shadowLightColor;

  // Override for dark shadow color
  final Color? shadowDarkColor;

  // Override for embossed light shadow color
  final Color? shadowLightColorEmboss;

  // Override for embossed dark shadow color
  final Color? shadowDarkColorEmboss;

  // Constructor for style with optional properties
  const NeumorphicStyle({
    this.shape = _defaultShape,
    this.lightSource = LightSource.topLeft,
    this.border = const NeumorphicBorder.none(),
    this.color,
    this.boxShape, // Nullable, uses theme's boxShape if not set
    this.shadowLightColor,
    this.shadowDarkColor,
    this.shadowLightColorEmboss,
    this.shadowDarkColorEmboss,
    double? depth,
    double? intensity,
    double surfaceIntensity = 0.25,
    this.disableDepth,
    this.oppositeShadowLightSource = false,
  }) : _depth = depth,
       theme = null,
       _intensity = intensity,
       _surfaceIntensity = surfaceIntensity;

  // Private constructor for style with theme
  const NeumorphicStyle._withTheme({
    this.theme,
    this.shape = _defaultShape,
    this.lightSource = LightSource.topLeft,
    this.color,
    this.boxShape,
    this.border = const NeumorphicBorder.none(),
    this.shadowLightColor,
    this.shadowDarkColor,
    this.shadowLightColorEmboss,
    this.shadowDarkColorEmboss,
    this.oppositeShadowLightSource = false,
    this.disableDepth,
    double? depth,
    double? intensity,
    double surfaceIntensity = 0.25,
  }) : _depth = depth,
       _intensity = intensity,
       _surfaceIntensity = surfaceIntensity;

  // Clamps depth to min/max neumorphic constants
  double? get depth => _depth?.clamp(Neumorphic.minDepth, Neumorphic.maxDepth);

  // Clamps intensity to min/max neumorphic constants
  double? get intensity =>
      _intensity?.clamp(Neumorphic.minIntensity, Neumorphic.maxIntensity);

  // Clamps surface intensity to min/max neumorphic constants
  double get surfaceIntensity =>
      _surfaceIntensity.clamp(Neumorphic.minIntensity, Neumorphic.maxIntensity);

  // Creates a copy with theme defaults if properties are null
  NeumorphicStyle copyWithThemeIfNull(NeumorphicThemeData theme) {
    return NeumorphicStyle._withTheme(
      theme: theme,
      color: color ?? theme.baseColor, // Use theme base color if null
      boxShape: boxShape ?? theme.boxShape, // Use theme box shape if null
      shape: shape,
      border: border.copyWithThemeIfNull(
        color: theme.borderColor,
        width: theme.borderWidth,
      ), // Use theme border properties if null
      shadowDarkColor:
          shadowDarkColor ??
          theme.shadowDarkColor, // Use theme shadow color if null
      shadowLightColor:
          shadowLightColor ??
          theme.shadowLightColor, // Use theme shadow color if null
      shadowDarkColorEmboss:
          shadowDarkColorEmboss ??
          theme.shadowDarkColorEmboss, // Use theme emboss shadow color if null
      shadowLightColorEmboss:
          shadowLightColorEmboss ??
          theme.shadowLightColorEmboss, // Use theme emboss shadow color if null
      depth: depth ?? theme.depth, // Use theme depth if null
      intensity: intensity ?? theme.intensity, // Use theme intensity if null
      disableDepth:
          disableDepth ?? theme.disableDepth, // Use theme disableDepth if null
      surfaceIntensity: surfaceIntensity,
      oppositeShadowLightSource: oppositeShadowLightSource,
      lightSource: lightSource,
    );
  }

  // Equality comparison for NeumorphicStyle objects
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicStyle &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          boxShape == other.boxShape &&
          border == other.border &&
          shadowDarkColor == other.shadowDarkColor &&
          shadowLightColor == other.shadowLightColor &&
          shadowDarkColorEmboss == other.shadowDarkColorEmboss &&
          shadowLightColorEmboss == other.shadowLightColorEmboss &&
          disableDepth == other.disableDepth &&
          _depth == other._depth &&
          _intensity == other._intensity &&
          _surfaceIntensity == other._surfaceIntensity &&
          lightSource == other.lightSource &&
          oppositeShadowLightSource == other.oppositeShadowLightSource &&
          shape == other.shape &&
          theme == other.theme;

  // Generates hash code for the style
  @override
  int get hashCode =>
      color.hashCode ^
      shadowDarkColor.hashCode ^
      boxShape.hashCode ^
      shadowLightColor.hashCode ^
      shadowDarkColorEmboss.hashCode ^
      shadowLightColorEmboss.hashCode ^
      _depth.hashCode ^
      border.hashCode ^
      _intensity.hashCode ^
      disableDepth.hashCode ^
      _surfaceIntensity.hashCode ^
      lightSource.hashCode ^
      oppositeShadowLightSource.hashCode ^
      shape.hashCode ^
      theme.hashCode;

  // Creates a copy with optional new values
  NeumorphicStyle copyWith({
    Color? color,
    NeumorphicBorder? border,
    NeumorphicBoxShape? boxShape,
    Color? shadowLightColor,
    Color? shadowDarkColor,
    Color? shadowLightColorEmboss,
    Color? shadowDarkColorEmboss,
    double? depth,
    double? intensity,
    double? surfaceIntensity,
    LightSource? lightSource,
    bool? disableDepth,
    double? borderRadius,
    bool? oppositeShadowLightSource,
    NeumorphicShape? shape,
  }) {
    return NeumorphicStyle._withTheme(
      color: color ?? this.color,
      border: border ?? this.border,
      boxShape: boxShape ?? this.boxShape,
      shadowDarkColor: shadowDarkColor ?? this.shadowDarkColor,
      shadowLightColor: shadowLightColor ?? this.shadowLightColor,
      shadowDarkColorEmboss:
          shadowDarkColorEmboss ?? this.shadowDarkColorEmboss,
      shadowLightColorEmboss:
          shadowLightColorEmboss ?? this.shadowLightColorEmboss,
      depth: depth ?? this.depth,
      theme: theme,
      intensity: intensity ?? this.intensity,
      surfaceIntensity: surfaceIntensity ?? this.surfaceIntensity,
      disableDepth: disableDepth ?? this.disableDepth,
      lightSource: lightSource ?? this.lightSource,
      oppositeShadowLightSource:
          oppositeShadowLightSource ?? this.oppositeShadowLightSource,
      shape: shape ?? this.shape,
    );
  }

  // String representation of the style
  @override
  String toString() {
    return 'NeumorphicStyle{color: $color, boxShape: $boxShape, _depth: $_depth, intensity: $intensity, disableDepth: $disableDepth, lightSource: $lightSource, shape: $shape, theme: $theme, oppositeShadowLightSource: $oppositeShadowLightSource}';
  }

  // Applies disableDepth by setting depth to 0 if enabled
  NeumorphicStyle applyDisableDepth() {
    if (disableDepth == true) {
      return copyWith(depth: 0); // Return copy with zero depth
    } else {
      return this; // Return unchanged style
    }
  }
}

//endregion

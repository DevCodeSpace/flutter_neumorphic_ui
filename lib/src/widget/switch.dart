import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';
import 'package:flutter_neumorphic_ui/src/widget/animation/animated_scale.dart'
    as animationscale;

/// A style to customize the [NeumorphicSwitch]
///
/// you can define the track : [activeTrackColor], [inactiveTrackColor], [trackDepth]
///
/// you can define the thumb : [activeTrackColor], [inactiveTrackColor], [thumbDepth]
/// and [thumbShape] @see [NeumorphicShape]
///
class NeumorphicSwitchStyle {
  final double? trackDepth; // Depth effect for the switch track
  final Color? activeTrackColor; // Color when the switch is active
  final Color? inactiveTrackColor; // Color when the switch is inactive
  final Color? activeThumbColor; // Color for the thumb when active
  final Color? inactiveThumbColor; // Color for the thumb when inactive
  final NeumorphicShape? thumbShape; // Shape of the thumb (e.g., concave, flat)
  final double? thumbDepth; // Depth effect for the thumb
  final LightSource? lightSource; // Light source for the neumorphic effect
  final bool disableDepth; // Flag to disable depth effect

  final NeumorphicBorder thumbBorder; // Border style for the thumb
  final NeumorphicBorder trackBorder; // Border style for the track

  const NeumorphicSwitchStyle({
    this.trackDepth,
    this.thumbShape = NeumorphicShape.concave,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.thumbDepth,
    this.lightSource,
    this.disableDepth = false,
    this.thumbBorder = const NeumorphicBorder.none(),
    this.trackBorder = const NeumorphicBorder.none(),
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicSwitchStyle &&
          runtimeType == other.runtimeType &&
          trackDepth == other.trackDepth &&
          trackBorder == other.trackBorder &&
          thumbBorder == other.thumbBorder &&
          lightSource == other.lightSource &&
          activeTrackColor == other.activeTrackColor &&
          inactiveTrackColor == other.inactiveTrackColor &&
          activeThumbColor == other.activeThumbColor &&
          inactiveThumbColor == other.inactiveThumbColor &&
          thumbShape == other.thumbShape &&
          thumbDepth == other.thumbDepth &&
          disableDepth == other.disableDepth;

  @override
  int get hashCode =>
      trackDepth.hashCode ^
      activeTrackColor.hashCode ^
      trackBorder.hashCode ^
      thumbBorder.hashCode ^
      lightSource.hashCode ^
      inactiveTrackColor.hashCode ^
      activeThumbColor.hashCode ^
      inactiveThumbColor.hashCode ^
      thumbShape.hashCode ^
      thumbDepth.hashCode ^
      disableDepth.hashCode;
}

/// Used to toggle the on/off state of a single setting.
///
/// The switch itself does not maintain any state. Instead, when the state of the switch changes, the widget calls the onChanged callback.
/// Most widgets that use a switch will listen for the onChanged callback and rebuild the switch with a new value to update the visual appearance of the switch.
///
/// ```
///  bool _switch1Value = false;
///  bool _switch2Value = false;
///
///  Widget _buildSwitches() {
///    return Row(children: <Widget>[
///
///      NeumorphicSwitch(
///        value: _switch1Value,
///        style: NeumorphicSwitchStyle(
///          thumbShape: NeumorphicShape.concave,
///        ),
///        onChanged: (value) {
///          setState(() {
///            _switch1Value = value;
///          });
///        },
///      ),
///
///      NeumorphicSwitch(
///        value: _switch2Value,
///        style: NeumorphicSwitchStyle(
///          thumbShape: NeumorphicShape.flat,
///        ),
///        onChanged: (value) {
///          setState(() {
///            _switch2Value = value;
///          });
///        },
///      ),
///
///    ]);
///  }
///  ```
///
@immutable
class NeumorphicSwitch extends StatelessWidget {
  static const minEmbossDepth = -1.0; // Minimum depth for emboss effect

  final bool value; // Current state of the switch (on/off)
  final ValueChanged<bool>? onChanged; // Callback when the switch state changes
  final NeumorphicSwitchStyle style; // Custom style for the switch
  final double height; // Height of the switch
  final Duration duration; // Animation duration for state changes
  final Curve curve; // Animation curve for smooth transitions
  final bool isEnabled; // Flag to enable/disable the switch

  const NeumorphicSwitch({
    this.style = const NeumorphicSwitchStyle(),
    super.key,
    this.curve = Neumorphic.defaultCurve,
    this.duration = const Duration(milliseconds: 200),
    this.value = false,
    this.onChanged,
    this.height = 40,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(
      context,
    ); // Retrieves current theme
    return SizedBox(
      height: height, // Sets the height of the switch
      child: AspectRatio(
        aspectRatio: 2 / 1, // Maintains a 2:1 aspect ratio
        child: GestureDetector(
          onTap: () {
            // Prevents interaction if disabled
            if (!isEnabled) {
              return;
            }
            if (onChanged != null) {
              onChanged!(!value); // Toggles the switch state
            }
          },
          child: Neumorphic(
            drawSurfaceAboveChild: false, // Renders child above surface
            style: NeumorphicStyle(
              boxShape:
                  NeumorphicBoxShape.stadium(), // Uses stadium shape for track
              lightSource:
                  style.lightSource ??
                  theme.lightSource, // Applies light source
              border: style.trackBorder, // Applies track border
              disableDepth: style.disableDepth, // Applies depth setting
              depth: _getTrackDepth(theme.depth), // Sets track depth
              shape: NeumorphicShape.flat, // Uses flat shape for track
              color: _getTrackColor(theme, isEnabled), // Sets track color
            ),
            child: animationscale.AnimatedScale(
              scale: isEnabled ? 1 : 0, // Scales thumb based on enabled state
              alignment: value
                  ? Alignment(0.5, 0)
                  : Alignment(-0.5, 0), // Aligns thumb
              child: AnimatedThumb(
                curve: curve, // Applies animation curve
                disableDepth: style.disableDepth, // Applies depth setting
                depth: _thumbDepth, // Sets thumb depth
                duration: duration, // Applies animation duration
                alignment: _alignment, // Sets thumb alignment
                shape: _getThumbShape, // Sets thumb shape
                lightSource:
                    style.lightSource ??
                    theme.lightSource, // Applies light source
                border: style.thumbBorder, // Applies thumb border
                thumbColor: _getThumbColor(theme), // Sets thumb color
              ),
            ),
          ),
        ),
      ),
    );
  }

  Alignment get _alignment {
    // Returns alignment based on switch state
    if (value) {
      return Alignment.centerRight;
    } else {
      return Alignment.centerLeft;
    }
  }

  double get _thumbDepth {
    // Returns thumb depth based on enabled state
    if (!isEnabled) {
      return 0;
    } else {
      return style.thumbDepth ?? neumorphicDefaultTheme.depth;
    }
  }

  NeumorphicShape get _getThumbShape {
    // Returns thumb shape, defaults to flat
    return style.thumbShape ?? NeumorphicShape.flat;
  }

  double? _getTrackDepth(double? themeDepth) {
    if (themeDepth == null) return themeDepth;
    // Forces negative depth for emboss effect
    final double depth = -1 * (style.trackDepth ?? themeDepth).abs();
    return depth.clamp(Neumorphic.minDepth, NeumorphicSwitch.minEmbossDepth);
  }

  Color _getTrackColor(NeumorphicThemeData theme, bool enabled) {
    // Returns track color based on state and enabled status
    if (!enabled) {
      return style.inactiveTrackColor ?? theme.baseColor;
    }

    return value == true
        ? style.activeTrackColor ?? theme.accentColor
        : style.inactiveTrackColor ?? theme.baseColor;
  }

  Color _getThumbColor(NeumorphicThemeData theme) {
    // Returns thumb color based on switch state
    Color? color = value == true
        ? style.activeThumbColor
        : style.inactiveThumbColor;
    return color ?? theme.baseColor;
  }
}

class AnimatedThumb extends StatelessWidget {
  final Color? thumbColor; // Color of the thumb
  final Alignment alignment; // Alignment of the thumb within the track
  final Duration duration; // Animation duration for thumb movement
  final NeumorphicShape shape; // Shape of the thumb
  final double? depth; // Depth effect for the thumb
  final Curve curve; // Animation curve for thumb movement
  final bool disableDepth; // Flag to disable depth effect
  final NeumorphicBorder border; // Border style for the thumb
  final LightSource lightSource; // Light source for the thumb

  const AnimatedThumb({
    super.key,
    this.thumbColor,
    required this.alignment,
    required this.duration,
    required this.shape,
    this.depth,
    this.curve = Curves.linear,
    this.border = const NeumorphicBorder.none(),
    this.lightSource = LightSource.topLeft,
    this.disableDepth = false,
  });

  @override
  Widget build(BuildContext context) {
    // This Container is actually the inner track containing the thumb
    return AnimatedAlign(
      curve: curve, // Applies animation curve
      alignment: alignment, // Animates thumb to specified alignment
      duration: duration, // Sets animation duration
      child: Padding(
        padding: const EdgeInsets.all(4.0), // Adds padding around thumb
        child: Neumorphic(
          style: NeumorphicStyle(
            boxShape:
                NeumorphicBoxShape.circle(), // Uses circular shape for thumb
            disableDepth: disableDepth, // Applies depth setting
            shape: shape, // Applies thumb shape
            depth: depth, // Applies thumb depth
            color: thumbColor, // Applies thumb color
            border: border, // Applies thumb border
            lightSource: lightSource, // Applies light source
          ),
          child: AspectRatio(
            aspectRatio: 1, // Maintains 1:1 aspect ratio for thumb
            child: FractionallySizedBox(
              heightFactor: 1, // Fills available height
              child: Container(), // Placeholder for thumb content
              //width: THUMB_WIDTH,
            ),
          ),
        ),
      ),
    );
  }
}

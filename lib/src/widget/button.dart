// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/services.dart';
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

import 'animation/animated_scale.dart' as animationscale;

// Type definition for the button click callback
typedef NeumorphicButtonClickListener = void Function();

/// A Neumorphic Button
///
/// When pressed, it will fire a call to its [NeumorphicButtonClickListener] click parameter
/// The animation starts from style.depth (or theme.depth is not defined in the style)
/// @see [NeumorphicStyle]
///
/// And finished to `minDistance`, in [duration] (time)
///
/// You can force the pressed state using [pressed]
/// - true : forced as pressed
/// - false : forced as unpressed
/// - null : can be pressed by user
///
/// It takes a [padding], default EdgeInsets.symmetric(horizontal: 8, vertical: 4)`
///
/// It takes a [NeumorphicStyle] @see [Neumorphi]
///
/// ```
///  NeumorphicButton(
///          onClick: () {
///            setState(() {
///               ...
///            });
///          },
///          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
///          style: NeumorphicStyle(
///            shape: NeumorphicShape.flat,
///          ),
///          child: ...
///  )
/// ```
///
@immutable
class NeumorphicButton extends StatefulWidget {
  // Scale factor when the button is pressed
  static const double pressedscale = 0.98;
  // Scale factor when the button is unpressed
  static const double unpressedscale = 1.0;

  // The child widget displayed inside the button
  final Widget? child;
  // Optional neumorphic style for the button
  final NeumorphicStyle? style;
  // Minimum depth when the button is pressed
  final double minDistance;
  // Optional padding inside the button
  final EdgeInsets? padding;
  // Optional margin outside the button
  final EdgeInsets? margin;
  // Forced pressed state: true (pressed), false (unpressed), null (user-controlled)
  final bool? pressed;
  // Duration of the animation
  final Duration duration;
  // Animation curve for the transition
  final Curve curve;
  // Callback triggered when the button is pressed
  final NeumorphicButtonClickListener? onPressed;
  // Whether to draw the surface gradient above the child
  final bool drawSurfaceAboveChild;
  // Whether to provide haptic feedback on press
  final bool provideHapticFeedback;
  // Optional tooltip for accessibility
  final String? tooltip;

  // Constructor for initializing the NeumorphicButton
  const NeumorphicButton({
    super.key,
    this.padding, // Optional padding
    this.margin = EdgeInsets.zero, // Default to zero margin
    this.child, // Optional child widget
    this.tooltip, // Optional tooltip
    this.drawSurfaceAboveChild = true, // Default to draw surface above child
    this.pressed, // Optional forced pressed state
    this.duration = Neumorphic.defaultDuration, // Default animation duration
    this.curve = Neumorphic.defaultCurve, // Default animation curve
    this.onPressed, // Optional press callback
    this.minDistance = 0, // Default minimum depth
    this.style, // Optional style
    this.provideHapticFeedback = true, // Default to provide haptic feedback
  });

  // Indicates if the button is enabled (clickable)
  bool get isEnabled => onPressed != null;

  // Creates the state for managing the button's behavior
  @override
  _NeumorphicButtonState createState() => _NeumorphicButtonState();
}

// State class for managing the NeumorphicButton's behavior
class _NeumorphicButtonState extends State<NeumorphicButton> {
  // Initial style of the button
  late NeumorphicStyle initialStyle;
  // Current depth of the button
  late double depth;
  // Tracks the pressed state during user interaction
  bool pressed = false; // Overwrites widget.pressed during animation
  // Tracks if the press animation has completed
  bool hasFinishedAnimationDown = false;
  // Tracks if the user has released the button
  bool hasTapUp = false;
  // Tracks if the widget has been disposed
  bool hasDisposed = false;

  // Updates the initial style and depth based on context
  void updateInitialStyle() {
    // Check if an app bar theme is present
    final appBarPresent = NeumorphicAppBarTheme.of(context) != null;
    // Get the current neumorphic theme
    final theme = NeumorphicTheme.currentTheme(context);
    // Set initial style, prioritizing widget style, app bar style, or theme style
    initialStyle =
        widget.style ??
        (appBarPresent
            ? theme.appBarTheme.buttonStyle
            : (theme.buttonStyle ?? const NeumorphicStyle()));
    // Set depth, prioritizing widget style, app bar style, or theme depth
    depth =
        widget.style?.depth ??
        (appBarPresent ? theme.appBarTheme.buttonStyle.depth : theme.depth) ??
        0.0;

    // Trigger rebuild if necessary
    setState(() {});
  }

  // Called when dependencies change (e.g., theme updates)
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateInitialStyle();
  }

  // Called when the widget updates
  @override
  void didUpdateWidget(NeumorphicButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateInitialStyle();
  }

  // Handles the press animation and haptic feedback
  Future<void> _handlePress() async {
    hasFinishedAnimationDown = false;
    // Update state to pressed with minimum depth
    setState(() {
      pressed = true;
      depth = widget.minDistance;
    });

    // Wait for the animation duration
    await Future.delayed(widget.duration);
    hasFinishedAnimationDown = true;

    // Provide haptic feedback if enabled
    if (widget.provideHapticFeedback) {
      HapticFeedback.lightImpact();
    }

    // Reset state if the user has released the button
    _resetIfTapUp();
  }

  // Cleans up resources when the widget is disposed
  @override
  void dispose() {
    super.dispose();
    hasDisposed = true;
  }

  // Resets the button state if the user has released the button
  void _resetIfTapUp() {
    if (hasFinishedAnimationDown && hasTapUp && !hasDisposed) {
      // Update state to unpressed with initial depth
      setState(() {
        pressed = false;
        depth = initialStyle.depth ?? neumorphicDefaultTheme.depth;

        hasFinishedAnimationDown = false;
        hasTapUp = false;
      });
    }
  }

  // Indicates if the button is clickable
  bool get clickable {
    return widget.isEnabled && widget.onPressed != null;
  }

  // Builds the widget tree, wrapping with a tooltip if provided
  @override
  Widget build(BuildContext context) {
    final result = _build(context);
    if (widget.tooltip != null) {
      return Tooltip(message: widget.tooltip!, child: result);
    } else {
      return result;
    }
  }

  // Core build method for the button
  Widget _build(BuildContext context) {
    // Check if an app bar theme is present
    final appBarPresent = NeumorphicAppBarTheme.of(context) != null;
    // Get the app bar theme from the current neumorphic theme
    final appBarTheme = NeumorphicTheme.currentTheme(context).appBarTheme;

    // Wrap the button with gesture detection
    return GestureDetector(
      // Handle tap down event
      onTapDown: (detail) {
        hasTapUp = false;
        if (clickable && !pressed) {
          _handlePress();
        }
      },
      // Handle tap up event
      onTapUp: (details) {
        if (clickable) {
          widget.onPressed!(); // Trigger the onPressed callback
        }
        hasTapUp = true;
        _resetIfTapUp();
      },
      // Handle tap cancel event
      onTapCancel: () {
        hasTapUp = true;
        _resetIfTapUp();
      },
      // Apply animated scale effect
      child: animationscale.AnimatedScale(
        scale: _getScale(), // Get the current scale
        child: Neumorphic(
          margin: widget.margin ?? const EdgeInsets.all(0), // Apply margin
          drawSurfaceAboveChild:
              widget.drawSurfaceAboveChild, // Draw surface setting
          duration: widget.duration, // Animation duration
          curve: widget.curve, // Animation curve
          padding:
              widget.padding ?? // Use widget padding if provided
              (appBarPresent
                  ? appBarTheme.buttonPadding
                  : null) ?? // Fallback to app bar padding
              const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ), // Default padding
          style: initialStyle.copyWith(
            depth: _getDepth(),
          ), // Apply style with current depth
          child: widget.child, // Render the child widget
        ),
      ),
    );
  }

  // Determines the current depth based on button state
  double _getDepth() {
    if (widget.isEnabled) {
      return depth; // Return current depth if enabled
    } else {
      return 0; // Return zero depth if disabled
    }
  }

  // Determines the current scale based on pressed state
  double _getScale() {
    if (widget.pressed != null) {
      // Use forced pressed state if defined
      return widget.pressed!
          ? NeumorphicButton.pressedscale
          : NeumorphicButton.unpressedscale;
    } else {
      // Use internal pressed state
      return pressed
          ? NeumorphicButton.pressedscale
          : NeumorphicButton.unpressedscale;
    }
  }
}

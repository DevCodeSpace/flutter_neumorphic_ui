import 'package:flutter/widgets.dart';

import 'container.dart';

/// A Style to customize the [NeumorphicIndicator]
///
/// the gradient will use [accent] and [variant]
///
/// the gradient shape will be a roundrect, using [borderRadius]
///
/// you can define a custom [depth] for the roundrect
///
/// you can update the gradient orientation using [gradientStart] & [gradientEnd]
///
class IndicatorStyle {
  // Depth of the neumorphic effect for the indicator
  final double depth;
  // Whether to disable depth effects
  final bool? disableDepth;
  // Accent color for the gradient
  final Color? accent;
  // Variant color for the gradient
  final Color? variant;
  // Light source position for shadows
  final LightSource? lightSource;
  // Starting alignment for the gradient
  final AlignmentGeometry? gradientStart;
  // Ending alignment for the gradient
  final AlignmentGeometry? gradientEnd;

  // Constructor for initializing the indicator style
  const IndicatorStyle({
    this.depth = -4, // Default depth
    this.accent, // Optional accent color
    this.lightSource, // Optional light source
    this.variant, // Optional variant color
    this.disableDepth, // Optional depth disable flag
    this.gradientStart, // Optional gradient start alignment
    this.gradientEnd, // Optional gradient end alignment
  });

  // Equality comparison for IndicatorStyle objects
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IndicatorStyle &&
          runtimeType == other.runtimeType &&
          depth == other.depth &&
          disableDepth == other.disableDepth &&
          accent == other.accent &&
          lightSource == other.lightSource &&
          variant == other.variant &&
          gradientStart == other.gradientStart &&
          gradientEnd == other.gradientEnd;

  // Generates hash code for the style
  @override
  int get hashCode =>
      depth.hashCode ^
      disableDepth.hashCode ^
      accent.hashCode ^
      variant.hashCode ^
      lightSource.hashCode ^
      gradientStart.hashCode ^
      gradientEnd.hashCode;
}

// Enum to define the orientation of the indicator
enum NeumorphicIndicatorOrientation { vertical, horizontal }

/// An indicator is a horizontal / vertical bar that display a percentage
///
/// Like a ProgressBar, but with an [orientation] @see [NeumorphicIndicatorOrientation]
///
/// it takes a [padding], a [width] and [height]
///
/// the current accented roundrect use the [percent] field
///
/// Widget _buildIndicators() {
///
///    final width = 14.0;
///
///    return SizedBox(
///      height: 130,
///      child: Row(
///        mainAxisAlignment: MainAxisAlignment.center,
///        children: <Widget>[
///          NeumorphicIndicator(
///            width: width,
///            percent: 0.4,
///          ),
///          SizedBox(width: 10),
///          NeumorphicIndicator(
///            width: width,
///            percent: 0.2,
///          ),
///          SizedBox(width: 10),
///          NeumorphicIndicator(
///            width: width,
///            percent: 0.5,
///          ),
///          SizedBox(width: 10),
///          NeumorphicIndicator(
///            width: width,
///            percent: 1,
///          ),
///        ],
///      ),
///    );
///  }
///
@immutable
class NeumorphicIndicator extends StatefulWidget {
  // Percentage value of the indicator (0.0 to 1.0)
  final double percent;
  // Width of the indicator
  final double width;
  // Height of the indicator
  final double height;
  // Padding inside the indicator
  final EdgeInsets padding;
  // Orientation of the indicator (vertical or horizontal)
  final NeumorphicIndicatorOrientation orientation;
  // Style configuration for the indicator
  final IndicatorStyle style;
  // Duration of the animation
  final Duration duration;
  // Animation curve for the transition
  final Curve curve;

  // Constructor for initializing the NeumorphicIndicator
  const NeumorphicIndicator({
    super.key,
    this.percent = 0.5, // Default to 50%
    this.orientation =
        NeumorphicIndicatorOrientation.vertical, // Default to vertical
    this.height = double.maxFinite, // Default to maximum height
    this.padding = EdgeInsets.zero, // Default to no padding
    this.width = double.maxFinite, // Default to maximum width
    this.style = const IndicatorStyle(), // Default style
    this.duration = const Duration(
      milliseconds: 300,
    ), // Default animation duration
    this.curve = Curves.easeOutCubic, // Default animation curve
  });

  // Creates the state for managing the indicator's animation
  @override
  createState() => _NeumorphicIndicatorState();

  // Equality comparison for NeumorphicIndicator objects
  @override
  // ignore: invalid_override_of_non_virtual_member
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is NeumorphicIndicator &&
          runtimeType == other.runtimeType &&
          percent == other.percent &&
          width == other.width &&
          height == other.height &&
          padding == other.padding &&
          orientation == other.orientation &&
          style == other.style &&
          duration == other.duration &&
          curve == other.curve;

  // Generates hash code for the indicator
  @override
  // ignore: invalid_override_of_non_virtual_member
  int get hashCode =>
      super.hashCode ^
      percent.hashCode ^
      width.hashCode ^
      height.hashCode ^
      padding.hashCode ^
      orientation.hashCode ^
      style.hashCode ^
      duration.hashCode ^
      curve.hashCode;
}

// State class for managing the NeumorphicIndicator's animation
class _NeumorphicIndicatorState extends State<NeumorphicIndicator>
    with TickerProviderStateMixin {
  // Stores the previous percentage value
  double oldPercent = 0;
  // Controller for managing the animation
  late AnimationController _controller;
  // Animation for transitioning the percentage value
  late Animation _animation;

  // Initializes the animation controller and animation
  @override
  void initState() {
    super.initState();
    // Create animation controller with specified duration
    _controller = AnimationController(vsync: this, duration: widget.duration);
    // Initialize animation with current percentage
    _animation = Tween<double>(
      begin: widget.percent,
      end: oldPercent,
    ).animate(_controller);
  }

  // Updates the animation when the widget's properties change
  @override
  void didUpdateWidget(NeumorphicIndicator oldWidget) {
    if (oldWidget.percent != widget.percent) {
      // Reset the controller if percentage changes
      _controller.reset();
      oldPercent = oldWidget.percent; // Store previous percentage
      // Create new animation from old to new percentage
      _animation = Tween<double>(
        begin: oldPercent,
        end: widget.percent,
      ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
      // Start the animation
      _controller.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  // Cleans up resources when the widget is disposed
  @override
  void dispose() {
    // Dispose of the animation controller
    _controller.dispose();
    super.dispose();
  }

  // Builds the widget tree for the indicator
  @override
  Widget build(BuildContext context) {
    // Get the current neumorphic theme
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);
    // Create a sized box to constrain the indicator
    return SizedBox(
      height: widget.height, // Apply height
      width: widget.width, // Apply width
      child: Neumorphic(
        padding: EdgeInsets.zero, // No padding for outer container
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.stadium(), // Use stadium shape
          lightSource:
              widget.style.lightSource ??
              theme.lightSource, // Apply light source
          disableDepth: widget.style.disableDepth, // Apply depth disable flag
          depth: widget.style.depth, // Apply depth
          shape: NeumorphicShape.flat, // Use flat shape
        ),
        child: AnimatedBuilder(
          animation: _animation, // Rebuild when animation changes
          builder: (_, __) {
            // Size the indicator based on percentage and orientation
            return FractionallySizedBox(
              heightFactor:
                  widget.orientation == NeumorphicIndicatorOrientation.vertical
                  ? _animation
                        .value // Scale height for vertical
                  : 1, // Full height for horizontal
              widthFactor:
                  widget.orientation ==
                      NeumorphicIndicatorOrientation.horizontal
                  ? _animation
                        .value // Scale width for horizontal
                  : 1, // Full width for vertical
              alignment:
                  widget.orientation ==
                      NeumorphicIndicatorOrientation.horizontal
                  ? Alignment
                        .centerLeft // Align left for horizontal
                  : Alignment.bottomCenter, // Align bottom for vertical
              child: Padding(
                padding: widget.padding, // Apply inner padding
                child: Neumorphic(
                  style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.stadium(), // Use stadium shape
                    lightSource:
                        widget.style.lightSource ??
                        theme.lightSource, // Apply light source
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin:
                            widget.style.gradientStart ??
                            Alignment.topCenter, // Gradient start
                        end:
                            widget.style.gradientEnd ??
                            Alignment.bottomCenter, // Gradient end
                        colors: [
                          widget.style.accent ??
                              theme.accentColor, // Accent color
                          widget.style.variant ??
                              theme.variantColor, // Variant color
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

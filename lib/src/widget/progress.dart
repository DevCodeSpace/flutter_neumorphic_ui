// ignore_for_file: library_private_types_in_public_api, empty_catches

import 'package:flutter/widgets.dart';

import 'container.dart';

/// A style to customize the [NeumorphicProgress]
///
/// the gradient will use [accent] and [variant]
///
/// the gradient shape will be a roundrect, using [borderRadius]
///
/// you can define a custom [depth] for the roundrect
///
/// you can update the gradient orientation using [progressGradientStart] & [progressGradientEnd]
///
class ProgressStyle {
  final double depth; // Defines the depth effect for the neumorphic style
  final BorderRadius
  borderRadius; // Sets the border radius for the progress bar
  final BorderRadius?
  gradientBorderRadius; // Optional custom border radius for the gradient
  final Color? accent; // Accent color for the progress gradient
  final Color? variant; // Variant color for the progress gradient
  final LightSource? lightSource; // Light source for the neumorphic effect

  final AlignmentGeometry?
  progressGradientStart; // Starting alignment for the gradient
  final AlignmentGeometry?
  progressGradientEnd; // Ending alignment for the gradient
  final bool disableDepth; // Flag to disable the depth effect

  final NeumorphicBorder border; // Border style for the progress bar

  const ProgressStyle({
    this.depth = 0,
    this.disableDepth = false,
    this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    this.gradientBorderRadius,
    this.accent,
    this.lightSource,
    this.progressGradientStart,
    this.progressGradientEnd,
    this.variant,
    this.border = const NeumorphicBorder.none(),
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgressStyle &&
          runtimeType == other.runtimeType &&
          depth == other.depth &&
          border == other.border &&
          disableDepth == other.disableDepth &&
          lightSource == other.lightSource &&
          borderRadius == other.borderRadius &&
          gradientBorderRadius == other.gradientBorderRadius &&
          accent == other.accent &&
          variant == other.variant &&
          progressGradientStart == other.progressGradientStart &&
          progressGradientEnd == other.progressGradientEnd;

  @override
  int get hashCode =>
      depth.hashCode ^
      disableDepth.hashCode ^
      borderRadius.hashCode ^
      lightSource.hashCode ^
      gradientBorderRadius.hashCode ^
      border.hashCode ^
      accent.hashCode ^
      variant.hashCode ^
      progressGradientStart.hashCode ^
      progressGradientEnd.hashCode;
}

/// A widget that shows progress along a line.
///
/// NeumorphicProgress is determinate.
///
/// Determinate progress indicators have a specific value at each point in time,
/// and the value should increase monotonically from 0.0 to 1.0, at which time the indicator is complete.
/// To create a determinate progress indicator, use a non-null value between 0.0 and 1.0.
///
///  ```
///  NeumorphicProgress(
///      height: 15,
///      percent: 0.55,
///  );
///  ```
///
class NeumorphicProgress extends StatefulWidget {
  final double? _percent; // Progress percentage (0.0 to 1.0)
  final double height; // Height of the progress bar
  final Duration duration; // Animation duration for progress changes
  final ProgressStyle style; // Custom style for the progress bar
  final Curve curve; // Animation curve for smooth transitions

  const NeumorphicProgress({
    super.key,
    double? percent,
    this.height = 10,
    this.duration = const Duration(milliseconds: 300),
    this.style = const ProgressStyle(),
    this.curve = Curves.easeOutCubic,
  }) : _percent = percent;

  @override
  _NeumorphicProgressState createState() => _NeumorphicProgressState();

  double? get percent =>
      _percent?.clamp(0, 1); // Clamps percent value between 0 and 1

  @override
  // ignore: invalid_override_of_non_virtual_member
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicProgress &&
          runtimeType == other.runtimeType &&
          percent == other.percent &&
          height == other.height &&
          style == other.style &&
          curve == other.curve;

  @override
  // ignore: invalid_override_of_non_virtual_member
  int get hashCode =>
      percent.hashCode ^ height.hashCode ^ style.hashCode ^ curve.hashCode;
}

class _NeumorphicProgressState extends State<NeumorphicProgress>
    with TickerProviderStateMixin {
  double? oldPercent = 0; // Stores the previous percent value for animation

  late AnimationController _controller; // Controls the animation
  late Animation _animation; // Defines the animation for progress changes

  @override
  void initState() {
    super.initState();
    // Initializes the animation controller with the provided duration
    _controller = AnimationController(vsync: this, duration: widget.duration);
    // Sets up the animation tween from the current to the old percent
    _animation = Tween<double>(
      begin: widget.percent,
      end: oldPercent,
    ).animate(_controller);
  }

  @override
  void didUpdateWidget(NeumorphicProgress oldWidget) {
    // Updates the animation when the percent value changes
    if (oldWidget.percent != widget.percent) {
      _controller.reset(); // Resets the animation controller
      oldPercent = oldWidget.percent; // Stores the old percent value
      // Creates a new tween for the updated percent value
      _animation = Tween<double>(
        begin: oldPercent,
        end: widget.percent,
      ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
      _controller.forward(); // Starts the animation
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose(); // Disposes the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print("widget.style.depth: ${widget.style.depth}");

    // Retrieves the current neumorphic theme
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);
    return SizedBox(
      height: widget.height, // Sets the height of the progress bar
      child: FractionallySizedBox(
        widthFactor: 1, // Makes the progress bar span the full width
        //width: constraints.maxWidth,
        child: Neumorphic(
          padding: EdgeInsets.zero, // Removes padding
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(
              widget.style.borderRadius,
            ), // Sets the shape
            disableDepth: widget.style.disableDepth, // Applies depth setting
            border: widget.style.border, // Applies border style
            depth: widget.style.depth, // Applies depth effect
            shape: NeumorphicShape.flat, // Uses flat shape
          ),
          child: AnimatedBuilder(
            animation: _controller, // Listens to animation changes
            builder: (_, __) {
              return FractionallySizedBox(
                alignment: Alignment.centerLeft, // Aligns progress to the left
                widthFactor:
                    _animation.value, // Sets width based on animation value
                child: _GradientProgress(
                  borderRadius:
                      widget.style.gradientBorderRadius ??
                      widget.style.borderRadius, // Applies border radius
                  begin:
                      widget.style.progressGradientStart ??
                      Alignment.centerLeft, // Gradient start alignment
                  end:
                      widget.style.progressGradientEnd ??
                      Alignment.centerRight, // Gradient end alignment
                  colors: [
                    widget.style.variant ??
                        theme.variantColor, // Gradient colors
                    widget.style.accent ?? theme.accentColor,
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// A widget that shows progress along a line.
///
/// NeumorphicProgressIndeterminate is indeterminate.
///
/// You can provide a custom animation [duration]
///
/// Indeterminate progress indicators do not have a specific value at each point in time and instead indicate that progress is being made
/// without indicating how much progress remains. To create an indeterminate progress indicator, use a null value.
///
///  ```
///  NeumorphicProgressIndeterminate(
///      height: 15,
///  );
///
///  ```
///
class NeumorphicProgressIndeterminate extends StatefulWidget {
  final double height; // Height of the indeterminate progress bar
  final ProgressStyle style; // Custom style for the progress bar
  final Duration duration; // Animation duration
  final bool reverse; // Flag to reverse the animation
  final Curve curve; // Animation curve

  const NeumorphicProgressIndeterminate({
    super.key,
    this.height = 10,
    this.style = const ProgressStyle(),
    this.duration = const Duration(seconds: 3),
    this.reverse = false,
    this.curve = Curves.easeInOut,
  });

  @override
  createState() => _NeumorphicProgressIndeterminateState();

  @override
  // ignore: invalid_override_of_non_virtual_member
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicProgressIndeterminate &&
          runtimeType == other.runtimeType &&
          height == other.height &&
          style == other.style &&
          duration == other.duration &&
          reverse == other.reverse &&
          curve == other.curve;

  @override
  // ignore: invalid_override_of_non_virtual_member
  int get hashCode =>
      height.hashCode ^
      style.hashCode ^
      duration.hashCode ^
      reverse.hashCode ^
      curve.hashCode;
}

class _NeumorphicProgressIndeterminateState
    extends State<NeumorphicProgressIndeterminate>
    with TickerProviderStateMixin {
  late AnimationController _controller; // Controls the indeterminate animation
  late Animation _animation; // Defines the animation for indeterminate progress

  @override
  void initState() {
    super.initState();
    // Initializes the animation controller with the provided duration
    _controller = AnimationController(vsync: this, duration: widget.duration);
    // Sets up the animation tween from 0 to 1
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    _loop(); // Starts the animation loop
  }

  void _loop() async {
    try {
      // Repeats the animation with optional reverse
      await _controller
          .repeat(min: 0, max: 1, reverse: widget.reverse)
          .orCancel;
    } on TickerCanceled {}
  }

  @override
  void dispose() {
    _controller.dispose(); // Disposes the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Retrieves the current neumorphic theme
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);

    return FractionallySizedBox(
      widthFactor: 1, // Makes the progress bar span the full width
      child: SizedBox(
        height: widget.height, // Sets the height of the progress bar
        child: Neumorphic(
          padding: EdgeInsets.zero, // Removes padding
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(
              widget.style.borderRadius,
            ), // Sets the shape
            lightSource:
                widget.style.lightSource ??
                theme.lightSource, // Applies light source
            border: widget.style.border, // Applies border style
            disableDepth: widget.style.disableDepth, // Applies depth setting
            depth: widget.style.depth, // Applies depth effect
            shape: NeumorphicShape.flat, // Uses flat shape
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return AnimatedBuilder(
                animation: _animation, // Listens to animation changes
                builder: (_, __) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left:
                          constraints.maxWidth *
                          _animation.value, // Animates left padding
                    ),
                    child: FractionallySizedBox(
                      heightFactor: 1, // Full height
                      alignment: Alignment.centerLeft, // Aligns to the left
                      widthFactor: _animation.value, // Animates width
                      child: _GradientProgress(
                        borderRadius:
                            widget.style.gradientBorderRadius ??
                            widget.style.borderRadius, // Applies border radius
                        begin:
                            widget.style.progressGradientStart ??
                            Alignment.centerLeft, // Gradient start alignment
                        end:
                            widget.style.progressGradientEnd ??
                            Alignment.centerRight, // Gradient end alignment
                        colors: [
                          widget.style.accent ??
                              theme.accentColor, // Gradient colors
                          widget.style.variant ?? theme.variantColor,
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _GradientProgress extends StatelessWidget {
  final AlignmentGeometry begin; // Gradient start alignment
  final AlignmentGeometry end; // Gradient end alignment
  final List<Color> colors; // Colors for the gradient
  final BorderRadius borderRadius; // Border radius for the gradient container

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius, // Applies border radius
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: colors,
        ), // Applies gradient
      ),
    );
  }

  const _GradientProgress({
    required this.begin,
    required this.end,
    required this.colors,
    required this.borderRadius,
  });
}

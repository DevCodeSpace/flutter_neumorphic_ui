import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

typedef NeumorphicSliderListener =
    void Function(double percent); // Callback type for slider value changes

/// A style to customize the [NeumorphicSlider]
///
/// the gradient will use [accent] and [variant]
///
/// the gradient shape will be a roundrect, using [borderRadius]
///
/// you can define a custom [depth] for the roundrect
///
@immutable
class SliderStyle {
  final double depth; // Depth effect for the neumorphic style
  final bool disableDepth; // Flag to disable depth effect
  final BorderRadius borderRadius; // Border radius for the slider track
  final Color? accent; // Accent color for the gradient
  final Color? variant; // Variant color for the gradient
  final LightSource? lightSource; // Light source for the neumorphic effect

  final NeumorphicBorder border; // Border style for the slider track
  final NeumorphicBorder thumbBorder; // Border style for the thumb

  const SliderStyle({
    this.depth = 0,
    this.disableDepth = false,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.accent,
    this.lightSource,
    this.variant,
    this.border = const NeumorphicBorder.none(),
    this.thumbBorder = const NeumorphicBorder.none(),
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SliderStyle &&
          runtimeType == other.runtimeType &&
          depth == other.depth &&
          disableDepth == other.disableDepth &&
          lightSource == other.lightSource &&
          borderRadius == other.borderRadius &&
          thumbBorder == other.thumbBorder &&
          border == other.border &&
          accent == other.accent &&
          variant == other.variant;

  @override
  int get hashCode =>
      depth.hashCode ^
      disableDepth.hashCode ^
      borderRadius.hashCode ^
      border.hashCode ^
      lightSource.hashCode ^
      thumbBorder.hashCode ^
      accent.hashCode ^
      variant.hashCode;
}

/// A Neumorphic Design slider.
///
/// Used to select from a range of values.
///
/// The default is to use a continuous range of values from min to max.
///
/// listeners : [onChanged], [onChangeStart], [onChangeEnd]
///
/// ```
///  //in a statefull widget
///
///  double seekValue = 0;
///
///  Widget _buildSlider() {
///    return Row(
///      children: <Widget>[
///
///        Flexible(
///          child: NeumorphicSlider(
///              height: 15,
///              value: seekValue,
///              min: 0,
///              max: 10,
///              onChanged: (value) {
///                setState(() {
///                  seekValue = value;
///                });
///              }),
///        ),
///
///        Text("value: ${seekValue.round()}"),
///
///      ],
///    );
///  }
///  ```
///
@immutable
class NeumorphicSlider extends StatefulWidget {
  final SliderStyle style; // Custom style for the slider
  final double min; // Minimum value of the slider
  final double value; // Current value of the slider
  final double max; // Maximum value of the slider
  final double height; // Height of the slider
  final NeumorphicSliderListener? onChanged; // Callback for value changes
  final NeumorphicSliderListener? onChangeStart; // Callback when sliding starts
  final NeumorphicSliderListener? onChangeEnd; // Callback when sliding ends
  final Widget? thumb; // Custom thumb widget
  final double? sliderHeight; // Optional custom height for the slider track

  const NeumorphicSlider({
    super.key,
    this.style = const SliderStyle(),
    this.min = 0,
    this.value = 0,
    this.max = 10,
    this.height = 15,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.thumb,
    this.sliderHeight,
  });

  double get percent =>
      (((value.clamp(min, max)) - min) /
      ((max - min))); // Percentage of current value

  @override
  createState() => _NeumorphicSliderState();
}

class _NeumorphicSliderState extends State<NeumorphicSlider> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            final tapPos =
                details.localPosition; // Gets the position of the drag
            final newPercent =
                tapPos.dx / constraints.maxWidth; // Calculates new percentage
            final newValue =
                ((widget.min + (widget.max - widget.min) * newPercent)).clamp(
                  widget.min,
                  widget.max,
                ); // Maps percentage to value within min/max

            if (widget.onChanged != null) {
              widget.onChanged!(newValue); // Notifies value change
            }
          },
          onPanStart: (DragStartDetails details) {
            if (widget.onChangeStart != null) {
              widget.onChangeStart!(widget.value); // Notifies start of sliding
            }
          },
          onPanEnd: (details) {
            if (widget.onChangeEnd != null) {
              widget.onChangeEnd!(widget.value); // Notifies end of sliding
            }
          },
          child: _widget(context), // Builds the slider widget
        );
      },
    );
  }

  Widget _widget(BuildContext context) {
    double thumbSize =
        widget.height * 1.5; // Calculates thumb size based on slider height
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: thumbSize / 2,
            right: thumbSize / 2,
          ), // Adds padding for thumb
          child: _generateSlider(context), // Generates the slider track
        ),
        Align(
          alignment: Alignment(
            // Maps percent to alignment (-1 to 1)
            (widget.percent * 2) - 1,
            0,
          ),
          child:
              widget.thumb ??
              _generateThumb(context, thumbSize), // Renders thumb
        ),
      ],
    );
  }

  Widget _generateSlider(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(
      context,
    ); // Retrieves current theme
    return NeumorphicProgress(
      duration: Duration.zero, // Disables animation
      percent: widget.percent, // Sets progress to current percentage
      height: widget.height, // Sets track height
      style: ProgressStyle(
        disableDepth: widget.style.disableDepth, // Applies depth setting
        depth: widget.style.depth, // Applies depth effect
        border: widget.style.border, // Applies border style
        lightSource:
            widget.style.lightSource ??
            theme.lightSource, // Applies light source
        borderRadius: widget.style.borderRadius, // Applies border radius
        accent:
            widget.style.accent ?? theme.accentColor, // Applies accent color
        variant:
            widget.style.variant ?? theme.variantColor, // Applies variant color
      ),
    );
  }

  Widget _generateThumb(BuildContext context, double size) {
    final theme = NeumorphicTheme.currentTheme(
      context,
    ); // Retrieves current theme
    return Neumorphic(
      style: NeumorphicStyle(
        disableDepth: widget.style.disableDepth, // Applies depth setting
        shape: NeumorphicShape.concave, // Sets concave shape for thumb
        border: widget.style.thumbBorder, // Applies thumb border
        lightSource:
            widget.style.lightSource ??
            theme.lightSource, // Applies light source
        color: widget.style.accent ?? theme.accentColor, // Applies thumb color
        boxShape: NeumorphicBoxShape.circle(), // Sets circular shape
      ),
      child: SizedBox(height: size, width: size), // Sets thumb size
    );
  }
}

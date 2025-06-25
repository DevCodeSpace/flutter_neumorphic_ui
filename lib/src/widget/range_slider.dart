import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

typedef NeumorphicRangeSliderLowListener =
    void Function(double percent); // Callback for low value changes
typedef NeumorphicRangeSliderHighListener =
    void Function(double percent); // Callback for high value changes

/// A style to customize the [NeumorphicSlider]
///
/// the gradient will use [accent] and [variant]
///
/// the gradient shape will be a roundrect, using [borderRadius]
///
/// you can define a custom [depth] for the roundrect
///
@immutable
class RangeSliderStyle {
  final double depth; // Depth effect for the neumorphic style
  final bool disableDepth; // Flag to disable depth effect
  final BorderRadius borderRadius; // Border radius for the slider
  final Color? accent; // Accent color for the gradient
  final Color? variant; // Variant color for the gradient
  final LightSource? lightSource; // Light source for the neumorphic effect

  final NeumorphicBorder border; // Border style for the slider
  final NeumorphicBorder thumbBorder; // Border style for the thumb

  const RangeSliderStyle({
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
      other is RangeSliderStyle &&
          runtimeType == other.runtimeType &&
          depth == other.depth &&
          lightSource == other.lightSource &&
          disableDepth == other.disableDepth &&
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
      lightSource.hashCode ^
      accent.hashCode ^
      border.hashCode ^
      thumbBorder.hashCode ^
      variant.hashCode;
}

/// A Neumorphic Design range slider.
///
/// Used to select a range of values.
///
///
/// listeners : [onChangedLow], [onChangeHigh]
///
/// ```
///  //in a statefull widget
///
///  double minPrice = 20;
///  double maxPrice = 90;
///
///  Widget _buildSlider() {
///    return Row(
///      children: <Widget>[
///
///        Flexible(
///          child: NeumorphicRangeSlider(
///              valueLow: minPrice,
///              valueHigh: maxPrice,
///              min: 18,
///              max: 99,
///              onChangedLow: (value) {
///                setState(() {
///                  minPrice = value;
///                });
///              },
///              onChangeHigh: (value) {
///                setState(() {
///                  maxPrice = value;
///                });
///              },
///            ),
///          ),
///          Text(
///            "${minPrice.round()} - ${maxPrice.round()}",
///            style: TextStyle(color:  NeumorphicTheme.defaultTextColor(context)),
///          ),
///
///      ],
///    );
///  }
///  ```
///
@immutable
class NeumorphicRangeSlider extends StatefulWidget {
  final RangeSliderStyle style; // Custom style for the range slider
  final double min; // Minimum value of the slider
  final double valueLow; // Current low value of the range
  final double valueHigh; // Current high value of the range
  final double max; // Maximum value of the slider
  final double height; // Height of the slider
  final double? sliderHeight; // Optional custom height for the slider track
  final NeumorphicRangeSliderLowListener?
  onChangedLow; // Callback for low value changes
  final NeumorphicRangeSliderHighListener?
  onChangeHigh; // Callback for high value changes
  final Function(ActiveThumb)? onPanStarted; // Callback when panning starts
  final Function(ActiveThumb)? onPanEnded; // Callback when panning ends
  final Widget? thumb; // Custom thumb widget

  const NeumorphicRangeSlider({
    super.key,
    this.style = const RangeSliderStyle(),
    this.min = 0,
    this.max = 10,
    this.valueLow = 0,
    this.valueHigh = 10,
    this.height = 15,
    this.onChangedLow,
    this.onChangeHigh,
    this.onPanStarted,
    this.onPanEnded,
    this.sliderHeight,
    this.thumb,
  });

  double get percentLow =>
      (((valueLow.clamp(min, max)) - min) /
      ((max - min))); // Percentage of low value

  double get percentHigh =>
      (((valueHigh.clamp(min, max)) - min) /
      ((max - min))); // Percentage of high value

  @override
  createState() => _NeumorphicRangeSliderState();
}

class _NeumorphicRangeSliderState extends State<NeumorphicRangeSlider> {
  late ActiveThumb _activeThumb; // Tracks which thumb (low or high) is active
  late bool
  _canChangeActiveThumb; // Flag to allow switching active thumb during drag

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return _widget(
          context,
          constraints,
        ); // Builds the slider widget with constraints
      },
    );
  }

  Widget _widget(BuildContext context, BoxConstraints constraints) {
    double thumbSize =
        widget.height * 1.5; // Calculates thumb size based on slider height

    panUpdate(DragUpdateDetails details) {
      final tapPos = details.localPosition; // Gets the position of the drag
      final newPercent =
          tapPos.dx / constraints.maxWidth; // Calculates new percentage
      final newValue = ((widget.min + (widget.max - widget.min) * newPercent))
          .clamp(
            widget.min,
            widget.max,
          ); // Maps percentage to value within min/max

      switch (_activeThumb) {
        case ActiveThumb.low:
          if (newValue < widget.valueHigh) {
            _canChangeActiveThumb = false; // Prevents thumb switching
            if (widget.onChangedLow != null) {
              widget.onChangedLow!(newValue); // Updates low value
            }
          } else if (_canChangeActiveThumb && details.delta.dx > 0) {
            _canChangeActiveThumb =
                false; // Switches to high thumb if dragging right
            _activeThumb = ActiveThumb.high;
          }
          break;
        case ActiveThumb.high:
          if (newValue > widget.valueLow) {
            _canChangeActiveThumb = false; // Prevents thumb switching
            if (widget.onChangeHigh != null) {
              widget.onChangeHigh!(newValue); // Updates high value
            }
          } else if (_canChangeActiveThumb && details.delta.dx < 0) {
            _canChangeActiveThumb =
                false; // Switches to low thumb if dragging left
            _activeThumb = ActiveThumb.low;
          }
          break;
      }
    }

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: thumbSize / 2,
            right: thumbSize / 2,
          ), // Adds padding for thumbs
          child: _generateSlider(context), // Generates the slider track
        ),
        Align(
          alignment: Alignment(
            // Maps percentLow to alignment (-1 to 1)
            (widget.percentLow * 2) - 1,
            0,
          ),
          child: GestureDetector(
            onHorizontalDragStart: (DragStartDetails details) {
              _canChangeActiveThumb = true; // Allows thumb switching
              _activeThumb = ActiveThumb.low; // Sets low thumb as active
              if (widget.onPanStarted != null) {
                widget.onPanStarted!(_activeThumb); // Notifies pan start
              }
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              panUpdate(details); // Handles drag updates
            },
            onHorizontalDragEnd: (details) {
              if (widget.onPanEnded != null) {
                widget.onPanEnded!(_activeThumb); // Notifies pan end
              }
            },
            child:
                widget.thumb ??
                _generateThumb(
                  context,
                  thumbSize,
                  widget.style.variant,
                ), // Renders low thumb
          ),
        ),
        Align(
          alignment: Alignment(
            // Maps percentHigh to alignment (-1 to 1)
            (widget.percentHigh * 2) - 1,
            0,
          ),
          child: GestureDetector(
            onHorizontalDragStart: (DragStartDetails details) {
              _canChangeActiveThumb = true; // Allows thumb switching
              _activeThumb = ActiveThumb.high; // Sets high thumb as active
              if (widget.onPanStarted != null) {
                widget.onPanStarted!(_activeThumb); // Notifies pan start
              }
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              panUpdate(details); // Handles drag updates
            },
            onHorizontalDragEnd: (details) {
              if (widget.onPanEnded != null) {
                widget.onPanEnded!(_activeThumb); // Notifies pan end
              }
            },
            child:
                widget.thumb ??
                _generateThumb(
                  context,
                  thumbSize,
                  widget.style.accent,
                ), // Renders high thumb
          ),
        ),
      ],
    );
  }

  Widget _generateSlider(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(
      context,
    ); // Retrieves current theme
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        NeumorphicProgress(
          duration: Duration.zero, // Disables animation
          percent: 0, // Sets progress to 0 for background
          height: widget.sliderHeight ?? widget.height, // Sets track height
          style: ProgressStyle(
            disableDepth: widget.style.disableDepth, // Applies depth setting
            depth: widget.style.depth, // Applies depth effect
            border: widget.style.border, // Applies border style
            borderRadius: widget.style.borderRadius, // Applies border radius
            accent:
                widget.style.accent ??
                theme.accentColor, // Applies accent color
            variant:
                widget.style.variant ??
                theme.variantColor, // Applies variant color
          ),
        ),
        Positioned.fill(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: EdgeInsets.only(
                  left:
                      constraints.biggest.width *
                      widget.percentLow, // Left padding for low value
                  right:
                      constraints.biggest.width *
                      (1 - widget.percentHigh), // Right padding for high value
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        widget.style.borderRadius, // Applies border radius
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft, // Gradient start
                      end: Alignment.centerRight, // Gradient end
                      colors: [
                        widget.style.variant ??
                            theme.variantColor, // Gradient colors
                        widget.style.accent ?? theme.accentColor,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _generateThumb(BuildContext context, double size, Color? color) {
    final theme = NeumorphicTheme.currentTheme(
      context,
    ); // Retrieves current theme
    return Neumorphic(
      style: NeumorphicStyle(
        disableDepth: widget.style.disableDepth, // Applies depth setting
        shape: NeumorphicShape.concave, // Sets concave shape for thumb
        color: color ?? theme.accentColor, // Applies thumb color
        border: widget.style.thumbBorder, // Applies thumb border
        boxShape: NeumorphicBoxShape.circle(), // Sets circular shape
        lightSource:
            widget.style.lightSource ??
            theme.lightSource, // Applies light source
      ),
      child: SizedBox(height: size, width: size), // Sets thumb size
    );
  }
}

enum ActiveThumb { low, high } // Enum to track active thumb (low or high)

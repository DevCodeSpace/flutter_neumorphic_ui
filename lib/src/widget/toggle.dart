import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

/// A style to customize the [NeumorphicToggle]
class NeumorphicToggleStyle {
  final double? depth; // Depth effect for the toggle
  final bool? disableDepth; // Flag to disable depth effect
  final BorderRadius borderRadius; // Border radius for the toggle
  final bool animateOpacity; // Flag to enable/disable opacity animation
  final Color? backgroundColor; // Background color of the toggle
  final NeumorphicBorder border; // Border style for the toggle
  final LightSource? lightSource; // Light source for the neumorphic effect

  const NeumorphicToggleStyle({
    this.depth,
    this.animateOpacity = true,
    this.backgroundColor,
    this.lightSource,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.disableDepth,
    this.border = const NeumorphicBorder.none(),
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicToggleStyle &&
          runtimeType == other.runtimeType &&
          depth == other.depth &&
          border == other.border &&
          backgroundColor == other.backgroundColor &&
          lightSource == other.lightSource &&
          disableDepth == other.disableDepth &&
          borderRadius == other.borderRadius &&
          animateOpacity == other.animateOpacity;

  @override
  int get hashCode =>
      depth.hashCode ^
      backgroundColor.hashCode ^
      lightSource.hashCode ^
      border.hashCode ^
      disableDepth.hashCode ^
      borderRadius.hashCode ^
      animateOpacity.hashCode;
}

/// Direct child of NeumorphicToggle
/// Contains two widgets: background & foreground
///
/// The thumb is displayed between background & foreground
///
/// Expanded(
///  child: NeumorphicToggle(
///    height: 50,
///    selectedIndex: _selectedIndex,
///    displayForegroundOnlyIfSelected: true,
///    children: [
///      ToggleElement(
///        background: Center(child: Text("This week", style: TextStyle(fontWeight: FontWeight.w500),)),
///        foreground: Center(child: Text("This week", style: TextStyle(fontWeight: FontWeight.w700),)),
///      ),
///      ToggleElement(
///        background: Center(child: Text("This month", style: TextStyle(fontWeight: FontWeight.w500),)),
///        foreground: Center(child: Text("This month", style: TextStyle(fontWeight: FontWeight.w700),)),
///      ),
///      ToggleElement(
///        background: Center(child: Text("This year", style: TextStyle(fontWeight: FontWeight.w500),)),
///        foreground: Center(child: Text("This year", style: TextStyle(fontWeight: FontWeight.w700),)),
///      )
///    ],
///    thumb: Neumorphic(
///      boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.all(Radius.circular(12))),
///    ),
///    onChanged: (value) {
///      setState(() {
///        _selectedIndex = value;
///        print("_firstSelected: $_selectedIndex");
///      });
///    },
///  ),
///),
class ToggleElement {
  final Widget? background; // Background widget for the toggle element
  final Widget? foreground; // Foreground widget for the toggle element

  ToggleElement({this.background, this.foreground});
}

///
/// Switch with custom thumb (defined with list of ToggleElements)
///
/// does not save the state
///   - notifies a `ValueChanged<int>` : onChanged
///   - need a `selectedIndex` parameter
///oggle
/// Expanded(
///  child: NeumorphicToggle(
///    height: 50,
///    selectedIndex: _selectedIndex,
///    displayForegroundOnlyIfSelected: true,
///    children: [
///      ToggleElement(
///        background: Center(child: Text("This week", style: TextStyle(fontWeight: FontWeight.w500),)),
///        foreground: Center(child: Text("This week", style: TextStyle(fontWeight: FontWeight.w700),)),
///      ),
///      ToggleElement(
///        background: Center(child: Text("This month", style: TextStyle(fontWeight: FontWeight.w500),)),
///        foreground: Center(child: Text("This month", style: TextStyle(fontWeight: FontWeight.w700),)),
///      ),
///      ToggleElement(
///        background: Center(child: Text("This year", style: TextStyle(fontWeight: FontWeight.w500),)),
///        foreground: Center(child: Text("This year", style: TextStyle(fontWeight: FontWeight.w700),)),
///      )
///    ],
///    thumb: Neumorphic(
///      boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.all(Radius.circular(12))),
///    ),
///    onChanged: (value) {
///      setState(() {
///        _selectedIndex = value;
///        print("_firstSelected: $_selectedIndex");
///      });
///    },
///  ),
///),
@immutable
class NeumorphicToggle extends StatelessWidget {
  static const minEmbossDepth = -1.0; // Minimum depth for emboss effect

  final EdgeInsets padding; // Padding around the toggle
  final List<ToggleElement> children; // List of toggle elements
  final Widget thumb; // Custom thumb widget
  final int selectedIndex; // Currently selected index
  final ValueChanged<int>? onChanged; // Callback for index changes
  final Function(int)?
  onAnimationChangedFinished; // Callback when animation finishes
  final NeumorphicToggleStyle? style; // Custom style for the toggle
  final double height; // Height of the toggle
  final double? width; // Optional width of the toggle
  final Duration duration; // Animation duration
  final bool isEnabled; // Flag to enable/disable the toggle
  final Curve movingCurve; // Animation curve for thumb movement
  final Curve alphaAnimationCurve; // Animation curve for opacity
  final bool
  displayForegroundOnlyIfSelected; // Flag to show foreground only for selected element

  const NeumorphicToggle({
    this.style = const NeumorphicToggleStyle(),
    super.key,
    required this.children,
    required this.thumb,
    this.padding = const EdgeInsets.all(2),
    this.duration = const Duration(milliseconds: 200),
    this.selectedIndex = 0,
    this.alphaAnimationCurve = Curves.linear,
    this.movingCurve = Curves.linear,
    this.onAnimationChangedFinished,
    this.onChanged,
    this.height = 40,
    this.width,
    this.isEnabled = true,
    this.displayForegroundOnlyIfSelected = true,
  });

  /// Builds the stack of background, toggle elements, thumb, and foreground
  Widget _buildStack(BuildContext context) {
    return Stack(
      children: [
        _background(context), // Renders the background
        Row(
          mainAxisSize: MainAxisSize.max,
          children: _generateBackgrounds(),
        ), // Renders background elements
        AnimatedAlign(
          curve: movingCurve, // Applies animation curve for thumb movement
          onEnd: () {
            if (onAnimationChangedFinished != null) {
              onAnimationChangedFinished!(
                selectedIndex,
              ); // Notifies animation completion
            }
          },
          alignment: _alignment(), // Sets thumb alignment
          duration: duration, // Sets animation duration
          child: FractionallySizedBox(
            widthFactor:
                1 /
                children
                    .length, // Sets thumb width relative to number of elements
            heightFactor: 1, // Fills available height
            child: Neumorphic(
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.roundRect(
                  style?.borderRadius ?? BorderRadius.all(Radius.circular(12)),
                ), // Applies border radius
              ),
              margin: padding, // Applies padding
              child: thumb, // Renders custom thumb
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: _generateForegrounds(),
        ), // Renders foreground elements
      ],
    );
  }

  /// Generates a list of background widgets for each toggle element
  List<Widget> _generateBackgrounds() {
    final List<Widget> widgets = [];
    for (int i = 0; i < children.length; ++i) {
      widgets.add(_backgroundAtIndex(i));
    }
    return widgets;
  }

  /// Generates a list of foreground widgets for each toggle element
  List<Widget> _generateForegrounds() {
    final List<Widget> widgets = [];
    for (int i = 0; i < children.length; ++i) {
      widgets.add(_foregroundAtIndex(i));
    }
    return widgets;
  }

  /// Calculates the alignment for the thumb based on selected index
  Alignment _alignment() {
    double percentX =
        selectedIndex / (children.length - 1); // Percentage of selected index
    double aligmentX = -1.0 + (2.0 * percentX); // Maps to alignment (-1 to 1)
    return Alignment(aligmentX, 0.0);
  }

  /// Returns the background widget at the specified index
  Widget _backgroundAtIndex(int index) {
    return Expanded(
      flex: 1,
      child:
          children[index].background ??
          SizedBox.expand(), // Uses background or empty widget
    );
  }

  /// Returns the foreground widget at the specified index with optional opacity animation
  Widget _foregroundAtIndex(int index) {
    Widget? child =
        (!displayForegroundOnlyIfSelected) ||
            (displayForegroundOnlyIfSelected && selectedIndex == index)
        ? children[index].foreground
        : SizedBox.expand(); // Shows foreground only if selected or flag is false
    // Wrap with opacity animation if enabled
    if (style != null && style!.animateOpacity) {
      child = AnimatedOpacity(
        curve: alphaAnimationCurve, // Applies opacity animation curve
        opacity: selectedIndex == index
            ? 1
            : 0, // Sets opacity based on selection
        duration: duration, // Sets animation duration
        child: child,
      );
    }
    return Expanded(
      flex: 1,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque, // Ensures full area is tappable
        onTap: () {
          _notifyOnChange(index); // Notifies index change on tap
        },
        child: child,
      ),
    );
  }

  /// Renders the background of the toggle
  Widget _background(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(
          style?.borderRadius ?? BorderRadius.all(Radius.circular(12)),
        ), // Applies border radius
        color: style?.backgroundColor, // Applies background color
        disableDepth: style?.disableDepth, // Applies depth setting
        depth: _getTrackDepth(context), // Sets track depth
        shape: NeumorphicShape.flat, // Uses flat shape
        border: style?.border ?? NeumorphicBorder.none(), // Applies border
        lightSource:
            style?.lightSource ??
            NeumorphicTheme.currentTheme(
              context,
            ).lightSource, // Applies light source
      ),
      child: SizedBox.expand(), // Fills available space
    );
  }

  @override
  Widget build(BuildContext context) {
    if (width != null) {
      return SizedBox(
        height: height, // Sets fixed height
        width: width, // Sets fixed width
        child: _buildStack(context), // Builds toggle stack
      );
    } else {
      return FractionallySizedBox(
        widthFactor: 1.0, // Fills available width
        child: SizedBox(
          height: height,
          child: _buildStack(context),
        ), // Sets height and builds stack
      );
    }
  }

  /// Calculates the track depth with emboss effect
  double _getTrackDepth(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);
    // Forces negative depth for emboss effect
    final double depth = -1 * (style?.depth ?? theme.depth).abs();
    return depth.clamp(Neumorphic.minDepth, NeumorphicToggle.minEmbossDepth);
  }

  /// Notifies the parent of a change in selected index
  void _notifyOnChange(int newValue) {
    if (onChanged != null) {
      onChanged!(newValue);
    }
  }
}

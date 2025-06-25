import 'package:example/view/widgets/theme/color_selector.dart';
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Root widget for the Neumorphic Accessibility demo page
class NeumorphicAccessibility extends StatefulWidget {
  const NeumorphicAccessibility({super.key});

  @override
  _NeumorphicAccessibilityState createState() =>
      _NeumorphicAccessibilityState();
}

// State class for applying the Neumorphic theme
class _NeumorphicAccessibilityState extends State<NeumorphicAccessibility> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        baseColor: Color(0xffDDDDDD),
        lightSource: LightSource.topLeft,
        depth: 6,
        intensity: 0.5,
      ),
      child: _Page(),
    );
  }
}

// Container widget for the layout and UI of the Accessibility page
class _Page extends StatefulWidget {
  @override
  __PageState createState() => __PageState();
}

// State class for managing the page's UI and state
class __PageState extends State<_Page> {
  LightSource lightSource = LightSource.topLeft;
  NeumorphicShape shape = NeumorphicShape.flat;
  NeumorphicBoxShape boxShape = NeumorphicBoxShape.roundRect(
    BorderRadius.circular(12),
  );
  double depth = 5;
  double intensity = 0.5;
  double surfaceIntensity = 0.5;
  double cornerRadius = 20;
  double height = 150.0;
  double width = 150.0;
  bool haveNeumorphicChild = false;
  bool childOppositeLightsourceChild = false;
  bool drawAboveChild = false;
  double childMargin = 5;
  double childDepth = 5;
  int selectedConfiguratorIndex = 0;

  late Color borderColor;
  late double borderWidth;

  static final minWidth = 50.0;
  static final maxWidth = 200.0;
  static final minHeight = 50.0;
  static final maxHeight = 200.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    borderColor = NeumorphicTheme.currentTheme(context).borderColor;
    borderWidth = NeumorphicTheme.currentTheme(context).borderWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: Stack(
                children: [
                  lightSourceWidgets(),
                  Center(child: neumorphic()),
                ],
              ),
            ),
            _buildBottomConfigurator(),
          ],
        ),
      ),
    );
  }

  // Builds the custom app bar
  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          NeumorphicButton(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.stadium(),
              depth: 2,
              color: Colors.deepPurpleAccent,
            ),
            child: const Text(
              "Back",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  // Builds the bottom configurator panel
  Widget _buildBottomConfigurator() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      padding: const EdgeInsets.only(top: 16, bottom: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ToggleButtons(
            borderRadius: BorderRadius.circular(16),
            selectedColor: Colors.white,
            fillColor: Colors.deepPurpleAccent,
            color: Colors.black.withOpacity(0.5),
            isSelected: List.generate(
              3,
              (index) => index == selectedConfiguratorIndex,
            ),
            onPressed: (index) =>
                setState(() => selectedConfiguratorIndex = index),
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("Style"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("Element"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("Child"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _configuratorsChild() ?? const SizedBox(),
          ),
        ],
      ),
    );
  }

  // Returns the appropriate configurator based on selected index
  Widget? _configuratorsChild() {
    switch (selectedConfiguratorIndex) {
      case 0:
        return styleCustomizer();
      case 1:
        return elementCustomizer();
      case 2:
        return childCustomizer();
      default:
        return const SizedBox();
    }
  }

  // Builds the style configurator
  Widget styleCustomizer() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        depthSelector(),
        intensitySelector(),
        surfaceIntensitySelector(),
        colorPicker(),
        borderColorPicker(),
        borderWidthSelector(),
      ],
    );
  }

  // Builds the element configurator
  Widget elementCustomizer() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [cornerRadiusSelector(), shapeWidget(), sizeSelector()],
    );
  }

  // Builds the child configurator
  Widget childCustomizer() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        hasChildSelector(),
        drawAboveChildSelector(),
        childDepthSelector(),
        childMarginSelector(),
        childOppositeLightsourceSelector(),
      ],
    );
  }

  // Builds the color picker
  Widget colorPicker() {
    return Row(
      children: <Widget>[
        SizedBox(width: 12),
        Text("Color"),
        SizedBox(width: 4),
        ColorSelector(
          onColorChanged: (color) {
            setState(() {
              NeumorphicTheme.of(
                context,
              )?.updateCurrentTheme(NeumorphicThemeData(baseColor: color));
            });
          },
          color: NeumorphicTheme.baseColor(context),
        ),
      ],
    );
  }

  // Builds the border color picker
  Widget borderColorPicker() {
    return Row(
      children: <Widget>[
        SizedBox(width: 12),
        Text("BorderColor"),
        SizedBox(width: 4),
        ColorSelector(
          onColorChanged: (color) {
            setState(() {
              borderColor = color;
            });
          },
          color: borderColor,
        ),
      ],
    );
  }

  // Builds the main neumorphic widget for preview
  Widget neumorphic() {
    return NeumorphicButton(
      padding: EdgeInsets.zero,
      duration: Duration(milliseconds: 300),
      drawSurfaceAboveChild: drawAboveChild,
      onPressed: () {
        setState(() {});
      },
      style: NeumorphicStyle(
        boxShape: boxShape,
        border: NeumorphicBorder(
          isEnabled: true,
          width: borderWidth,
          color: borderColor,
        ),
        shape: shape,
        intensity: intensity,
        surfaceIntensity: surfaceIntensity,
        depth: depth,
        lightSource: lightSource,
      ),
      child: SizedBox(
        height: height,
        width: width,
        child: haveNeumorphicChild
            ? neumorphicChild()
            : Center(child: Text("Preview")),
      ),
    );
  }

  // Builds the child neumorphic widget
  Widget neumorphicChild() {
    return Neumorphic(
      padding: EdgeInsets.zero,
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.all(childMargin),
      drawSurfaceAboveChild: true,
      style: NeumorphicStyle(
        boxShape: boxShape,
        intensity: intensity,
        surfaceIntensity: surfaceIntensity,
        depth: childDepth,
        lightSource: lightSource,
        oppositeShadowLightSource: childOppositeLightsourceChild,
      ),
      child: SizedBox.expand(),
    );
  }

  // Builds the depth selector slider
  Widget depthSelector() {
    return Row(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(left: 12), child: Text("Depth")),
        Expanded(
          child: Slider(
            min: Neumorphic.minDepth,
            max: Neumorphic.maxDepth,
            value: depth,
            onChanged: (value) {
              setState(() {
                depth = value;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(depth.floor().toString()),
        ),
      ],
    );
  }

  // Builds the border width selector slider
  Widget borderWidthSelector() {
    return Row(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(left: 12), child: Text("BorderWidth")),
        Expanded(
          child: Slider(
            min: 0,
            max: 10,
            value: borderWidth,
            onChanged: (value) {
              setState(() {
                borderWidth = value;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(borderWidth.floor().toString()),
        ),
      ],
    );
  }

  // Builds the size selector sliders
  Widget sizeSelector() {
    return Row(
      children: <Widget>[
        SizedBox(width: 12),
        Text("W:"),
        Expanded(
          child: Slider(
            min: minWidth,
            max: maxWidth,
            value: width,
            onChanged: (value) {
              setState(() {
                width = value;
              });
            },
          ),
        ),
        Text("H:"),
        Expanded(
          child: Slider(
            min: minHeight,
            max: maxHeight,
            value: height,
            onChanged: (value) {
              setState(() {
                height = value;
              });
            },
          ),
        ),
      ],
    );
  }

  // Builds the corner radius selector slider
  Widget cornerRadiusSelector() {
    if (boxShape.isRoundRect) {
      return Row(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(left: 12), child: Text("Corner")),
          Expanded(
            child: Slider(
              min: 0,
              max: 30,
              value: cornerRadius,
              onChanged: (value) {
                setState(() {
                  cornerRadius = value;
                  if (boxShape.isRoundRect) {
                    boxShape = NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(cornerRadius),
                    );
                  }
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Text(cornerRadius.floor().toString()),
          ),
        ],
      );
    } else {
      return SizedBox();
    }
  }

  // Builds the intensity selector slider
  Widget intensitySelector() {
    return Row(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(left: 12), child: Text("Intensity")),
        Expanded(
          child: Slider(
            min: Neumorphic.minIntensity,
            max: Neumorphic.maxIntensity,
            value: intensity,
            onChanged: (value) {
              setState(() {
                intensity = value;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(((intensity * 100).floor() / 100).toString()),
        ),
      ],
    );
  }

  // Builds the surface intensity selector slider
  Widget surfaceIntensitySelector() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("SurfaceIntensity"),
        ),
        Expanded(
          child: Slider(
            min: Neumorphic.minIntensity,
            max: Neumorphic.maxIntensity,
            value: surfaceIntensity,
            onChanged: (value) {
              setState(() {
                surfaceIntensity = value;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(((surfaceIntensity * 100).floor() / 100).toString()),
        ),
      ],
    );
  }

  // Builds the shape selector buttons
  Widget shapeWidget() {
    final Color iconActiveColor = Colors.black87;
    final Color iconInactiveColor = Colors.black38;

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: NeumorphicButton(
              onPressed: () {
                setState(() {
                  shape = NeumorphicShape.concave;
                });
              },
              style: NeumorphicStyle(
                shape: shape == NeumorphicShape.concave
                    ? NeumorphicShape.concave
                    : NeumorphicShape.flat,
                depth: shape == NeumorphicShape.concave ? 4 : 1,
              ),
              child: Image.asset(
                "assets/images/concave.png",
                color: shape == NeumorphicShape.concave
                    ? iconActiveColor
                    : iconInactiveColor,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: NeumorphicButton(
              onPressed: () {
                setState(() {
                  shape = NeumorphicShape.convex;
                });
              },
              style: NeumorphicStyle(
                shape: shape == NeumorphicShape.convex
                    ? NeumorphicShape.convex
                    : NeumorphicShape.flat,
                depth: shape == NeumorphicShape.convex ? 4 : 1,
              ),
              child: Image.asset(
                "assets/images/convex.png",
                color: shape == NeumorphicShape.convex
                    ? iconActiveColor
                    : iconInactiveColor,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: NeumorphicButton(
              onPressed: () {
                setState(() {
                  shape = NeumorphicShape.flat;
                });
              },
              style: NeumorphicStyle(
                shape: shape == NeumorphicShape.flat
                    ? NeumorphicShape.concave
                    : NeumorphicShape.flat,
                depth: shape == NeumorphicShape.flat ? 4 : 1,
              ),
              child: Image.asset(
                "assets/images/flat.png",
                color: shape == NeumorphicShape.flat
                    ? iconActiveColor
                    : iconInactiveColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Builds the toggle for enabling/disabling child widget
  Widget hasChildSelector() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text("Has Child"),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Checkbox(
            value: haveNeumorphicChild,
            onChanged: (value) {
              setState(() {
                haveNeumorphicChild = value!;
              });
            },
          ),
        ),
      ],
    );
  }

  // Builds the toggle for drawing above child
  Widget drawAboveChildSelector() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text("Draw above child"),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Checkbox(
            value: drawAboveChild,
            onChanged: (value) {
              setState(() {
                drawAboveChild = value!;
              });
            },
          ),
        ),
      ],
    );
  }

  // Builds the child depth selector slider
  Widget childDepthSelector() {
    return Row(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(left: 12), child: Text("Child Depth")),
        Expanded(
          child: Slider(
            min: Neumorphic.minDepth,
            max: Neumorphic.maxDepth,
            value: childDepth,
            onChanged: (value) {
              setState(() {
                childDepth = value;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(childDepth.floor().toString()),
        ),
      ],
    );
  }

  // Builds the child margin selector slider
  Widget childMarginSelector() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("Child Margin"),
        ),
        Expanded(
          child: Slider(
            min: 0,
            max: 40,
            value: childMargin,
            onChanged: (value) {
              setState(() {
                childMargin = value;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(childMargin.floor().toString()),
        ),
      ],
    );
  }

  // Builds the toggle for opposite light source
  Widget childOppositeLightsourceSelector() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text("OppositeLight"),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Checkbox(
            value: childOppositeLightsourceChild,
            onChanged: (value) {
              setState(() {
                childOppositeLightsourceChild = value!;
              });
            },
          ),
        ),
      ],
    );
  }

  // Builds sliders for adjusting light source position
  Widget lightSourceWidgets() {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 10,
          right: 10,
          child: Slider(
            min: -1,
            max: 1,
            value: lightSource.dx,
            onChanged: (value) {
              setState(() {
                lightSource = lightSource.copyWith(dx: value);
              });
            },
          ),
        ),
        Positioned(
          left: 0,
          top: 10,
          bottom: 10,
          child: RotatedBox(
            quarterTurns: 1,
            child: Slider(
              min: -1,
              max: 1,
              value: lightSource.dy,
              onChanged: (value) {
                setState(() {
                  lightSource = lightSource.copyWith(dy: value);
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}

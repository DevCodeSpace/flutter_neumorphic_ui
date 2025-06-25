import 'package:example/view/widgets/theme/color_selector.dart';
import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Root widget for the Neumorphic Text Playground demo page
class NeumorphicTextPlayground extends StatefulWidget {
  const NeumorphicTextPlayground({super.key});

  @override
  State<NeumorphicTextPlayground> createState() => _NeumorphicPlaygroundState();
}

class _NeumorphicPlaygroundState extends State<NeumorphicTextPlayground> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        baseColor: Color(0xffE0E0E0),
        lightSource: LightSource.topLeft,
        depth: 8,
        intensity: 0.6,
      ),
      child: _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  __PageState createState() => __PageState();
}

class __PageState extends State<_Page> {
  LightSource lightSource = LightSource.topLeft;
  NeumorphicShape shape = NeumorphicShape.flat;
  double depth = 2;
  double intensity = 0.8;
  double surfaceIntensity = 0.5;
  double fontSize = 100;
  int fontWeight = 800;
  final _textController = TextEditingController(text: "Flutter");
  bool displayIcon = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NeumorphicBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(),
              Expanded(child: Center(child: neumorphicText())),
              _buildConfigurator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: NeumorphicButton(
        style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          boxShape: NeumorphicBoxShape.stadium(),
          depth: 6,
          intensity: 0.4,
          color: Color(0xff6B48FF),
        ),
        child: const Text(
          "Back",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildConfigurator() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTabButton("Style", 0),
              _buildTabButton("Element", 1),
            ],
          ),
          const SizedBox(height: 20),
          _configuratorsChild() ?? const SizedBox(),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    bool isSelected = selectedConfiguratorIndex == index;
    return NeumorphicButton(
      style: NeumorphicStyle(
        shape: isSelected ? NeumorphicShape.concave : NeumorphicShape.flat,
        depth: isSelected ? 6 : 2,
        intensity: 0.4,
        color: isSelected ? Color(0xff6B48FF) : Color(0xffE0E0E0),
      ),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      onPressed: () => setState(() => selectedConfiguratorIndex = index),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  int selectedConfiguratorIndex = 0;

  Widget? _configuratorsChild() {
    switch (selectedConfiguratorIndex) {
      case 0:
        return styleCustomizer();
      case 1:
        return elementCustomizer();
    }
    return null;
  }

  Widget styleCustomizer() {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        _buildSlider(
          "Depth",
          depth,
          10,
          (value) => setState(() => depth = value),
        ),
        _buildSlider(
          "Intensity",
          intensity,
          1,
          (value) => setState(() => intensity = value),
        ),
        _buildSlider(
          "Surface Intensity",
          surfaceIntensity,
          1,
          (value) => setState(() => surfaceIntensity = value),
        ),
        colorPicker(),
      ],
    );
  }

  Widget elementCustomizer() {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        _buildSlider(
          "Font Size",
          fontSize,
          200,
          (value) => setState(() => fontSize = value),
        ),
        _buildSlider(
          "Font Weight",
          fontWeight.toDouble(),
          900,
          (value) => setState(() => fontWeight = value.toInt()),
        ),
        textSelector(),
        shapeWidget(),
      ],
    );
  }

  Widget _buildSlider(
    String label,
    double value,
    double max,
    Function(double) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          Slider(
            value: value,
            max: max,
            divisions: max.toInt(),
            label: value.toStringAsFixed(1),
            onChanged: onChanged,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value.toStringAsFixed(1),
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              Text(
                max.toStringAsFixed(0),
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget colorPicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Text(
            "Color",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 16),
          ColorSelector(
            onColorChanged: (color) => setState(
              () => NeumorphicTheme.of(
                context,
              )?.updateCurrentTheme(NeumorphicThemeData(baseColor: color)),
            ),
            color: NeumorphicTheme.baseColor(context),
          ),
        ],
      ),
    );
  }

  Widget textSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Text(
            "Text",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: "Enter text",
              ),
              onChanged: (s) => setState(() {}),
            ),
          ),
        ],
      ),
    );
  }

  Widget shapeWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildShapeButton(
            NeumorphicShape.concave,
            "assets/images/concave.png",
          ),
          _buildShapeButton(NeumorphicShape.convex, "assets/images/convex.png"),
          _buildShapeButton(NeumorphicShape.flat, "assets/images/flat.png"),
        ],
      ),
    );
  }

  Widget _buildShapeButton(NeumorphicShape newShape, String assetPath) {
    bool isSelected = shape == newShape;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.25,
      child: NeumorphicButton(
        style: NeumorphicStyle(
          shape: isSelected ? NeumorphicShape.concave : NeumorphicShape.flat,
          depth: isSelected ? 6 : 2,
          intensity: 0.4,
          color: isSelected ? Color(0xff6B48FF) : Color(0xffE0E0E0),
        ),
        padding: EdgeInsets.all(8),
        onPressed: () => setState(() => shape = newShape),
        child: Image.asset(
          assetPath,
          color: isSelected ? Colors.white : Colors.black87,
        ),
      ),
    );
  }

  Widget neumorphicText() {
    return displayIcon
        ? NeumorphicIcon(
            Icons.public,
            size: fontSize,
            style: NeumorphicStyle(
              shape: shape,
              intensity: intensity,
              surfaceIntensity: surfaceIntensity,
              depth: depth,
              lightSource: lightSource,
            ),
          )
        : NeumorphicText(
            _textController.text,
            textStyle: NeumorphicTextStyle(
              fontSize: fontSize,
              fontWeight: _fontWeight(),
            ),
            style: NeumorphicStyle(
              shape: shape,
              intensity: intensity,
              surfaceIntensity: surfaceIntensity,
              depth: depth,
              lightSource: lightSource,
            ),
          );
  }

  FontWeight _fontWeight() {
    switch ((fontWeight / 100).toInt()) {
      case 1:
        return FontWeight.w100;
      case 2:
        return FontWeight.w200;
      case 3:
        return FontWeight.w300;
      case 4:
        return FontWeight.w400;
      case 5:
        return FontWeight.w500;
      case 6:
        return FontWeight.w600;
      case 7:
        return FontWeight.w700;
      case 8:
        return FontWeight.w800;
      case 9:
        return FontWeight.w900;
    }
    return FontWeight.w500;
  }
}

import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

import 'abstract_neumorphic_painter_cache.dart';

// Concrete implementation of the neumorphic emboss painter cache
class NeumorphicEmbossPainterCache
    extends AbstractNeumorphicEmbossPainterCache {
  // Generates the dark shadow color based on the provided color and intensity
  @override
  Color generateShadowDarkColor({
    required Color color,
    required double intensity,
  }) {
    return NeumorphicColors.embossDarkColor(color, intensity: intensity);
  }

  // Generates the light shadow color based on the provided color and intensity
  @override
  Color generateShadowLightColor({
    required Color color,
    required double intensity,
  }) {
    return NeumorphicColors.embossWhiteColor(color, intensity: intensity);
  }

  // Updates the layer rectangle using the provided offset and size
  @override
  Rect updateLayerRect({required Offset newOffset, required Size newSize}) {
    // Creates a rectangle from the offset and size using the & operator
    return newOffset & newSize;
  }

  // Constructor, calls the superclass constructor
  NeumorphicEmbossPainterCache() : super();

  // Depth components for shadow calculations
  late double xDepth;
  late double yDepth;

  // Padding for shadow effects
  late double xPadding;
  late double yPadding;

  // Translation values for light and dark shadows
  late double blackShadowLeftTranslation;
  late double blackShadowTopTranslation;
  late double
  witheShadowLeftTranslation; // Note: 'withe' seems to be a typo for 'white'
  late double witheShadowTopTranslation;

  // Scaled dimensions including padding
  late double scaledWidth;
  late double scaledHeight;

  // Scaling factors for width and height
  late double scaleX;
  late double scaleY;

  // Updates translation and scaling properties based on light source and dimensions
  // Must be called after _cacheWidth and _cacheHeight are set
  @override
  void updateTranslations() {
    // Calculate depth components based on light source direction and depth
    xDepth = lightSource.dx * depth;
    yDepth = lightSource.dy * depth;

    // Calculate padding based on light source direction and depth
    // Padding is doubled when light source is not fully aligned with axis
    xPadding = 2 * (1 - lightSource.dx.abs()) * depth;
    yPadding = 2 * (1 - lightSource.dy.abs()) * depth;

    // Calculate translation for light (white) shadow
    witheShadowLeftTranslation = xDepth - xPadding;
    witheShadowTopTranslation = yDepth - yPadding;

    // Calculate translation for dark (black) shadow, opposite direction
    blackShadowLeftTranslation = -(xDepth + xPadding);
    blackShadowTopTranslation = -(yDepth + yPadding);

    // Calculate scaled dimensions including padding
    scaledWidth = width + 2 * xPadding;
    scaledHeight = height + 2 * yPadding;

    // Calculate scaling factors relative to original dimensions
    scaleX = scaledWidth / width;
    scaleY = scaledHeight / height;
  }
}

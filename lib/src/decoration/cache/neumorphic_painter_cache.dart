import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

import 'abstract_neumorphic_painter_cache.dart';

// Concrete implementation of the neumorphic painter cache for non-emboss effects
class NeumorphicPainterCache extends AbstractNeumorphicEmbossPainterCache {
  // Generates the dark shadow color for non-emboss decoration
  @override
  Color generateShadowDarkColor({
    required Color color,
    required double intensity,
  }) {
    // Uses NeumorphicColors to create a dark color variant based on input color and intensity
    return NeumorphicColors.decorationDarkColor(color, intensity: intensity);
  }

  // Generates the light shadow color for non-emboss decoration
  @override
  Color generateShadowLightColor({
    required Color color,
    required double intensity,
  }) {
    // Uses NeumorphicColors to create a light color variant based on input color and intensity
    return NeumorphicColors.decorationWhiteColor(color, intensity: intensity);
  }

  // Overrides translation updates, intentionally empty for non-emboss effects
  @override
  void updateTranslations() {
    // No-op: This method is used only for emboss effects and not required here
  }

  // Updates the layer rectangle with an expanded size for painting
  @override
  Rect updateLayerRect({required Offset newOffset, required Size newSize}) {
    // Creates a rectangle that is larger than the input size, centered around originOffset
    // Extends from (-width, -height) to (2*width, 2*height) relative to originOffset
    return Rect.fromLTRB(
      originOffset.dx - newSize.width,
      originOffset.dy - newSize.height,
      originOffset.dx + 2 * newSize.width,
      originOffset.dy + 2 * newSize.height,
    );
  }
}

import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

import 'cache/neumorphic_emboss_painter_cache.dart';

export '../theme/theme.dart';

// Custom painter for rendering embossed neumorphic decorations
class NeumorphicEmbossDecorationPainter extends BoxPainter {
  // Cache for storing and updating painter properties
  final NeumorphicEmbossPainterCache _cache;

  // Style configuration for the neumorphic effect
  final NeumorphicStyle style;
  // Shape configuration for the element
  final NeumorphicBoxShape shape;

  // Paint objects for different components of the emboss effect
  late Paint _backgroundPaint; // For the background color
  late Paint _whiteShadowPaint; // For the light shadow
  late Paint _whiteShadowMaskPaint; // For masking the light shadow
  late Paint _blackShadowPaint; // For the dark shadow
  late Paint _blackShadowMaskPaint; // For masking the dark shadow
  late Paint _borderPaint; // For the border

  // Flags to control rendering of specific components
  final bool drawShadow; // Whether to draw shadows
  final bool drawBackground; // Whether to draw the background

  // Constructor initializes the painter with style, shape, and rendering options
  NeumorphicEmbossDecorationPainter({
    required this.style, // Neumorphic style configuration
    required this.drawBackground, // Flag to enable background rendering
    required this.drawShadow, // Flag to enable shadow rendering
    required VoidCallback onChanged, // Callback for when the painter changes
    NeumorphicBoxShape? shape, // Optional shape, defaults to rectangle
  }) : shape = shape ?? NeumorphicBoxShape.rect(),
       _cache = NeumorphicEmbossPainterCache(),
       super(onChanged) {
    _generatePainters(); // Initialize paint objects
  }

  // Initializes paint objects with their respective properties
  void _generatePainters() {
    _backgroundPaint = Paint(); // Basic paint for background
    _whiteShadowPaint = Paint(); // Paint for light shadow effect
    _whiteShadowMaskPaint = Paint()
      ..blendMode = BlendMode.dstOut; // Mask for light shadow
    _blackShadowPaint = Paint(); // Paint for dark shadow effect
    _blackShadowMaskPaint = Paint()
      ..blendMode = BlendMode.dstOut; // Mask for dark shadow

    _borderPaint = Paint()
      ..strokeCap = StrokeCap
          .round // Rounded ends for border strokes
      ..strokeJoin = StrokeJoin
          .bevel // Beveled joins for border strokes
      ..style = PaintingStyle.stroke; // Stroke style for border
  }

  // Updates the cache with new offset, configuration, and style
  void _updateCache({
    required Offset offset,
    required ImageConfiguration configuration,
    required NeumorphicStyle newStyle,
  }) {
    bool invalidateSize = false;
    // Update size and path if configuration size is provided
    if (configuration.size != null) {
      invalidateSize = _cache.updateSize(
        newOffset: offset,
        newSize: configuration.size!,
      );
      if (invalidateSize) {
        // Update the path based on the custom shape provider
        _cache.updatePath(
          newPath: shape.customShapePathProvider.getPath(configuration.size!),
        );
      }
    }

    bool invalidateLightSource = false;
    // Update light source configuration
    invalidateLightSource = _cache.updateLightSource(
      style.lightSource,
      style.oppositeShadowLightSource,
    );

    bool invalidateColor = false;
    // Update background color if style color is provided
    if (style.color != null) {
      invalidateColor = _cache.updateStyleColor(style.color!);
      if (invalidateColor) {
        _backgroundPaint.color = _cache.backgroundColor;
      }
    }

    bool invalidateDepth = false;
    // Update depth and apply blur to shadow mask paints if depth is provided
    if (style.depth != null) {
      invalidateDepth = _cache.updateStyleDepth(style.depth!, 5);
      if (invalidateDepth) {
        _blackShadowMaskPaint.maskFilter = _cache.maskFilterBlur;
        _whiteShadowMaskPaint.maskFilter = _cache.maskFilterBlur;
      }
    }

    // Update shadow colors with default values if not provided
    final bool invalidateShadowColors = _cache.updateShadowColor(
      newShadowLightColorEmboss:
          style.shadowLightColorEmboss ??
          const Color(0xFFFFFFFF), // Default white
      newShadowDarkColorEmboss:
          style.shadowDarkColorEmboss ??
          const Color(0xFF000000), // Default black
      newIntensity: style.intensity ?? 0.25, // Default intensity
    );
    if (invalidateShadowColors) {
      if (_cache.shadowLightColor != null) {
        _whiteShadowPaint.color =
            _cache.shadowLightColor!; // Update light shadow color
      }
      if (_cache.shadowDarkColor != null) {
        _blackShadowPaint.color =
            _cache.shadowDarkColor!; // Update dark shadow color
      }
    }

    // Update translations if light source, depth, or size changed
    if (invalidateLightSource || invalidateDepth || invalidateSize) {
      _cache.updateTranslations();
    }
  }

  // Draws the background for the given path
  void _paintBackground(Canvas canvas, Path path) {
    canvas
      ..save() // Save canvas state
      ..translate(
        _cache.originOffset.dx,
        _cache.originOffset.dy,
      ) // Apply offset
      ..drawPath(path, _backgroundPaint) // Draw background
      ..restore(); // Restore canvas state
  }

  // Draws the border if enabled and configured
  void _drawBorder({
    required Canvas canvas,
    required Offset offset,
    required Path path,
  }) {
    if (style.border.width != null && style.border.width! > 0) {
      canvas
        ..save() // Save canvas state
        ..translate(offset.dx, offset.dy) // Apply offset
        ..drawPath(
          path,
          _borderPaint
            ..color =
                style.border.color ??
                const Color(0x00000000) // Set border color
            ..strokeWidth = style.border.width ?? 0, // Set border width
        )
        ..restore(); // Restore canvas state
    }
  }

  // Draws light and dark shadows with scaling and masking
  void _paintShadows(Canvas canvas, Path path) {
    final Matrix4 matrix4 = Matrix4.identity()
      ..scale(
        _cache.scaleX,
        _cache.scaleY,
      ); // Scale matrix for shadow transformations

    // Draw light shadow
    canvas
      ..saveLayer(
        _cache.layerRect,
        _whiteShadowPaint,
      ) // Start layer for light shadow
      ..translate(
        _cache.originOffset.dx,
        _cache.originOffset.dy,
      ) // Apply offset
      ..drawPath(path, _whiteShadowPaint) // Draw light shadow
      ..translate(
        _cache
            .witheShadowLeftTranslation, // Note: 'withe' seems to be a typo for 'white'
        _cache.witheShadowTopTranslation,
      ) // Apply shadow translation
      ..drawPath(
        path.transform(matrix4.storage),
        _whiteShadowMaskPaint,
      ) // Apply mask
      ..restore(); // Restore layer

    // Draw dark shadow
    canvas
      ..saveLayer(
        _cache.layerRect,
        _blackShadowPaint,
      ) // Start layer for dark shadow
      ..translate(
        _cache.originOffset.dx,
        _cache.originOffset.dy,
      ) // Apply offset
      ..drawPath(path, _blackShadowPaint) // Draw dark shadow
      ..translate(
        _cache.blackShadowLeftTranslation,
        _cache.blackShadowTopTranslation,
      ) // Apply shadow translation
      ..drawPath(
        path.transform(matrix4.storage),
        _blackShadowMaskPaint,
      ) // Apply mask
      ..restore(); // Restore layer
  }

  // Main paint method to render the emboss effect
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    // Update cache with current offset, configuration, and style
    _updateCache(offset: offset, configuration: configuration, newStyle: style);
    // Iterate through sub-paths to draw components
    for (var subPath in _cache.subPaths) {
      if (drawBackground) {
        _paintBackground(canvas, subPath); // Draw background if enabled
      }

      if (style.border.isEnabled) {
        _drawBorder(
          canvas: canvas,
          offset: offset,
          path: subPath,
        ); // Draw border if enabled
      }

      if (drawShadow) {
        _paintShadows(canvas, subPath); // Draw shadows if enabled
      }
    }
  }
}

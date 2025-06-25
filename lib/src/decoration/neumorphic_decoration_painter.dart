import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

import 'cache/neumorphic_painter_cache.dart';
import 'neumorphic_box_decoration_helper.dart';

// Custom painter for rendering neumorphic decorations with shadows, gradients, and borders
class NeumorphicDecorationPainter extends BoxPainter {
  // Style and shape configurations for the neumorphic effect
  final NeumorphicStyle style;
  final NeumorphicBoxShape shape;

  // Cache for storing and updating painter properties
  final NeumorphicPainterCache _cache = NeumorphicPainterCache();

  // Paint objects for different components of the neumorphic effect
  late Paint _backgroundPaint; // For the background color
  late Paint _whiteShadowPaint; // For the light shadow
  late Paint _whiteShadowMaskPaint; // For masking the light shadow
  late Paint _blackShadowPaint; // For the dark shadow
  late Paint _blackShadowMaskPaint; // For masking the dark shadow
  late Paint _gradientPaint; // For the gradient effect
  late Paint _borderPaint; // For the border

  // Initializes paint objects with their respective properties
  void generatePainters() {
    _backgroundPaint = Paint(); // Basic paint for background
    _whiteShadowPaint = Paint(); // Paint for light shadow effect
    _whiteShadowMaskPaint = Paint()
      ..blendMode = BlendMode.dstOut; // Mask for light shadow
    _blackShadowPaint = Paint(); // Paint for dark shadow effect
    _blackShadowMaskPaint = Paint()
      ..blendMode = BlendMode.dstOut; // Mask for dark shadow
    _gradientPaint = Paint(); // Paint for gradient effect

    _borderPaint = Paint()
      ..strokeCap = StrokeCap
          .round // Rounded ends for border strokes
      ..strokeJoin = StrokeJoin
          .bevel // Beveled joins for border strokes
      ..style = PaintingStyle.stroke; // Stroke style for border
  }

  // Flags to control rendering of specific components
  final bool drawGradient; // Whether to draw the gradient
  final bool drawShadow; // Whether to draw shadows
  final bool drawBackground; // Whether to draw the background
  final bool renderingByPath; // Whether to render using sub-paths

  // Constructor initializes the painter with style, shape, and rendering options
  NeumorphicDecorationPainter({
    required this.style, // Neumorphic style configuration
    required this.shape, // Shape configuration for the element
    required this.drawGradient, // Flag to enable gradient rendering
    required this.drawShadow, // Flag to enable shadow rendering
    required this.drawBackground, // Flag to enable background rendering
    required VoidCallback onChanged, // Callback for when the painter changes
    this.renderingByPath = true, // Flag to use path-based rendering
  }) : super(onChanged) {
    generatePainters(); // Initialize paint objects
  }

  // Updates the cache with new offset and configuration
  void _updateCache(Offset offset, ImageConfiguration configuration) {
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
    // Update light source if style color is provided
    if (style.color != null) {
      invalidateLightSource = _cache.updateLightSource(
        style.lightSource,
        style.oppositeShadowLightSource,
      );
    }

    bool invalidateColor = false;
    // Update background color if style color is provided
    if (style.color != null) {
      invalidateColor = _cache.updateStyleColor(style.color!);
      if (invalidateColor) {
        _backgroundPaint.color = _cache.backgroundColor;
      }
    }

    bool invalidateDepth = false;
    // Update depth and apply blur to shadow paints if depth is provided
    if (style.depth != null) {
      invalidateDepth = _cache.updateStyleDepth(style.depth!, 3);
      if (invalidateDepth) {
        _blackShadowPaint.maskFilter = _cache.maskFilterBlur;
        _whiteShadowPaint.maskFilter = _cache.maskFilterBlur;
      }
    }

    bool invalidateShadowColors = false;
    // Update shadow colors if all required style properties are provided
    if (style.shadowLightColor != null &&
        style.shadowDarkColor != null &&
        style.intensity != null) {
      invalidateShadowColors = _cache.updateShadowColor(
        newShadowLightColorEmboss: style.shadowLightColor!,
        newShadowDarkColorEmboss: style.shadowDarkColor!,
        newIntensity: style.intensity!,
      );
      if (invalidateShadowColors) {
        if (_cache.shadowLightColor != null) {
          _whiteShadowPaint.color = _cache.shadowLightColor!;
        }
        if (_cache.shadowDarkColor != null) {
          _blackShadowPaint.color = _cache.shadowDarkColor!;
        }
      }
    }

    // Update depth offset if depth or light source changed
    if (invalidateDepth || invalidateLightSource) {
      _cache.updateDepthOffset();
    }

    // Update translations if light source, depth, or size changed
    if (invalidateLightSource || invalidateDepth || invalidateSize) {
      _cache.updateTranslations();
    }
  }

  // Main paint method to render the neumorphic effect
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    // Update cache with current offset and configuration
    _updateCache(offset, configuration);

    // Draw shadows for each sub-path if enabled
    for (var subPath in _cache.subPaths) {
      if (drawShadow) {
        _drawShadow(offset: offset, canvas: canvas, path: subPath);
      }
    }

    // Draw elements either by sub-paths or single path based on rendering mode
    if (renderingByPath) {
      for (var subPath in _cache.subPaths) {
        _drawElement(offset: offset, canvas: canvas, path: subPath);
      }
    } else {
      _drawElement(offset: offset, canvas: canvas, path: _cache.path);
    }
  }

  // Draws the background, gradient, and border for a given path
  void _drawElement({
    required Canvas canvas,
    required Offset offset,
    required Path path,
  }) {
    if (drawBackground) {
      _drawBackground(offset: offset, canvas: canvas, path: path);
    }
    if (drawGradient) {
      _drawGradient(offset: offset, canvas: canvas, path: path);
    }
    if (style.border.isEnabled) {
      _drawBorder(canvas: canvas, offset: offset, path: path);
    }
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
                Color(0x00000000) // Set border color
            ..strokeWidth = style.border.width ?? 0, // Set border width
        )
        ..restore(); // Restore canvas state
    }
  }

  // Draws the background for the given path
  void _drawBackground({
    required Canvas canvas,
    required Offset offset,
    required Path path,
  }) {
    canvas
      ..save() // Save canvas state
      ..translate(offset.dx, offset.dy) // Apply offset
      ..drawPath(path, _backgroundPaint) // Draw background
      ..restore(); // Restore canvas state
  }

  // Draws light and dark shadows with masking for the given path
  void _drawShadow({
    required Canvas canvas,
    required Offset offset,
    required Path path,
  }) {
    if (style.depth != null && style.depth!.abs() >= 0.1) {
      // Draw light shadow
      canvas
        ..saveLayer(
          _cache.layerRect,
          _whiteShadowPaint,
        ) // Start layer for light shadow
        ..translate(
          offset.dx + _cache.depthOffset.dx,
          offset.dy + _cache.depthOffset.dy,
        ) // Apply offset for light shadow
        ..drawPath(path, _whiteShadowPaint) // Draw light shadow
        ..translate(
          -_cache.depthOffset.dx,
          -_cache.depthOffset.dy,
        ) // Reset offset
        ..drawPath(path, _whiteShadowMaskPaint) // Apply mask
        ..restore(); // Restore layer

      // Draw dark shadow
      canvas
        ..saveLayer(
          _cache.layerRect,
          _blackShadowPaint,
        ) // Start layer for dark shadow
        ..translate(
          offset.dx - _cache.depthOffset.dx,
          offset.dy - _cache.depthOffset.dy,
        ) // Apply offset for dark shadow
        ..drawPath(path, _blackShadowPaint) // Draw dark shadow
        ..translate(
          _cache.depthOffset.dx,
          _cache.depthOffset.dy,
        ) // Reset offset
        ..drawPath(path, _blackShadowMaskPaint) // Apply mask
        ..restore(); // Restore layer
    }
  }

  // Draws the gradient effect for concave or convex shapes
  void _drawGradient({
    required Canvas canvas,
    required Offset offset,
    required Path path,
  }) {
    if (style.shape == NeumorphicShape.concave ||
        style.shape == NeumorphicShape.convex) {
      final pathRect = path.getBounds(); // Get bounds of the path

      // Create gradient shader based on shape and light source
      _gradientPaint.shader = getGradientShader(
        gradientRect: pathRect,
        intensity: style.surfaceIntensity,
        source: style.shape == NeumorphicShape.concave
            ? style.lightSource
            : style.lightSource.invert(), // Invert for convex shapes
      );

      canvas
        ..saveLayer(
          pathRect.translate(offset.dx, offset.dy),
          _gradientPaint,
        ) // Start layer
        ..translate(offset.dx, offset.dy) // Apply offset
        ..drawPath(path, _gradientPaint) // Draw gradient
        ..restore(); // Restore layer
    }
  }
}

import 'dart:ui' as ui;

import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

import 'cache/neumorphic_painter_cache.dart';
import 'neumorphic_box_decoration_helper.dart';

// A minimal painter that does not perform any drawing
class NeumorphicEmptyTextPainter extends BoxPainter {
  // Constructor initializes with a callback for changes
  NeumorphicEmptyTextPainter({required VoidCallback onChanged})
    : super(onChanged);

  // Empty paint method, does not render anything
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    // Intentionally does nothing
  }
}

// Custom painter for rendering text with neumorphic effects
class NeumorphicDecorationTextPainter extends BoxPainter {
  // Style configuration for the neumorphic effect
  final NeumorphicStyle style;
  // Text to be rendered
  final String text;
  // Text style configuration
  final TextStyle textStyle;
  // Text alignment for the paragraph
  final TextAlign textAlign;

  // Cache for storing and updating painter properties
  final NeumorphicPainterCache _cache;

  // Paint objects for different components of the neumorphic effect
  late Paint _backgroundPaint; // For the background color
  late Paint _whiteShadowPaint; // For the light shadow
  late Paint _whiteShadowMaskPaint; // For masking the light shadow
  late Paint _blackShadowPaint; // For the dark shadow
  late Paint _blackShadowMaskPaint; // For masking the dark shadow
  late Paint _gradientPaint; // For the gradient effect
  late Paint _borderPaint; // For the border

  // Paragraphs for rendering text with different effects
  late ui.Paragraph _textParagraph; // For the border
  late ui.Paragraph _innerTextParagraph; // For the background
  late ui.Paragraph _whiteShadowParagraph; // For the light shadow
  late ui.Paragraph _whiteShadowMaskParagraph; // For masking the light shadow
  late ui.Paragraph _blackShadowTextParagraph; // For the dark shadow
  late ui.Paragraph
  _blackShadowTextMaskParagraph; // For masking the dark shadow
  late ui.Paragraph _gradientParagraph; // For the gradient effect

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
      ..style = PaintingStyle
          .stroke // Stroke style for border
      ..strokeWidth =
          style.border.width ??
          0.0 // Border width from style
      ..color =
          style.border.color ??
          const Color(0xFFFFFFFF); // Default to white if no color
  }

  // Flags to control rendering of specific components
  final bool drawGradient; // Whether to draw the gradient
  final bool drawShadow; // Whether to draw shadows
  final bool drawBackground; // Whether to draw the background
  final bool
  renderingByPath; // Whether to render using paths (unused in this class)

  // Constructor initializes the painter with style, text, and rendering options
  NeumorphicDecorationTextPainter({
    required this.style, // Neumorphic style configuration
    required this.textStyle, // Text style for rendering
    required this.text, // Text to be rendered
    required this.drawGradient, // Flag to enable gradient rendering
    required this.drawShadow, // Flag to enable shadow rendering
    required this.drawBackground, // Flag to enable background rendering
    required VoidCallback onChanged, // Callback for when the painter changes
    required this.textAlign, // Text alignment
    this.renderingByPath = true, // Path rendering flag (unused)
  }) : _cache = NeumorphicPainterCache(),
       super(onChanged) {
    generatePainters(); // Initialize paint objects
  }

  // Updates the cache and paragraph builders with new offset and configuration
  void _updateCache(Offset offset, ImageConfiguration configuration) {
    bool invalidateSize = false;
    // Update size if configuration size is provided
    if (configuration.size != null) {
      invalidateSize = _cache.updateSize(
        newOffset: offset,
        newSize: configuration.size!,
      );
    }

    // Update light source configuration
    final bool invalidateLightSource = _cache.updateLightSource(
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
        newIntensity: style.intensity ?? neumorphicDefaultTheme.intensity,
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
    }

    // Define paragraph constraints based on cached width
    final constraints = ui.ParagraphConstraints(width: _cache.width);
    // Get paragraph style with specified text alignment
    final paragraphStyle = textStyle.getParagraphStyle(
      textDirection: TextDirection.ltr,
      textAlign: textAlign,
    );

    // Build paragraph for border
    final textParagraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(ui.TextStyle(foreground: _borderPaint))
      ..addText(text);

    // Build paragraph for background
    final innerTextParagraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(ui.TextStyle(foreground: _backgroundPaint))
      ..addText(text);

    // Build paragraph for light shadow
    final whiteShadowParagraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(ui.TextStyle(foreground: _whiteShadowPaint))
      ..addText(text);

    // Build paragraph for light shadow mask
    final whiteShadowMaskParagraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(ui.TextStyle(foreground: _whiteShadowMaskPaint))
      ..addText(text);

    // Build paragraph for dark shadow
    final blackShadowParagraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(ui.TextStyle(foreground: _blackShadowPaint))
      ..addText(text);

    // Build paragraph for dark shadow mask
    final blackShadowMaskParagraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(ui.TextStyle(foreground: _blackShadowMaskPaint))
      ..addText(text);

    // Layout all paragraphs
    _textParagraph = textParagraphBuilder.build()..layout(constraints);
    _innerTextParagraph = innerTextParagraphBuilder.build()
      ..layout(constraints);
    _whiteShadowParagraph = whiteShadowParagraphBuilder.build()
      ..layout(constraints);
    _whiteShadowMaskParagraph = whiteShadowMaskParagraphBuilder.build()
      ..layout(constraints);
    _blackShadowTextParagraph = blackShadowParagraphBuilder.build()
      ..layout(constraints);
    _blackShadowTextMaskParagraph = blackShadowMaskParagraphBuilder.build()
      ..layout(constraints);

    // Build and layout paragraph for gradient effect
    final gradientParagraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(
        ui.TextStyle(
          foreground: _gradientPaint
            ..shader = getGradientShader(
              gradientRect: Rect.fromLTRB(0, 0, _cache.width, _cache.height),
              intensity: style.surfaceIntensity,
              source: style.shape == NeumorphicShape.concave
                  ? style.lightSource
                  : style.lightSource.invert(), // Invert for convex shapes
            ),
        ),
      )
      ..addText(text);

    _gradientParagraph = gradientParagraphBuilder.build()
      ..layout(ui.ParagraphConstraints(width: _cache.width));

    // Update depth offset if depth or light source changed
    if (invalidateDepth || invalidateLightSource) {
      _cache.updateDepthOffset();
    }

    // Update translations if light source, depth, or size changed
    if (invalidateLightSource || invalidateDepth || invalidateSize) {
      _cache.updateTranslations();
    }
  }

  // Main paint method to render the neumorphic text effect
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    // Update cache with current offset and configuration
    _updateCache(offset, configuration);

    // Draw shadows if enabled
    _drawShadow(offset: offset, canvas: canvas, path: _cache.path);

    // Draw text elements (background, gradient, border)
    _drawElement(offset: offset, canvas: canvas, path: _cache.path);
  }

  // Draws the text elements (background, gradient, border)
  void _drawElement({
    required Canvas canvas,
    required Offset offset,
    required Path path,
  }) {
    // Always draw background (condition is always true)
    _drawBackground(offset: offset, canvas: canvas, path: path);
    if (drawGradient) {
      _drawGradient(offset: offset, canvas: canvas, path: path);
    }
    if (style.border.isEnabled) {
      _drawBorder(canvas: canvas, offset: offset, path: path);
    }
  }

  // Draws the border text if enabled and configured
  void _drawBorder({
    required Canvas canvas,
    required Offset offset,
    required Path path,
  }) {
    if (style.border.width != null && style.border.width! > 0) {
      canvas
        ..save() // Save canvas state
        ..translate(offset.dx, offset.dy) // Apply offset
        ..drawParagraph(_textParagraph, Offset.zero) // Draw border text
        ..restore(); // Restore canvas state
    }
  }

  // Draws the background text
  void _drawBackground({
    required Canvas canvas,
    required Offset offset,
    required Path path,
  }) {
    canvas
      ..save() // Save canvas state
      ..translate(offset.dx, offset.dy) // Apply offset
      ..drawParagraph(_innerTextParagraph, Offset.zero) // Draw background text
      ..restore(); // Restore canvas state
  }

  // Draws light and dark shadows for the text
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
        ..drawParagraph(
          _whiteShadowParagraph,
          Offset.zero,
        ) // Draw light shadow text
        ..translate(
          -_cache.depthOffset.dx,
          -_cache.depthOffset.dy,
        ) // Reset offset
        ..drawParagraph(_whiteShadowMaskParagraph, Offset.zero) // Apply mask
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
        ..drawParagraph(
          _blackShadowTextParagraph,
          Offset.zero,
        ) // Draw dark shadow text
        ..translate(
          _cache.depthOffset.dx,
          _cache.depthOffset.dy,
        ) // Reset offset
        ..drawParagraph(
          _blackShadowTextMaskParagraph,
          Offset.zero,
        ) // Apply mask
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
      canvas
        ..saveLayer(
          _cache.layerRect,
          _gradientPaint,
        ) // Start layer for gradient
        ..translate(offset.dx, offset.dy) // Apply offset
        ..drawParagraph(_gradientParagraph, Offset.zero) // Draw gradient text
        ..restore(); // Restore layer
    }
  }
}

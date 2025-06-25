import 'dart:math';

import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Abstract class for caching and managing neumorphic emboss painter properties
abstract class AbstractNeumorphicEmbossPainterCache {
  // Cached offset for the painter's origin
  Offset? _cacheOffset;
  // Getter for origin offset, defaults to Offset.zero if null
  Offset get originOffset => _cacheOffset ?? Offset.zero;

  // Cached width and height of the painter's area
  double? _cacheWidth;
  double get width => _cacheWidth ?? 0;
  double? _cacheHeight;
  double get height => _cacheHeight ?? 0;

  // Cached radius for rounded corners or circular shapes
  double? _cacheRadius;
  double get cacheRadius => _cacheRadius ?? 0;

  // Cached rectangle representing the layer's bounds
  Rect? _layerRect;
  Rect? get layerRect => _layerRect;

  // Constructor for the abstract cache class
  AbstractNeumorphicEmbossPainterCache();

  // Updates size-related properties and returns true if changes occurred
  bool updateSize({required Offset newOffset, required Size newSize}) {
    // Check if offset or size has changed
    if (_cacheOffset != newOffset ||
        _cacheWidth != newSize.width ||
        _cacheHeight != newSize.height) {
      // Update cached dimensions and offset
      _cacheWidth = newSize.width;
      _cacheHeight = newSize.height;
      _cacheOffset = newOffset;

      // Calculate middle points for radius computation
      var middleWidth = newSize.width / 2;
      var middleHeight = newSize.height / 2;

      // Update the layer rectangle with new offset and size
      _layerRect = updateLayerRect(newOffset: newOffset, newSize: newSize);

      // Set radius to the smaller of half-width or half-height
      _cacheRadius = min(middleWidth, middleHeight);

      return true; // Indicate that updates were made
    }

    return false; // No changes made
  }

  // Abstract method to update the layer rectangle, to be implemented by subclasses
  Rect updateLayerRect({required Offset newOffset, required Size newSize});

  // Cached style depth and actual depth used for drawing
  double? _cacheStyleDepth; // Stores the previous style depth
  double? _depth; // Depth used for rendering effects
  double get depth => _depth ?? 0; // Getter for depth, defaults to 0

  // Updates the depth style and applies constraints
  bool updateStyleDepth(double newStyleDepth, double radiusFactor) {
    if (_cacheStyleDepth != newStyleDepth) {
      _cacheStyleDepth = newStyleDepth;

      // Clamp depth to be between 0 and radius/radiusFactor
      final depth = newStyleDepth.abs().clamp(
        0.0,
        (_cacheRadius ?? 0) / radiusFactor,
      );
      _depth = depth;

      // Update the mask filter based on the new depth
      _updateMaskFilter(newDepth: depth);

      return true; // Depth was updated
    }
    return false; // No update needed
  }

  // Cached offset for depth-based shadow effects
  Offset? _depthOffset;
  Offset get depthOffset => _depthOffset ?? Offset.zero;

  // Updates the depth offset based on the light source and depth
  void updateDepthOffset() {
    if (_depth != null) {
      // Scale the light source offset by the depth value
      _depthOffset = lightSource.offset.scale(_depth!, _depth!);
    }
  }

  // Cached background color for the painter
  Color? _cacheColor;
  Color get backgroundColor => _cacheColor ?? Colors.transparent;

  // Updates the background color if changed
  bool updateStyleColor(Color newColor) {
    if (_cacheColor != newColor) {
      _cacheColor = newColor;
      return true; // Color was updated
    }
    return false; // No update needed
  }

  // Cached light source properties
  bool? _cacheOppositeShadowLightSource; // Stores the opposite shadow setting
  LightSource? _cacheLightSource; // Stores the previous light source
  LightSource? _lightSource; // Light source used for drawing
  LightSource get lightSource =>
      _lightSource ?? LightSource.bottom; // Default to bottom

  // Updates the light source and its opposite shadow setting
  bool updateLightSource(
    LightSource newLightSource,
    bool newOppositeShadowLightSource,
  ) {
    bool invalidateLightSource = false;
    // Check if the light source has changed
    if (newLightSource != _cacheLightSource) {
      _cacheLightSource = newLightSource;
      invalidateLightSource = true;
    }

    bool invalidateOppositeLightSource = false;
    // Check if the opposite shadow setting has changed
    if (newOppositeShadowLightSource != _cacheOppositeShadowLightSource) {
      _cacheOppositeShadowLightSource = newOppositeShadowLightSource;
      invalidateOppositeLightSource = true;
    }

    final cacheLightSource = _cacheLightSource;
    final cacheOppositeShadowLightSource = _cacheOppositeShadowLightSource;
    // Update light source if either property changed
    if (cacheOppositeShadowLightSource != null &&
        cacheLightSource != null &&
        (invalidateLightSource || invalidateOppositeLightSource)) {
      // Invert light source if opposite shadow is enabled
      if (cacheOppositeShadowLightSource) {
        _lightSource = cacheLightSource.invert();
      } else {
        _lightSource = cacheLightSource;
      }
      return true; // Light source was updated
    }

    return false; // No update needed
  }

  // Mask filter for blur effects
  MaskFilter? _maskFilterBlur;
  MaskFilter? get maskFilterBlur => _maskFilterBlur;

  // Updates the mask filter with a new blur based on depth
  void _updateMaskFilter({required double newDepth}) {
    _maskFilterBlur = MaskFilter.blur(BlurStyle.normal, newDepth);
  }

  // Cached style properties for shadow colors and intensity
  double? _styleIntensity;
  Color? _styleShadowLightColor;
  Color? _shadowLightColor; // Light shadow color used for drawing
  Color? get shadowLightColor => _shadowLightColor;
  Color? _styleShadowDarkColor;
  Color? _shadowDarkColor; // Dark shadow color used for drawing
  Color? get shadowDarkColor => _shadowDarkColor;

  // Abstract methods to generate shadow colors based on color and intensity
  Color generateShadowLightColor({
    required Color color,
    required double intensity,
  });

  Color generateShadowDarkColor({
    required Color color,
    required double intensity,
  });

  // Updates shadow colors and intensity
  bool updateShadowColor({
    required Color newShadowLightColorEmboss,
    required Color newShadowDarkColorEmboss,
    required double newIntensity,
  }) {
    bool invalidateIntensity = false;
    bool invalidate = false;

    // Check if intensity has changed
    if (_styleIntensity != newIntensity) {
      invalidate = true;
      invalidateIntensity = true;
      _styleIntensity = newIntensity;
    }

    // Update light shadow color if intensity or color changed
    if (invalidateIntensity ||
        _styleShadowLightColor != newShadowLightColorEmboss) {
      _styleShadowLightColor = newShadowLightColorEmboss;
      _shadowLightColor = generateShadowLightColor(
        color: newShadowLightColorEmboss,
        intensity: newIntensity,
      );
      invalidate = true;
    }

    // Update dark shadow color if needed
    if (invalidate || _styleShadowDarkColor != newShadowDarkColorEmboss) {
      _styleShadowDarkColor = newShadowDarkColorEmboss;
      _shadowDarkColor = generateShadowDarkColor(
        color: newShadowDarkColorEmboss,
        intensity: newIntensity,
      );
      invalidate = true;
    }

    return invalidate; // Indicate if any updates were made
  }

  // Abstract method to update translations, to be called after size updates
  void updateTranslations();

  // List of sub-paths for complex shapes
  final List<Path> subPaths = [];

  // Cached path for the painter
  Path? _path;
  Path get path => _path ?? Path();

  // Updates the path and computes sub-paths
  void updatePath({required Path newPath}) {
    _path = newPath;
    subPaths.clear();
    // Compute path metrics and extract sub-paths
    var pathMetrics = newPath.computeMetrics();
    for (var item in pathMetrics) {
      subPaths.add(item.extractPath(0, item.length));
    }
  }
}

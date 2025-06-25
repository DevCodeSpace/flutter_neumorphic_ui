import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Creates a shader for a linear gradient based on light source and intensity
Shader getGradientShader({
  required Rect gradientRect, // Rectangle defining the gradient's bounds
  required LightSource source, // Light source to determine gradient direction
  double intensity = 0.25, // Intensity of the gradient effect, defaults to 0.25
}) {
  // Invert the light source to define the gradient's end point
  var sourceInvert = source.invert();

  // Adjust intensity for the gradient effect (scaled to 60% of input intensity)
  final currentIntensity = intensity * (3 / 5);

  // Create a linear gradient from the light source to its inverted position
  final Gradient gradient = LinearGradient(
    begin: Alignment(source.dx, source.dy), // Start at light source direction
    end: Alignment(
      sourceInvert.dx,
      sourceInvert.dy,
    ), // End at inverted direction
    colors: <Color>[
      // Dark color for the gradient, based on adjusted intensity
      NeumorphicColors.gradientShaderDarkColor(intensity: currentIntensity),
      // Light color for the gradient, with further reduced intensity (40% of currentIntensity)
      NeumorphicColors.gradientShaderWhiteColor(
        intensity: currentIntensity * (2 / 5),
      ),
    ],
    stops: [
      0, // Start of the gradient
      0.75, // Transition point at 75% to make the gradient less dark
    ],
  );

  // Generate and return the shader for the gradient within the specified rectangle
  return gradient.createShader(gradientRect);
}

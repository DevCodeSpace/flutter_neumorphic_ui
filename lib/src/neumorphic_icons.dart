import 'package:flutter/widgets.dart';

/// A class to define Neumorphic icon data
class NeumorphicIcons {
  NeumorphicIcons._(); // Private constructor to prevent instantiation

  static const _kFontFam = 'Samsung'; // Font family for the icons
  static const _kFontPkg = "flutter_neumorphic"; // Font package for the icons

  /// Icon data for a check icon
  static const IconData check = IconData(
    0xe800, // Unicode code point for the check icon
    fontFamily: _kFontFam, // Specifies the font family
    fontPackage: _kFontPkg, // Specifies the font package
  );
}

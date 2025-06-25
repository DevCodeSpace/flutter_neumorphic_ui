import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

import 'rrect_path_provider.dart';

// Custom path provider for creating a stadium-shaped (rounded rectangle with fully circular ends) path
class StadiumPathProvider extends RRectPathProvider {
  // Constructor initializes with a large circular radius for stadium shape
  const StadiumPathProvider({Listenable? reclip})
    : super(
        const BorderRadius.all(Radius.circular(1000)),
        reclip: reclip,
      ); // Uses large radius for fully rounded ends
}

import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// A stateless widget that provides a neumorphic-themed MaterialApp
class NeumorphicApp extends StatelessWidget {
  // The title of the application
  final String title;
  // The theme mode (light, dark, or system)
  final ThemeMode themeMode;
  // Neumorphic theme data for light mode
  final NeumorphicThemeData theme;
  // Neumorphic theme data for dark mode
  final NeumorphicThemeData darkTheme;
  // Optional Material theme for dark mode
  final ThemeData? materialDarkTheme;
  // Optional Material theme for light mode
  final ThemeData? materialTheme;
  // Initial route for navigation
  final String? initialRoute;
  // Background color for the app
  final Color? color;
  // Localization delegates for the app
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  // Specific locale for the app
  final Locale? locale;
  // Home widget for the app
  final Widget? home;
  // Supported locales for localization
  final Iterable<Locale> supportedLocales;
  // Named routes for navigation
  final Map<String, WidgetBuilder> routes;
  // Callback for generating routes dynamically
  final RouteFactory? onGenerateRoute;
  // Callback for handling unknown routes
  final RouteFactory? onUnknownRoute;
  // Callback for generating the app title
  final GenerateAppTitle? onGenerateTitle;
  // Global key for accessing the navigator state
  final GlobalKey<NavigatorState>? navigatorKey;
  // List of navigator observers for navigation events
  final List<NavigatorObserver> navigatorObservers;
  // Callback for generating initial routes
  final InitialRouteListFactory? onGenerateInitialRoutes;
  // Whether to show the debug banner
  final bool debugShowCheckedModeBanner;
  // Optional builder for custom widget tree modifications
  final Widget Function(BuildContext, Widget?)? builder;
  // Callback for resolving locale
  final Locale? Function(Locale?, Iterable<Locale>)? localeResolutionCallback;
  // Optional high contrast theme for light mode
  final ThemeData? highContrastTheme;
  // Optional high contrast theme for dark mode
  final ThemeData? highContrastDarkTheme;
  // Callback for resolving locale list
  final LocaleListResolutionCallback? localeListResolutionCallback;
  // Whether to show performance overlay
  final bool showPerformanceOverlay;
  // Whether to checkerboard raster cache images
  final bool checkerboardRasterCacheImages;
  // Whether to checkerboard offscreen layers
  final bool checkerboardOffscreenLayers;
  // Whether to show semantics debugger
  final bool showSemanticsDebugger;
  // Keyboard shortcuts for the app
  final Map<LogicalKeySet, Intent>? shortcuts;
  // Actions for handling intents
  final Map<Type, Action<Intent>>? actions;
  // Whether to show material grid for debugging
  final bool debugShowMaterialGrid;

  // Constructor for initializing the NeumorphicApp
  const NeumorphicApp({
    super.key,
    this.title = '', // Default empty title
    this.color, // Optional app color
    this.initialRoute, // Optional initial route
    this.routes = const {}, // Default empty routes map
    this.home, // Optional home widget
    this.debugShowCheckedModeBanner = true, // Default to show debug banner
    this.navigatorKey, // Optional navigator key
    this.navigatorObservers = const [], // Default empty observer list
    this.onGenerateRoute, // Optional route generator
    this.onGenerateTitle, // Optional title generator
    this.onGenerateInitialRoutes, // Optional initial routes generator
    this.onUnknownRoute, // Optional unknown route handler
    this.theme = neumorphicDefaultTheme, // Default light theme
    this.darkTheme = neumorphicDefaultDarkTheme, // Default dark theme
    this.locale, // Optional locale
    this.localizationsDelegates, // Optional localization delegates
    this.supportedLocales = const <Locale>[
      Locale('en', 'US'),
    ], // Default supported locale
    this.themeMode = ThemeMode.system, // Default to system theme mode
    this.materialDarkTheme, // Optional material dark theme
    this.materialTheme, // Optional material light theme
    this.builder, // Optional builder function
    this.localeResolutionCallback, // Optional locale resolution callback
    this.highContrastTheme, // Optional high contrast light theme
    this.highContrastDarkTheme, // Optional high contrast dark theme
    this.localeListResolutionCallback, // Optional locale list resolution callback
    this.showPerformanceOverlay = false, // Default to hide performance overlay
    this.checkerboardRasterCacheImages =
        false, // Default to hide raster cache checkerboard
    this.checkerboardOffscreenLayers =
        false, // Default to hide offscreen layers checkerboard
    this.showSemanticsDebugger = false, // Default to hide semantics debugger
    this.debugShowMaterialGrid = false, // Default to hide material grid
    this.shortcuts, // Optional keyboard shortcuts
    this.actions, // Optional actions for intents
  });

  // Generates a Material ThemeData based on NeumorphicThemeData
  ThemeData _getMaterialTheme(NeumorphicThemeData theme) {
    final color = theme.accentColor;

    // If accent color is a MaterialColor, use it as primary swatch
    if (color is MaterialColor) {
      return ThemeData(
        primarySwatch: color, // Set primary color swatch
        textTheme: theme.textTheme, // Use neumorphic text theme
        iconTheme: theme.iconTheme, // Use neumorphic icon theme
        // brightness: theme.brightness, // Commented out, not used
        scaffoldBackgroundColor: theme.baseColor, // Set scaffold background
      );
    }

    // Otherwise, use accent color as primary color
    return ThemeData(
      primaryColor: theme.accentColor, // Set primary color
      iconTheme: theme.iconTheme, // Use neumorphic icon theme
      brightness: ThemeData.estimateBrightnessForColor(
        theme.baseColor,
      ), // Estimate brightness
      // primaryColorBrightness:
      //     ThemeData.estimateBrightnessForColor(theme.accentColor), // Commented out, not used
      // accentColorBrightness:
      //     ThemeData.estimateBrightnessForColor(theme.variantColor), // Commented out, not used
      textTheme: theme.textTheme, // Use neumorphic text theme
      scaffoldBackgroundColor: theme.baseColor, // Set scaffold background
      // colorScheme: ColorScheme.fromSwatch().copyWith(secondary: theme.variantColor), // Commented out, not used
    );
  }

  // Builds the widget tree for the app
  @override
  Widget build(BuildContext context) {
    // Use provided material theme or generate from neumorphic theme
    final materialTheme = this.materialTheme ?? _getMaterialTheme(theme);
    // Use provided material dark theme or generate from neumorphic dark theme
    final materialDarkTheme =
        this.materialDarkTheme ?? _getMaterialTheme(darkTheme);
    // Wrap the MaterialApp with NeumorphicTheme for neumorphic styling
    return NeumorphicTheme(
      theme: theme, // Apply light theme
      darkTheme: darkTheme, // Apply dark theme
      themeMode: themeMode, // Set theme mode
      child: Builder(
        builder: (context) => IconTheme(
          data: NeumorphicTheme.currentTheme(
            context,
          ).iconTheme, // Apply current icon theme
          child: MaterialApp(
            title: title, // Set app title
            color: color, // Set app color
            theme: materialTheme, // Apply material light theme
            darkTheme: materialDarkTheme, // Apply material dark theme
            initialRoute: initialRoute, // Set initial route
            routes: routes, // Set named routes
            themeMode: themeMode, // Set theme mode
            localizationsDelegates:
                localizationsDelegates, // Set localization delegates
            supportedLocales: supportedLocales, // Set supported locales
            locale: locale, // Set locale
            home: home, // Set home widget
            onGenerateRoute: onGenerateRoute, // Set route generator
            onUnknownRoute: onUnknownRoute, // Set unknown route handler
            onGenerateTitle: onGenerateTitle, // Set title generator
            onGenerateInitialRoutes:
                onGenerateInitialRoutes, // Set initial routes generator
            navigatorKey: navigatorKey, // Set navigator key
            navigatorObservers: navigatorObservers, // Set navigator observers
            debugShowCheckedModeBanner:
                debugShowCheckedModeBanner, // Set debug banner visibility
            builder: builder, // Set custom builder
            localeResolutionCallback:
                localeResolutionCallback, // Set locale resolution callback
            highContrastTheme:
                highContrastTheme, // Set high contrast light theme
            highContrastDarkTheme:
                highContrastDarkTheme, // Set high contrast dark theme
            localeListResolutionCallback:
                localeListResolutionCallback, // Set locale list resolution callback
            showPerformanceOverlay:
                showPerformanceOverlay, // Set performance overlay visibility
            checkerboardRasterCacheImages:
                checkerboardRasterCacheImages, // Set raster cache checkerboard
            checkerboardOffscreenLayers:
                checkerboardOffscreenLayers, // Set offscreen layers checkerboard
            showSemanticsDebugger:
                showSemanticsDebugger, // Set semantics debugger visibility
            shortcuts: shortcuts, // Set keyboard shortcuts
            actions: actions, // Set actions for intents
            debugShowMaterialGrid:
                debugShowMaterialGrid, // Set material grid visibility
          ),
        ),
      ),
    );
  }
}

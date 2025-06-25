// ignore_for_file: unused_local_variable, overridden_fields

import 'package:flutter_neumorphic_ui/flutter_neumorphic_ui.dart';

// Neumorphic styled app bar widget implementing PreferredSizeWidget
class NeumorphicAppBar extends StatefulWidget implements PreferredSizeWidget {
  // Default toolbar height with additional padding
  static const toolbarHeight = kToolbarHeight + 16 * 2;
  // Default spacing between actions
  static const defaultSpacing = 4.0;

  /// The primary widget displayed in the app bar, typically a Text widget
  final Widget? title;

  /// A widget to display before the title, typically an Icon or IconButton
  final Widget? leading;

  /// Whether the title should be centered, defaults to platform-specific behavior
  final bool? centerTitle;

  /// Widgets to display after the title, typically IconButtons for actions
  final List<Widget>? actions;

  /// Whether to automatically imply a leading widget if null
  final bool automaticallyImplyLeading;

  /// Horizontal spacing around the title content
  final double titleSpacing;

  /// Spacing to the left of action widgets
  final double actionSpacing;

  /// Forced background color of the app bar
  final Color? color;

  /// Forced icon theme for icons in the app bar
  final IconThemeData? iconTheme;

  // Preferred size of the app bar
  @override
  final Size preferredSize;

  // Neumorphic style for buttons in the app bar
  final NeumorphicStyle? buttonStyle;

  // Padding for buttons in the app bar
  final EdgeInsets? buttonPadding;

  // Text style for the title
  final TextStyle? textStyle;

  // Padding around the app bar content
  final double padding;

  // Constructor for initializing the NeumorphicAppBar
  const NeumorphicAppBar({
    super.key,
    this.title, // Optional title widget
    this.buttonPadding, // Optional button padding
    this.buttonStyle, // Optional button style
    this.iconTheme, // Optional icon theme
    this.color, // Optional background color
    this.actions, // Optional action widgets
    this.textStyle, // Optional title text style
    this.leading, // Optional leading widget
    this.automaticallyImplyLeading = true, // Default to imply leading widget
    this.centerTitle, // Optional center title flag
    this.titleSpacing =
        NavigationToolbar.kMiddleSpacing, // Default title spacing
    this.actionSpacing = defaultSpacing, // Default action spacing
    this.padding = 16, // Default padding
  }) : preferredSize = const Size.fromHeight(
         toolbarHeight,
       ); // Set preferred height

  // Creates the state for managing the app bar
  @override
  NeumorphicAppBarState createState() => NeumorphicAppBarState();

  // Determines if the title should be centered based on theme and platform
  bool _getEffectiveCenterTitle(ThemeData theme, NeumorphicThemeData nTheme) {
    // Use explicit centerTitle or fallback to neumorphic theme's setting
    if (centerTitle != null || nTheme.appBarTheme.centerTitle != null) {
      return centerTitle ?? nTheme.appBarTheme.centerTitle!;
    }

    // Platform-specific default behavior
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return false; // Non-iOS platforms default to left-aligned
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        // Center title if no actions or fewer than two actions
        return actions == null || actions!.length < 2;
    }
  }
}

// Inherited widget for providing NeumorphicAppBar theme context
class NeumorphicAppBarTheme extends InheritedWidget {
  // The child widget wrapped by this theme
  @override
  final Widget child;

  // Constructor for initializing the theme
  const NeumorphicAppBarTheme({super.key, required this.child})
    : super(child: child);

  // Determines if dependent widgets should be notified of updates
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false; // No updates needed as theme is static
  }

  // Retrieves the NeumorphicAppBarTheme from the context
  static NeumorphicAppBarTheme? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }
}

// State class for managing the NeumorphicAppBar widget
class NeumorphicAppBarState extends State<NeumorphicAppBar> {
  // Builds the app bar widget tree
  @override
  Widget build(BuildContext context) {
    // Retrieve theme data
    final ThemeData theme = Theme.of(context);
    final nTheme = NeumorphicTheme.of(context);
    // Get parent route for navigation context
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool canPop =
        parentRoute?.canPop ?? false; // Check if navigation can pop
    // Determine if a close button should be used for fullscreen dialogs
    final bool useCloseButton =
        parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;
    // Get scaffold state for drawer information
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final bool hasDrawer = scaffold?.hasDrawer ?? false; // Check for drawer
    final bool hasEndDrawer =
        scaffold?.hasEndDrawer ?? false; // Check for end drawer

    // Initialize leading widget
    Widget? leading = widget.leading;
    // Imply leading widget if none provided and automaticallyImplyLeading is true
    if (leading == null && widget.automaticallyImplyLeading) {
      if (hasDrawer) {
        // Use menu icon button for drawer
        leading = NeumorphicButton(
          padding: widget.buttonPadding,
          style: widget.buttonStyle,
          onPressed: _handleDrawerButton, // Open drawer on press
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          child: nTheme?.current?.appBarTheme.icons.menuIcon, // Use menu icon
        );
      } else {
        if (canPop) {
          // Use close or back button based on dialog state
          leading = useCloseButton
              ? NeumorphicCloseButton(
                  padding: widget.buttonPadding,
                  style: widget.buttonStyle,
                )
              : NeumorphicBackButton(
                  padding: widget.buttonPadding,
                  style: widget.buttonStyle,
                );
        }
      }
    }
    // Constrain leading widget size
    if (leading != null) {
      leading = ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: kToolbarHeight),
        child: leading,
      );
    }

    // Initialize title widget
    Widget? title = widget.title;
    if (title != null) {
      final AppBarTheme appBarTheme = AppBarTheme.of(context);
      final TextTheme textTheme = Theme.of(context).textTheme;

      // Apply text style to title
      title = DefaultTextStyle(
        style: (textTheme.headlineSmall!).merge(
          widget.textStyle ??
              nTheme?.current?.appBarTheme.textStyle, // Merge styles
        ),
        softWrap: false,
        overflow: TextOverflow.ellipsis, // Handle overflow
        child: title,
      );
    }

    // Initialize actions widget
    Widget? actions;
    if (widget.actions != null && widget.actions!.isNotEmpty) {
      // Layout actions in a row with spacing
      actions = Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.actions!
            .map(
              (child) => Padding(
                padding: EdgeInsets.only(
                  left: widget.actionSpacing,
                ), // Apply action spacing
                child: ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(
                    width: kToolbarHeight,
                    height: kToolbarHeight,
                  ),
                  child: child, // Constrain action size
                ),
              ),
            )
            .toList(growable: false),
      );
    } else if (hasEndDrawer) {
      // Use menu icon button for end drawer
      actions = ConstrainedBox(
        constraints: const BoxConstraints.tightFor(
          width: kToolbarHeight,
          height: kToolbarHeight,
        ),
        child: NeumorphicButton(
          padding: widget.buttonPadding,
          style: widget.buttonStyle,
          onPressed: _handleDrawerButtonEnd, // Open end drawer on press
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          child: nTheme?.current?.appBarTheme.icons.menuIcon, // Use menu icon
        ),
      );
    }

    // Build the app bar structure
    return Container(
      color:
          widget.color ??
          nTheme?.current?.appBarTheme.color, // Apply background color
      child: SafeArea(
        bottom: false, // Exclude bottom safe area
        child: NeumorphicAppBarTheme(
          child: Padding(
            padding: EdgeInsets.all(widget.padding), // Apply padding
            child: IconTheme(
              data:
                  widget.iconTheme ?? // Use widget's icon theme if provided
                  nTheme
                      ?.current
                      ?.appBarTheme
                      .iconTheme ?? // Fallback to neumorphic app bar theme
                  nTheme?.current?.iconTheme ?? // Fallback to neumorphic theme
                  const IconThemeData(), // Default empty icon theme
              child: NavigationToolbar(
                leading: leading, // Leading widget
                middle: title, // Title widget
                trailing: actions, // Actions widget
                centerMiddle: widget._getEffectiveCenterTitle(
                  theme,
                  nTheme!.current!,
                ), // Center title based on effective setting
                middleSpacing: widget.titleSpacing, // Apply title spacing
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Handler for opening the drawer
  void _handleDrawerButton() {
    Scaffold.of(context).openDrawer();
  }

  // Handler for opening the end drawer
  void _handleDrawerButtonEnd() {
    Scaffold.of(context).openEndDrawer();
  }
}

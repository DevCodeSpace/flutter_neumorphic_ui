import 'package:flutter/material.dart';

/// A simple widget to display a block of code-like text
class Code extends StatelessWidget {
  final String text;

  const Code(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8), // Padding around the text
      color: Colors.grey.withAlpha(
        50,
      ), // Light grey background with transparency
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black.withAlpha(200), // Slightly transparent black text
        ),
      ),
    );
  }
}

/// A stateful widget that animates between integer values
class MyIntWidget extends StatefulWidget {
  final int value; // The value to animate to

  const MyIntWidget({super.key, required this.value});

  @override
  State<MyIntWidget> createState() => _MyIntWidgetState();
}

class _MyIntWidgetState extends State<MyIntWidget>
    with TickerProviderStateMixin {
  late int _value; // Internal state of the current integer value
  late AnimationController _controller; // Controls the animation
  late Animation<int> _valueAnimation; // Animates between old and new integer

  @override
  void initState() {
    _value = widget.value; // Initialize with the first value
    _controller = AnimationController(
      duration: Duration(milliseconds: 300), // Animation duration
      vsync: this, // Required for AnimationController
    );
    super.initState();
  }

  /// Called when the parent widget updates and a new value is passed
  @override
  void didUpdateWidget(MyIntWidget oldWidget) {
    // If the value has changed, animate to the new value
    if (oldWidget.value != widget.value) {
      _controller.reset(); // Reset the controller before starting new animation

      // Animate from the current value to the new value
      _valueAnimation =
          IntTween(begin: _value, end: widget.value).animate(_controller)
            ..addListener(() {
              // Update the internal value as the animation progresses
              setState(() {
                _value = _valueAnimation.value;
              });
            });

      _controller.forward(); // Start the animation
    }
    super.didUpdateWidget(oldWidget);
  }

  /// Dispose the animation controller to avoid memory leaks
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Build the widget showing the current animated integer value
  @override
  Widget build(BuildContext context) {
    return Text("current : $_value");
  }
}

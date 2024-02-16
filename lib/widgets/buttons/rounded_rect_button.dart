import 'package:flutter/material.dart';

class RoundedRectButton extends StatefulWidget {
  /// Creates rectangular button with rounded corners.
  const RoundedRectButton({super.key,
    required this.onPressed,
    required this.text,
    this.height,
    this.width,
    this.color
  });


  /// [onPressed] Called when button pressed.
  final Function onPressed;
  /// [text] Text that describes what button is doing.
  final Text text;
  /// [height] Optional parameter that adjusts button height.
  final double? height;
  /// [width] Optional parameter that adjusts button width.
  final double? width;
  /// [color] Optional parameter that defines button background color.
  final Color? color;

  @override
  State<RoundedRectButton> createState() => _RoundedRectButtonState();
}

class _RoundedRectButtonState extends State<RoundedRectButton> {

  Function? _onPressed;
  Text? _text;
  double _height = 56;
  double _width = 164;
  Color? _color = const Color.fromARGB(255, 44, 94, 70);

  @override
  void initState() {
    _onPressed = widget.onPressed;
    _text = widget.text;
    _height = widget.height != null ? widget.height! : _height;
    _width = widget.width != null ? widget.width! : _width;
    _color = widget.color != null ? widget.color! : _color;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      width: _width,
      child: FilledButton(
        // Call user defined onPressed function here
        onPressed: () {
          _onPressed!();
        },
        style: FilledButton.styleFrom(
          backgroundColor: _color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
        ),
        child: _text,
      ),
    );
  }
}

import 'package:flutter/material.dart';


class LineButton extends StatefulWidget {
  const LineButton({
    super.key,
    required this.text,
    required this.onTap,
    this.leftIcon,
    this.rightIcon,
  });

  final String text;
  final Function onTap;
  final IconData? leftIcon;
  final IconData? rightIcon;

  @override
  State<LineButton> createState() => _LineButtonState();
}

class _LineButtonState extends State<LineButton> {

  late String _text;
  late Function _onTap;
  IconData? _leftIcon;
  IconData? _rightIcon;

  @override
  void initState() {
    _text = widget.text;
    _onTap = widget.onTap;
    _leftIcon = widget.leftIcon;
    _rightIcon = widget.rightIcon ?? Icons.chevron_right;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          _onTap();
        },
        highlightColor: Colors.transparent,
        borderRadius: BorderRadius.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  _leftIcon,
                  size: 22,
                ),
                const Padding(padding: EdgeInsets.only(right: 15)),
                Text(
                  _text,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Icon(
              _rightIcon,
            )
          ],
        ),
      ),

    );
  }
}

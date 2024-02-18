import 'package:flutter/material.dart';


class CircleAvatarCustom extends StatefulWidget {
  const CircleAvatarCustom({
    super.key,
    required this.src,
    this.radius,
  });

  final String src;
  final double? radius;

  @override
  State<CircleAvatarCustom> createState() => _CircleAvatarCustomState();
}

class _CircleAvatarCustomState extends State<CircleAvatarCustom> {

  late String _src;
  double? _radius = 10.0;

  @override
  void initState() {
    _src = widget.src;
    _radius = widget.radius ?? _radius;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        splashColor: Colors.black26,
        onTap: (){},
        child: Ink.image(
          image: NetworkImage(_src),
          fit: BoxFit.cover, //Add this line for center crop or use 2nd way
          height: (_radius! * 2),
          width: (_radius! * 2),
        ),
      ),
    );
  }
}

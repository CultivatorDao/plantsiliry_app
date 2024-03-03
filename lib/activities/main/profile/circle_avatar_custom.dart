import 'package:flutter/material.dart';

import 'package:plantsility_app/services/storage.dart';

import 'package:plantsility_app/widgets/loading/chasing_dots_loading.dart';


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
        splashColor: Colors.transparent,
        onTap: (){},
        child: FutureBuilder(
          future: StorageService().downloadImage(_src),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Ink.image(
                image: NetworkImage(snapshot.data!),
                fit: BoxFit.cover, //Add this line for center crop or use 2nd way
                height: (_radius! * 2),
                width: (_radius! * 2),
              );
            }
            else {
              return const ChasingDotsLoading();
            }
          }
        ),
      ),
    );
  }
}

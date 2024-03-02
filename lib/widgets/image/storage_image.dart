import 'package:flutter/material.dart';

import 'package:plantsility_app/services/storage.dart';


class StorageImage extends StatefulWidget {
  /// Creates a widget that displays an ImageStream obtained from the Firebase Storage.
  const StorageImage({
    super.key,
    required this.src,
    this.imgScale,
    this.width,
    this.height,
  });

  final String src;
  final double? imgScale;
  final double? width;
  final double? height;

  @override
  State<StorageImage> createState() => _StorageImageState();
}

class _StorageImageState extends State<StorageImage> {

  late final String _src;
  late double _scale;
  late double _width;
  late double _height;

  @override
  void initState() {
    _src = widget.src;
    _scale = widget.imgScale ?? 1.0;
    _width = widget.width ?? 100.0;
    _height = widget.height ?? 100.0;

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      width: _width,
      child: FutureBuilder(
        future: StorageService().downloadImage(_src),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Image.network(snapshot.data!, scale: _scale,);
          }
          else {
            return const Placeholder();
          }
        },
      ),
    );
  }
}


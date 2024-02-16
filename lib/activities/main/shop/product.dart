import 'package:flutter/material.dart';


class ProductPage extends StatefulWidget {
  const ProductPage(
      {
        super.key,
        required this.obj
      }
    );

  final dynamic obj;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.obj["name"]),
      ),
    );
  }
}

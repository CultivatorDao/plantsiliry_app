import 'package:flutter/material.dart';

import 'package:plantsility_app/services/storage.dart';
import 'package:plantsility_app/models/product.dart';
import 'package:plantsility_app/widgets/image/storage_image.dart';


class InformationCard extends StatefulWidget {
  /// Contains basic information about subject.
  ///
  /// Transition between shop and subject screen.
  const InformationCard(
      {
        super.key,
        this.obj,
        this.objPage,
      }
    );

  /// [obj] Class that contains all information about object of this card.
  final dynamic obj;
  /// [objPage] Widget that will be shown when card button is pressed.
  final Widget? objPage;

  @override
  State<InformationCard> createState() => _InformationCardState();
}

class _InformationCardState extends State<InformationCard> {

  dynamic _obj = ProductModel(
    name: "Peperomia Houseplant",
    frontImage: "placeholder.png"
  );
  Widget? _objPage = const Placeholder();

  @override
  void initState() {
    _obj = widget.obj ?? _obj;
    _objPage = widget.objPage ?? _objPage;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration:  BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 52,
            spreadRadius: 0,
            offset: const Offset(0, 40)
          )
        ]
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18)
        ),
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StorageImage(
                src: _obj.frontImage,
                imgScale: 0.8,
                width: 154,
                height: 176,
              ),

              Container(
                padding: const EdgeInsets.only(left: 7, top: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                     SizedBox(
                      width: 90,
                      child: Text(
                        _obj.name,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontSize: 12
                        ),
                      )
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => _objPage!)
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_circle_right_sharp,
                        color: Color.fromARGB(255, 44, 94, 70),
                      ),
                      iconSize: 32,
                      highlightColor: Colors.transparent,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

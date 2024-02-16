import 'package:flutter/material.dart';


class InformationCard extends StatefulWidget {
  const InformationCard(
      {
        super.key,
        this.obj,
        this.objPage,
      }
    );

  /// [obj] Class that contains all information about object of this card.
  // TODO define specialized class for obj
  final dynamic obj;
  /// [objPage] Widget that will be shown when card button is pressed.
  final Widget? objPage;

  @override
  State<InformationCard> createState() => _InformationCardState();
}

class _InformationCardState extends State<InformationCard> {

  Map<String, String> _obj = {
    "name": "Peperomia Houseplant",
    "image": "https://growfully.com/wp-content/uploads/2021/06/peperomia-in-pot.jpg"
  };
  Widget? _objPage = const Placeholder();
  String _name = "";
  String? _image = "https://growfully.com/wp-content/uploads/2021/06/peperomia-in-pot.jpg";

  @override
  void initState() {
    _obj = widget.obj ?? _obj;
    _objPage = widget.objPage ?? _objPage;
    _name = _obj["name"]!;
    _image = _obj["image"]!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 52,
            spreadRadius: 0,
            offset: const Offset(0, 20)
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
            children: [
              SizedBox(
                width: 154,
                height: 196,
                child: Image.network(_image!)
              ),
              Container(
                padding: const EdgeInsets.only(left: 7, top: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                     SizedBox(
                      width: 90,
                      child: Text(
                        _name,
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

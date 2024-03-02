import 'package:flutter/material.dart';

import 'package:plantsility_app/models/product.dart';

import 'package:plantsility_app/widgets/buttons/rounded_rect_button.dart';
import 'package:plantsility_app/activities/main/shop/comment.dart';

import 'package:plantsility_app/widgets/image/storage_image.dart';


class ProductPage extends StatefulWidget {
  const ProductPage(
      {
        super.key,
        required this.obj
      }
    );

  final ProductModel obj;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  List<String> categories = <String>["MOST INTERESTING", "LATEST"];
  String _currentCategory = "";

  late ProductModel _obj;

  @override
  void initState() {
    _currentCategory = categories.first;

    _obj = widget.obj;

    super.initState();
  }

  // create product images
  List<StorageImage> createImageList() {
    List<StorageImage> images = [];
    for (String image in _obj.images!) {
      images.add(
        StorageImage(
          src: image,
          width: 375,
          height: 336,
        )
      );
    }
    return images;
  }

  // comments create function

  // comments sorting function

  @override
  Widget build(BuildContext context) {

    debugPrint(_obj.images.toString());

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 1,
              color: const Color.fromARGB(255, 226, 227, 228),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: 336,
                child: Row(
                  children: createImageList(),
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Available",
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontSize: 12
                        ),
                      ),
                      Row(
                        children: <IconButton>[
                          IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
                          IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_add_outlined)),
                        ],
                      )
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _obj.name,
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 18
                        ),
                      ),

                      const Padding(padding: EdgeInsets.only(bottom: 4)),

                      Row(
                        children: <Widget>[
                          Text(
                            "\$${_obj.hasDiscount! ? _obj.discountPrice : _obj.originalPrice}",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          const Padding(padding: EdgeInsets.only(right: 8)),
                          Text(
                              _obj.hasDiscount! ? "" : "\$${_obj.originalPrice}",
                            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.lineThrough
                            ),
                          )
                        ],
                      ),

                      const Padding(padding: EdgeInsets.only(bottom: 24))
                    ],
                  ),

                  RoundedRectButton(
                    width: double.infinity,
                    onPressed: () {},
                    text: Text(
                      "View on Website",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white),
                    )
                  ),

                  Container(
                    height: 1,
                    color: const Color.fromARGB(255, 226, 227, 228),
                    margin: const EdgeInsets.symmetric(vertical: 24),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 8)),
                      Text(
                        _obj.description.toString(),
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.5
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),

            Container(height: 4, color: const Color.fromARGB(255, 226, 227, 228),),

            Container(
              padding: const  EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text("0 Reviews"),
                      // TextButton(onPressed: () {}, child: const Text("Most Interesting")),
                      DropdownButton(
                          value: _currentCategory,
                          underline: const Text(''),
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 44, 94, 70),
                          ),
                          iconEnabledColor: const Color.fromARGB(255, 44, 94, 70),
                          items: categories.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _currentCategory = newValue!;
                            });
                          }
                      )
                    ],
                  ),

                  const Column(
                    children: [
                      CommentWidget()
                    ],
                  )

                ],
              ),
            )


          ],
        ),
      ),
    );
  }
}

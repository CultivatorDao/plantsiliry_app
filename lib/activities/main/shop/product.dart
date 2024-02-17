import 'package:flutter/material.dart';
import 'package:plantsility_app/activities/main/shop/comment.dart';

import 'package:plantsility_app/widgets/buttons/rounded_rect_button.dart';


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

  List<String> categories = <String>["MOST INTERESTING", "LATEST"];
  String _currentCategory = "";

  // basic variables: name, images, price, discount, description, comments, isBookmarked.

  @override
  void initState() {
    _currentCategory = categories.first;

    super.initState();
  }

  // product data handler function

  // comments create function

  // comments sorting function

  @override
  Widget build(BuildContext context) {
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
                  //TODO: change to image widget
                  children: [
                    Container(width: 375, height: 336, color: Colors.red,),
                    Container(width: 375, height: 336, color: Colors.red,),
                  ],
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
                        "Lorem Ipsum",
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 18
                        ),
                      ),

                      const Padding(padding: EdgeInsets.only(bottom: 4)),

                      Row(
                        children: <Widget>[
                          Text(
                            "\$89.99",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          const Padding(padding: EdgeInsets.only(right: 8)),
                          Text(
                            "\$89.99",
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
                        "Continue the next evolution of speed with a racing shoe made to you help chase new goals and records."
                        " The Nike ZoomX Vapor-fly Next% 2 builds on the model racers everywhere love."
                        " It helps improve comfort and breathability with a redesigned upper."
                        " From a 10K to a marathon, the 2 still has the responsive cushioning and secure support to push you towards your personal best."
                        "\n\nColour Shown: Aurora Green/Chlorine Blue/Pale Ivory/Black"
                        "\n\nStyle: CU4111-300",
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

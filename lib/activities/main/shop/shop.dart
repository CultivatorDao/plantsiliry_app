import 'package:flutter/material.dart';

import 'package:plantsility_app/widgets/info_card/info_card.dart';
import 'package:plantsility_app/activities/main/shop/product.dart';


Map<String, String> info = {
  "name": "Peperomia Houseplant",
  "image": "https://growfully.com/wp-content/uploads/2021/06/peperomia-in-pot.jpg"
};


class Shop extends StatefulWidget {
  /// Contains cards of all company selling products.
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {

  // TODO implement function that gets information from FireBase as List and return List of Information Cards
  List<Widget> createProductList(List data) {
    List<Widget> productList = [];
    for (dynamic obj in data) {
      productList.add(InformationCard(obj: obj, objPage: ProductPage(obj: obj,),));
    }
    return productList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shop",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded))
        ],
      ),
      // body: TextButton(onPressed: () {
      //   _auth.signOut();
      // }, child: const Text("Sign Out")),
      body: Column(
        children: <Widget>[
          Container(
            color: const Color.fromARGB(255, 226, 227, 228),
            height: 1,
          ),

          Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 26,
                childAspectRatio: (175 / 275),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 35),
              children: <Widget>[
                InformationCard(obj: info, objPage: ProductPage(obj: info),),
                InformationCard(),
                InformationCard(),
                InformationCard(),
                InformationCard(),
              ],
            ),
          )

        ],
      ),
    );
  }
}

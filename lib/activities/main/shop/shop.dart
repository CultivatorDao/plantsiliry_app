import 'package:flutter/material.dart';

import 'package:plantsility_app/services/database.dart';
import 'package:plantsility_app/models/product.dart';

import 'package:plantsility_app/widgets/info_card/info_card.dart';
import 'package:plantsility_app/activities/main/shop/product.dart';
import 'package:plantsility_app/widgets/loading/chasing_dots_loading.dart';


class Shop extends StatefulWidget {
  /// Contains cards of all company selling products.
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {

  // used to set list of displayed products
  List<Widget> createProductList(List<ProductModel>? data) {
    /// Get product list from database
    List<Widget> productList = [];

    if (data == null) {
      return productList;
    }
    for (ProductModel obj in data) {
      productList.add(
        InformationCard(
          obj: obj,
          objPage: ProductPage(obj: obj,),
        )
      );
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
      body: StreamBuilder(
        initialData: null,
        stream: DatabaseService().products,
        builder: (context, snapshot) {
          final productData = snapshot.data;


          if (productData != null) {
            return Column(
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
                    children: createProductList(productData),
                  ),
                )

              ],
            );
          }
          else {
            return const ChasingDotsLoading();
          }


        }
      ),
    );
  }
}

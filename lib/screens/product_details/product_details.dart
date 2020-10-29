import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_iota_tech_task/models/product.dart';

import 'components/size_chooser.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen({@required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            ListView(
              padding: EdgeInsets.only(
                  bottom: 80),
              children: [
                Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  product.name.toUpperCase(),
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(product.price(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
                Divider(color: Colors.grey),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Image.network(
                    product.mainImage,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, bottom: 5),
                  child: Text(
                    'BRAND: ' + product.brandName.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, bottom: 5),
                  child: Text(
                    'COLOUR: ' + product.colour.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: SizeChooser(
                    product: product,
                  ),
                ))
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import '../../models/product.dart';

class ProductSummaryGrid extends StatelessWidget {
  final Product productData;

  ProductSummaryGrid({this.productData});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Image.network(
                  productData.mainImage,
                  semanticLabel: "Image of " + productData.name,
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  child: Center(
                    child: Text(
                      productData.name,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )))
        ],
      ),
    );
  }
}

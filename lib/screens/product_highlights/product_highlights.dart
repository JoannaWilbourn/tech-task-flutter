import 'package:flutter/material.dart';
import 'package:one_iota_tech_task/screens/product_highlights/product_summary_grid.dart';

import '../../models/product.dart';

class ProductHighlights extends StatelessWidget {
  final Future<List<Product>> productHighlights;
  final ValueChanged<Product> onTapped;

  ProductHighlights({this.productHighlights, this.onTapped});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: OrientationBuilder(
        builder: (context, orientation) {
          var horizontalTiles = orientation == Orientation.portrait? 1 : 3;
          return FutureBuilder<List<Product>>(
            future: productHighlights,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: horizontalTiles,
                    ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final product = snapshot.data[index];
                      return GestureDetector(
                          onTap: () => onTapped(product),
                          child: ProductSummaryGrid(productData: product));
                    });
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          );
        },
      ),
    );
  }
}

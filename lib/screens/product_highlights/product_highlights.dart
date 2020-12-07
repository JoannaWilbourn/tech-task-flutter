import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tech_task_flutter/global_store.dart';
import 'package:tech_task_flutter/screens/product_highlights/product_summary_grid.dart';
import 'package:tech_task_flutter/models/product.dart';

class ProductHighlights extends StatelessWidget {
  final Future<List<Product>> productHighlights;
  final ValueChanged<Product> onTapped;


  ProductHighlights({this.productHighlights, this.onTapped});

  @override
  Widget build(BuildContext context) {
    final Config configStore = Provider.of<Config>(context);
    return Scaffold(
      appBar: AppBar( title:  Observer(builder: (_) { return Text(configStore.productHighlight); })),
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

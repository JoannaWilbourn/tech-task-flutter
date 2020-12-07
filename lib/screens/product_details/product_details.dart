import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tech_task_flutter/models/product.dart';
import 'package:tech_task_flutter/screens/product_details/components/size_chooser.dart';
import 'package:tech_task_flutter/global_store.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen({@required this.product});

  @override
  Widget build(BuildContext context) {
    final Config configStore = Provider.of<Config>(context);
    return Scaffold(
        appBar: AppBar( title:  Observer(builder: (_) { return Text(configStore.productHighlight); })),
        body: OrientationBuilder(builder: (context, orientation) {
          return Stack(children: [
            ListView(
              padding: EdgeInsets.only(bottom: 80),
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name.toUpperCase(),
                        softWrap: true,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(product.price(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                ),
                Divider(thickness: 1),
                Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: (orientation == Orientation.portrait
                        ? _portraitProductDetails(product: product)
                        : _landscapeProductDetails(product: product)))
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
          ]);
        }));
  }

  _landscapeProductDetails({Product product}) {
    return Row(children: [
      Expanded(
          flex: 1,
          child: Image.network(
            product.mainImage,
            semanticLabel: "Image of " + product.name,
          )),
      Expanded(
          flex: 1,
          child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )),
                Text(
                  'COLOUR: ' + product.colour.toUpperCase(),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'BRAND: ' + product.brandName.toUpperCase(),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            )
                  )
      )
    ]);
  }

  _portraitProductDetails({Product product}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Image.network(
        product.mainImage,
        semanticLabel: "Image of " + product.name,
      ),
      Container(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Text(
            product.description,
            style: TextStyle(
              fontSize: 16,
            ),
          )),
      Text(
        'BRAND: ' + product.brandName.toUpperCase(),
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      Text(
        'COLOUR: ' + product.colour.toUpperCase(),
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    ]);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/product.dart';

class ProductHighlights extends StatelessWidget {
  final Future<List<Product>> productHighlights;
  final ValueChanged<Product> onTapped;

  ProductHighlights({this.productHighlights, this.onTapped});

  Widget _productSummary(Product productData) {
    return GestureDetector(
        onTap: () => onTapped(productData),
        child: Card(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Image.network(
                  productData.mainImage,
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(25),
                  child: Center(
                    child: Text(
                      productData.name,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Product>>(
        future: productHighlights,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final product = snapshot.data[index];
                  return _productSummary(product);
                });
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

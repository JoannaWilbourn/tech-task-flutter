import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_iota_tech_task/screens/product_details/product_details.dart';
import 'package:one_iota_tech_task/screens/product_highlights/product_highlights.dart';
import 'package:one_iota_tech_task/services/products_list.dart';

import 'models/product.dart';

void main() {
  runApp(ShoeShopApp());
}

class ShoeShopApp extends StatefulWidget {
  @override
  _ShoeShopAppState createState() => _ShoeShopAppState();
}

class _ShoeShopAppState extends State<ShoeShopApp> {
  Future<List<Product>> productHighlights;
  Product _selectedProduct;

  void initState() {
    super.initState();
    productHighlights = fetchProducts();
  }

  void _handleProductTapped(Product selected) {
    setState(() {
      _selectedProduct = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'One Iota Tech Task - Flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Navigator(
          pages: [
            MaterialPage(
                key: ValueKey('ProductHighlights'),
                child: ProductHighlights(
                    productHighlights: productHighlights,
                    onTapped: _handleProductTapped)),
            if (_selectedProduct != null)
              MaterialPage(
                key: ValueKey(_selectedProduct),
                child: ProductDetailsScreen(product: _selectedProduct),
              ),
          ],
          onPopPage: (route, result) {
            if (!route.didPop(result)) {
              return false;
            }

            // Update the list of pages by setting _selectedBook to null
            setState(() {
              _selectedProduct = null;
            });

            return true;
          },
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_task_flutter/global_store.dart';
import 'package:tech_task_flutter/screens/product_details/product_details.dart';
import 'package:tech_task_flutter/screens/product_highlights/product_highlights.dart';
import 'package:tech_task_flutter/services/products_list.dart';

import 'models/product.dart';

void main() {
  runApp(ShoeShopApp());
}

class ShoeShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Provider<Config>(
      create: (_) => Config(),
      child: LandingPage());
}


class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
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

            setState(() {
              _selectedProduct = null;
            });

            return true;
          },
        ));
  }
}

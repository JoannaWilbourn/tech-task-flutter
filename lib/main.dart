import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

List<Product> parseProducts(String responseBody) {
  final parsed = json.decode(responseBody)['data'].cast<Map<String, dynamic>>();
  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}

Product parseProduct(String responseBody, String id) {
  final parsed = json.decode(responseBody)['data'].cast<Map<String, dynamic>>();
  return Product.fromJson(parsed[int.parse(id) - 1]);
}

Future<List<Product>> fetchProducts() async {
  final response = await http.get(
      'https://s3-eu-west-1.amazonaws.com/api.themeshplatform.com/products.json');
  if (response.statusCode == 200) {
    return parseProducts(response.body);
  } else {
    throw Exception('Failed to load product highlights');
  }
}

Future<Product> fetchProduct(String id) async {
  final response = await http.get(
      'https://s3-eu-west-1.amazonaws.com/api.themeshplatform.com/products.json');
  if (response.statusCode == 200) {
    return parseProduct(response.body, id);
  } else {
    throw Exception('Failed to load product highlights');
  }
}

class Product {
  final String id;
  final String name;
  final String mainImage;
  final String skuCode;
  final String brandName;
  final List<String> sizes;
  final String stockStatus;
  final String colour;
  final String description;
  final String priceCurrency;
  final String priceAmount;

  Product(
      {this.id,
      this.name,
      this.mainImage,
      this.skuCode,
      this.brandName,
      this.colour,
      this.description,
      this.sizes,
      this.stockStatus,
      this.priceAmount,
      this.priceCurrency});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      mainImage: json['mainImage'],
      skuCode: json['SKU'],
      brandName: json['brandName'],
      colour: json['colour'],
      description: json['description'],
      priceAmount: json['price']['amount'],
      priceCurrency: json['price']['currency'],
      sizes: (json['sizes']).cast<String>(),
    );
  }
  String price() {
    var formatCurrency = NumberFormat.simpleCurrency();
    return formatCurrency.simpleCurrencySymbol(priceCurrency) +
        ' ' +
        priceAmount;
  }
}

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
                  bottom: 50), // Must be a better way to do this?
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
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    product.description,
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
                  child: AddToBasket(sizes: product.sizes),
                ))
          ],
        ));
  }
}

class AddToBasket extends StatelessWidget {
  final List<String> sizes;

  AddToBasket({@required this.sizes});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('ADD TO BAG'),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) =>
                Column(mainAxisSize: MainAxisSize.min, children: [
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                              child: Text('SELECT A SIZE'),
                              padding: EdgeInsets.only(left: 20))),
                      Align(
                          child: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                          alignment: Alignment.centerRight)
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                      child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 6,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: sizes.length,
                          itemBuilder: (context, index) {
                            final size = sizes[index];
                            return OutlineButton(
                              onPressed: null,
                              child: Text(size),
                            );
                          })),
                  Row(children: [
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.all(20),
                            child: ElevatedButton(
                              child: Text('ADD TO BAG'),
                            )))
                  ]),
                ]));
      },
    );
  }
}

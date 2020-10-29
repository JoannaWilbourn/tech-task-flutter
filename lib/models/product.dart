import 'package:intl/intl.dart';

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

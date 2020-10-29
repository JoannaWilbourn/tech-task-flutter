import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/product.dart';

Future<List<Product>> fetchProducts() async {
  final response = await http.get(
      'https://s3-eu-west-1.amazonaws.com/api.themeshplatform.com/products.json');
  if (response.statusCode == 200) {
    return parseProducts(response.bodyBytes);
  } else {
    throw Exception('Failed to load product highlights');
  }
}

List<Product> parseProducts(List<int> responseBody) {
  final parsed = json.decode(utf8.decode(responseBody))['data']
      .cast<Map<String, dynamic>>();
  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}

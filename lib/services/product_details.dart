import 'dart:convert';

import '../models/product.dart';
import 'package:http/http.dart' as http;

Future<Product> fetchProduct(String id) async {
  final response = await http.get(
      'https://s3-eu-west-1.amazonaws.com/api.themeshplatform.com/products.json');
  if (response.statusCode == 200) {
    return parseProduct(response.bodyBytes, id);
  } else {
    throw Exception('Failed to load product highlights');
  }
}

Product parseProduct(List<int> responseBody, String id) {
  final parsed = json
      .decode(utf8.decode(responseBody))['data']
      .cast<Map<String, dynamic>>();
  return Product.fromJson(parsed[int.parse(id) - 1]);
}

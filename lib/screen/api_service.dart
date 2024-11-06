import 'dart:convert';

import 'package:e_commerce_app/screen/model.dart';
import 'package:http/http.dart' as http;



class ApiService {
  final String productsUrl = 'https://prethewram.pythonanywhere.com/api/parts_categories/';
  final String categoriesUrl = 'https://prethewram.pythonanywhere.com/api/Top_categories/';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(productsUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse(categoriesUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
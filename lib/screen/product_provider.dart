
import 'package:e_commerce_app/screen/api_service.dart';
import 'package:e_commerce_app/screen/model.dart';
import 'package:flutter/material.dart';

class ProductCategoryProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Product> _products = [];
  List<Category> _categories = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;

  Future<void> fetchProductsAndCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _apiService.fetchProducts();
      _categories = await _apiService.fetchCategories();
    } catch (e) {
      print('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
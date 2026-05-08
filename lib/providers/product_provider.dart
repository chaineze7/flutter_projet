import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_api_service.dart';

class ProductProvider with ChangeNotifier {
  final ProductApiService _apiService;

  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  ProductProvider({ProductApiService? apiService})
      : _apiService = apiService ?? ProductApiService();

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = null;

    try {
      _products = await _apiService.fetchProducts();
    } catch (e) {
      _error = 'Impossible de charger les produits.';
      _products = _apiService.getMockProducts();
    } finally {
      _isLoading = false;
      // fetchSeries() est async : quand on arrive ici, le build est terminé.
      // notifyListeners() peut donc être appelé.
      notifyListeners();
    }
  }

  Future<Product> fetchProductById(int id) async {
    return _apiService.fetchProductById(id);
  }
}

import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_api_service.dart';


// Provider responsable du chargement de articles depuis l'API
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


  // Charge les produits depuis l' API REST
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
      
      //  Notifie tous les widgets qui écoutent ce provider
      notifyListeners();
    }
  }

  Future<Product> fetchProductById(int id) async {
    return _apiService.fetchProductById(id);
  }
}

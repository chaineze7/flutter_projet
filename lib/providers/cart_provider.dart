import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';
import '../services/cart_database_service.dart';

class CartProvider with ChangeNotifier {
  final CartDatabaseService _dbService;

  List<CartItem> _items = [];
  bool _isLoading = false;

  List<CartItem> get items => _items;
  bool get isLoading => _isLoading;
  int get itemCount => _items.length;

  bool  estDansLePanier(int productId) {
    return _items.any((item) => item.product.id == productId);
  }

  CartProvider({CartDatabaseService? dbService})
      : _dbService = dbService ?? CartDatabaseService() {
    _chargerPanier();
  }

  Future<void> _chargerPanier() async {
    _isLoading = true;
    notifyListeners();

    try {
      _items = await _dbService.getCart();
    } catch (_) {
      _items = [];
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> ajouterProduit(Product product) async {

    final index = _items.indexWhere((i) => i.product.id == product.id);

     if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }

    await _dbService.saveCart(_items);
    notifyListeners();
  }

  Future<void> retirerProduit(int productId) async {
    _items.removeWhere((i) => i.product.id == productId);

    await _dbService.saveCart(_items);
    notifyListeners();
  }
}
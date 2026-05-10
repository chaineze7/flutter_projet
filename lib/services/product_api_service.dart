import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';


class ProductApiService {
  static const _baseUrl = 'https://api.escuelajs.co/api/v1';

  static const _timeout = Duration(seconds: 10);

  final http.Client _client;

  ProductApiService({http.Client? client}) : _client = client ?? http.Client();

  // Récupère tous les produits depuis l'API
  Future<List<Product>> fetchProducts({int page = 0}) async {
    final uri = Uri.parse('$_baseUrl/products?page=$page');
    final response = await _client.get(uri).timeout(_timeout);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((j) => Product.fromJson(j)).toList();
    }
    throw Exception('Erreur HTTP ${response.statusCode}');
  }

  Future<Product> fetchProductById(int id) async {
    final uri = Uri.parse('$_baseUrl/products/$id');
    final response = await _client.get(uri).timeout(_timeout);

    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    }
    throw Exception('Produit $id introuvable');
  }

  /// Données de secours si réseau indisponible.
  List<Product> getMockProducts() => [
      const Product(
        id: 0,
        title: 'Mode hors ligne',
        description:
            'Pas de connexion réseau.',
        price: 0,
        imageUrl: '',
        category: '-',
      ),
  ];
}

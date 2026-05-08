import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductApiService {
  static const _baseUrl = 'https://fakeapi.platzi.com/';

  final http.Client _client;

  ProductApiService({http.Client? client}) : _client = client ?? http.Client();

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
      nom: 'Mode hors-ligne',
      description: 'Pas de connexion réseau.',
      price: '-',
      category: '-',
    ),
  ];
}

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_projet/providers/product_provider.dart';
import 'package:flutter_projet/services/product_api_service.dart';
import 'package:flutter_projet/models/product.dart';

class MockApiService extends ProductApiService {
  @override
  Future<List<Product>> fetchProducts({int page = 0}) async {
    return [
      Product(
        id: 1,
        title: 'Mock',
        description: 'desc',
        price: 10,
        imageUrl: null,
        category: 'cat',
      )
    ];
  }
}

void main() {
  group('ProductProvider', () {
    test('état initial vide', () {
      final provider = ProductProvider();

      expect(provider.products, isEmpty);
      expect(provider.isLoading, false);
    });

    test('fetchProducts charge produits', () async {
      final provider = ProductProvider(apiService: MockApiService());

      await provider.fetchProducts();

      expect(provider.products.length, 1);
      expect(provider.products.first.title, 'Mock');
    });
  });
}
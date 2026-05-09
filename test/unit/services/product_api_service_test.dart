import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_projet/services/product_api_service.dart';

import '../../mocks/mock_http_client.dart';
import '../../helpers/test_data.dart';

void main() {
  group('ProductApiService', () {

    test('fetchProducts retourne une liste de produits', () async {
      final service = ProductApiService(
        client: MockHttpClient(body: mockProductsJson),
      );

      final products = await service.fetchProducts();

      expect(products.length, 2);

      
      expect(products.map((p) => p.id), containsAll([1, 2]));

      expect(
        products.map((p) => p.title),
        containsAll([
          'Sleek White & Orange Wireless Gaming Controller',
          'Sleek Wireless Headphone & Inked Earbud Set',
        ]),
      );
    });

    test('fetchProducts lève une exception si erreur HTTP 500', () {
      final service = ProductApiService(
        client: MockHttpClient(statusCode: 500, body: ''),
      );

      expect(() => service.fetchProducts(), throwsException);
    });

    test('fetchProductById retourne un produit', () async {
      final service = ProductApiService(
        client: MockHttpClient(body: mockProductsJson[0]),
      );

      final product = await service.fetchProductById(1);

      expect(product.id, 1);
      expect(
        product.title,
        'Sleek White & Orange Wireless Gaming Controller',
      );
    });

    test('getMockProducts retourne une liste non vide', () {
      final service = ProductApiService();

      expect(service.getMockProducts(), isNotEmpty);
    });
  });
}
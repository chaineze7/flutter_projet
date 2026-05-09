import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_projet/models/product.dart';
import 'package:flutter_projet/providers/favoris_provider.dart';
import 'package:flutter_projet/services/preferences_service.dart';

class MockPreferencesService extends PreferencesService {
  List<Product> _data = [];

  @override
  Future<List<Product>> getFavoris() async => _data;

  @override
  Future<void> saveFavoris(List<Product> favoris) async {
    _data = favoris;
  }
}

void main() {
  group('FavorisProvider', () {
    FavorisProvider makeProvider() =>
        FavorisProvider(prefsService: MockPreferencesService());

    final testProduct = Product(
      id: 1,
      title: 'Test',
      description: '',
      price: 10,
      imageUrl: null,
      category: 'cat',
    );

    test('démarre vide', () async {
      final provider = makeProvider();
      await Future.delayed(const Duration(milliseconds: 50));

      expect(provider.favoris, isEmpty);
    });

    test('toggleFavori ajoute un produit', () async {
      final provider = makeProvider();
      await Future.delayed(const Duration(milliseconds: 50));

      await provider.toggleFavori(testProduct);

      expect(provider.favoris.length, 1);
    });

    test('toggleFavori retire un produit', () async {
      final provider = makeProvider();
      await Future.delayed(const Duration(milliseconds: 50));

      await provider.toggleFavori(testProduct);
      await provider.toggleFavori(testProduct);

      expect(provider.favoris, isEmpty);
    });

    test('estFavori fonctionne', () async {
      final provider = makeProvider();
      await Future.delayed(const Duration(milliseconds: 50));

      await provider.toggleFavori(testProduct);

      expect(provider.estFavori(testProduct.id), true);
    });
  });
}